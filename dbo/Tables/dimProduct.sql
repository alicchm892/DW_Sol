CREATE TABLE [dbo].[dimProduct] (
    [ProductKey]          INT           IDENTITY (1, 1) NOT NULL,
    [ProductID]           INT           NOT NULL,
    [ProductName]         NVARCHAR (50) NOT NULL,
    [ProductAlternateKey] NVARCHAR (50) NOT NULL,
    [StandardCost]        MONEY         NOT NULL,
    [ListPrice]           MONEY         NOT NULL,
    [DaysToManufacture]   INT           NOT NULL,
    [ProductCategoryID]   INT           NOT NULL,
    [ProductCategoryName] NVARCHAR (50) NOT NULL,
    [ProductModelID]      INT           NOT NULL,
    [ProductModelName]    NVARCHAR (50) NOT NULL,
    [SellStartDate]       DATETIME      NOT NULL,
    [SellEndDate]         DATETIME      NOT NULL,
    [SourceModifiedDate]  DATETIME      NOT NULL,
    [CreatedDate]         DATETIME      DEFAULT (getdate()) NULL,
    [ModifiedDate]        DATETIME      NULL
);

