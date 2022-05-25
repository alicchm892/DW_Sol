CREATE TABLE [stg].[Sales_Customer] (
    [CustomerID]    INT              NULL,
    [PersonID]      INT              NULL,
    [StoreID]       INT              NULL,
    [TerritoryID]   INT              NULL,
    [AccountNumber] VARCHAR (10)     NULL,
    [rowguid]       UNIQUEIDENTIFIER NULL,
    [ModifiedDate]  DATETIME         NULL,
    [Timestamp]     DATETIME         DEFAULT (getdate()) NULL
);

