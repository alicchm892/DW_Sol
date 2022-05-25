CREATE TABLE [stg].[Sales_CurrencyRate] (
    [CurrencyRateID]   INT          NULL,
    [CurrencyRateDate] DATETIME     NULL,
    [FromCurrencyCode] NVARCHAR (3) NULL,
    [ToCurrencyCode]   NVARCHAR (3) NULL,
    [AverageRate]      MONEY        NULL,
    [EndOfDayRate]     MONEY        NULL,
    [ModifiedDate]     DATETIME     NULL,
    [Timestamp]        DATETIME     DEFAULT (getdate()) NULL
);

