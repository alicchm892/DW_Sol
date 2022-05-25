CREATE TABLE [stg].[Sales_SalesOrderDetail] (
    [SalesOrderID]          INT              NULL,
    [SalesOrderDetailID]    INT              NULL,
    [CarrierTrackingNumber] NVARCHAR (25)    NULL,
    [OrderQty]              SMALLINT         NULL,
    [ProductID]             INT              NULL,
    [SpecialOfferID]        INT              NULL,
    [UnitPrice]             MONEY            NULL,
    [UnitPriceDiscount]     MONEY            NULL,
    [LineTotal]             NUMERIC (38, 6)  NULL,
    [rowguid]               UNIQUEIDENTIFIER NULL,
    [ModifiedDate]          DATETIME         NULL,
    [Timestamp]             DATETIME         DEFAULT (getdate()) NULL
);

