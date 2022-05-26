CREATE PROCEDURE [dbo].[LoadInternetSales]
as

truncate table dbo.factInternetSales

--CREATE TABLE [dbo].[factInternetSales] (
--    [SalesOrderID]         INT             NULL,
--    [SalesOrderNumber]     NVARCHAR (20)   NULL,
--    [SalesOrderDetailID]   INT             NULL,
--    [DateKey]              INT             NULL,
--    [CustomerKey]          INT             NULL,
--    [ProductKey]           INT             NULL,
--    [CurrencyKey]          INT             NULL,
--    [OrderQuantity]        SMALLINT        NULL,
--    [UnitPrice]            MONEY           NULL,
--    [ExtendedAmount]       MONEY           NULL,
--    [UnitPriceDiscountPct] NUMERIC (38, 6) NULL,
--    [DiscountAmount]       MONEY           NULL,
--    [ProductStandardCost]  MONEY           NULL,
--    [TotalProductCost]     MONEY           NULL,
--    [SalesAmount]          MONEY           NULL,
--    [CreatedDate]          DATETIME        NULL,
--    [ModifiedDate]         DATETIME        NULL
--);

INSERT INTO dbo.factInternetSales
(
	[SalesOrderID],
	[SalesOrderNumber],
	[SalesOrderDetailID],
	[DateKey],
	[CustomerKey],
	[ProductKey],
	[CurrencyKey],
	[OrderQuantity],
	[UnitPrice],
	[ExtendedAmount],
	[UnitPriceDiscountPct],
	[DiscountAmount],
	[ProductStandardCost],
	[TotalProductCost],
	[SalesAmount],
	[CreatedDate],
	[ModifiedDate]
)
SELECT
	OH.SalesOrderID AS [SalesOrderID],
	OH.SalesOrderNumber AS [SalesOrderNumber],
	OD.SalesOrderDetailID AS [SalesOrderDetailID],
	DD.DateKey AS [DateKey],
	DC.CustomerKey AS [CustomerKey],
	DP.ProductKey AS [ProductKey],
	DCu.CurrencyKey AS [CurrencyKey],
	OD.OrderQty AS [OrderQuantity],
	OD.UnitPrice/DCu.AverageRate AS [UnitPrice],
	OD.UnitPrice*OD.OrderQty/DCu.AverageRate AS [ExtendedAmount],
	OD.UnitPriceDiscount/DCu.AverageRate AS [UnitPriceDiscountPct],
	(OD.UnitPriceDiscount*OD.UnitPrice*OD.OrderQty)/DCu.AverageRate AS [DiscountAmount],
	DP.StandardCost/DCu.AverageRate AS [ProductStandardCost],
	(DP.StandardCost*OD.OrderQty)/DCu.AverageRate AS [TotalProductCost],
	OD.UnitPrice*OD.OrderQty-OD.UnitPriceDiscount*OD.UnitPrice*OD.OrderQty/DCu.AverageRate AS [SalesAmount],
	GETDATE() AS [CreatedDate],
	GETDATE() AS [ModifiedDate]

FROM stg.Sales_SalesOrderHeader AS OH JOIN
	stg.Sales_SalesOrderDetail AS OD ON OH.SalesOrderID = OD.SalesOrderID
	JOIN dbo.DimCustomer AS DC ON OH.CustomerID = DC.CustomerID
	JOIN dbo.DimProduct AS DP ON DP.ProductID = OD.ProductID
	LEFT JOIN dbo.DimCurrency AS DCu ON DCu.CurrencyKey = OH.CurrencyRateID 
	LEFT JOIN dbo.DimDate AS DD ON OH.OrderDate = DD.Date
WHERE OH.OnlineOrderFlag = 1