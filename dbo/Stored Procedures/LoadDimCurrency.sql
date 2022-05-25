

CREATE PROCEDURE [dbo].[LoadDimCurrency]
as



--CREATE TABLE [dbo].[DimCurrency](
--	[CurrencyKey] [int] NULL,
--	[Name] nvarchar(50) NULL,
--	[CurrencyRateDate] [datetime] NULL,
--	[FromCurrencyCode] [nvarchar](3) NULL,
--	[ToCurrencyCode] [nvarchar](3) NULL,
--	[AverageRate] [money] NULL,
--	[EndOfDayRate] [money] NULL,
--	[CreatedDate] datetime
--);



truncate table dbo.DimCurrency


INSERT INTO dbo.DimCurrency
(
	[CurrencyKey],
	[Name],
	[CurrencyRateDate],
	[FromCurrencyCode],
	[ToCurrencyCode],
	[AverageRate],
	[EndOfDayRate],
	[CreatedDate]
)


SELECT
	CR.[CurrencyRateID] AS [CurrencyKey],
	C.[Name] AS [Name],
	CR.[CurrencyRateDate] AS [CurrencyRateDate],
	CR.[FromCurrencyCode] AS [FromCurrencyCode],
	CR.[ToCurrencyCode] AS [ToCurrencyCode],
	CR.[AverageRate] AS [AverageRate],
	CR.[EndOfDayRate] AS [EndOfDayRate],
	-- audyt kolumny
	GETDATE() as [CreatedDate]

FROM stg.Sales_CurrencyRate CR
JOIN stg.Sales_Currency C ON CR.ToCurrencyCode = C.CurrencyCode