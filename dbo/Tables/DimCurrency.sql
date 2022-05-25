CREATE TABLE [dbo].[DimCurrency] (
    [CurrencyKey]      INT           NULL,
    [Name]             NVARCHAR (50) NULL,
    [CurrencyRateDate] DATETIME      NULL,
    [FromCurrencyCode] NVARCHAR (3)  NULL,
    [ToCurrencyCode]   NVARCHAR (3)  NULL,
    [AverageRate]      MONEY         NULL,
    [EndOfDayRate]     MONEY         NULL,
    [CreatedDate]      DATETIME      NULL
);

