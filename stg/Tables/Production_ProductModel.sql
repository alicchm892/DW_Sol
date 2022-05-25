CREATE TABLE [stg].[Production_ProductModel] (
    [ProductModelID]     INT              NULL,
    [Name]               NVARCHAR (50)    NULL,
    [CatalogDescription] NVARCHAR (MAX)   NULL,
    [Instructions]       NVARCHAR (MAX)   NULL,
    [rowguid]            UNIQUEIDENTIFIER NULL,
    [ModifiedDate]       DATETIME         NULL,
    [Timestamp]          DATETIME         DEFAULT (getdate()) NULL
);

