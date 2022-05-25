CREATE TABLE [stg].[Sales_Store] (
    [BusinessEntityID] INT              NULL,
    [Name]             NVARCHAR (50)    NULL,
    [SalesPersonID]    INT              NULL,
    [Demographics]     NVARCHAR (MAX)   NULL,
    [rowguid]          UNIQUEIDENTIFIER NULL,
    [ModifiedDate]     DATETIME         NULL,
    [Timestamp]        DATETIME         DEFAULT (getdate()) NULL
);

