

CREATE PROCEDURE [dbo].[LoadDimCustomer]
as

--CREATE TABLE [dbo].[DimCustomer] (
--    [CustomerKey]          INT           IDENTITY (1, 1) NOT NULL,
--    [CustomerID]           INT           NOT NULL,
--    [CustomerAlternateKey] VARCHAR (10)  NOT NULL,
--    [PersonType]           NCHAR (2)     NOT NULL,
--    [Title]                NVARCHAR (8)  NOT NULL,
--    [FirstName]            NVARCHAR (50) NOT NULL,
--    [MiddleName]           NVARCHAR (50) NOT NULL,
--    [LastName]             NVARCHAR (50) NOT NULL,
--    [NameStyle]            BIT           NOT NULL,
--    [EmailPromotion]       INT           NOT NULL,
--    [Suffix]               NVARCHAR (10) NOT NULL,
--    [EmailAddress]         NVARCHAR (50) NOT NULL,
--    [PhoneNumber]          NVARCHAR (25) NOT NULL,
--    [CreatedDate]          DATETIME      NULL,
--    [ModifiedDate]         DATETIME      NULL
--);


truncate table dbo.DimCustomer


INSERT INTO dbo.DimCustomer
(
	[CustomerID],
	[CustomerAlternateKey],
	[PersonType],
	[Title],
	[FirstName],
	[MiddleName],
	[LastName],
	[NameStyle],
	[EmailPromotion],
	[Suffix],
	[EmailAddress],
	[PhoneNumber],
	[CreatedDate],
	[ModifiedDate]
)


SELECT
	C.CustomerID AS [CustomerID],
	C.AccountNumber AS [CustomerAlternateKey],
	P.PersonType AS [PersonType],
	ISNULL(P.Title, 'N/D') AS [Title],
	P.FirstName AS [FirstName],
	ISNULL(P.MiddleName, 'N/D') AS [MiddleName],
	P.LastName AS [LastName],
	P.NameStyle AS [NameStyle],
	P.EmailPromotion AS [EmailPromotion],
	ISNULL(P.Suffix, 'N/D') AS [Suffix],
	ISNULL(EA.EmailAddress, 'N/D') AS [EmailAddress],
	ISNULL(PP.PhoneNumber, 'N/D') AS [PhoneNumber],
	-- audyt kolumny
	GETDATE() as [CreatedDate],
	P.Timestamp as [ModifiedDate]

FROM stg.Sales_Customer AS C
JOIN stg.Pearson_Pearson AS P
	ON C.PersonID = P.BusinessEntityID
LEFT JOIN stg.Pearson_EmailAddress AS EA 
	ON P.BusinessEntityID = EA.BusinessEntityID
LEFT JOIN stg.Pearson_PersonPhone AS PP 
	ON P.BusinessEntityID = PP.BusinessEntityID