CREATE TABLE [stg].[Pearson_BusinessEntityAddress] (
    [BusinessEntityID] INT              NULL,
    [AddressID]        INT              NULL,
    [AddressTypeID]    INT              NULL,
    [rowguid]          UNIQUEIDENTIFIER NULL,
    [ModifiedDate]     DATETIME         NULL,
    [Timestamp]        DATETIME         DEFAULT (getdate()) NULL
);

