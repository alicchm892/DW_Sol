CREATE PROCEDURE [dbo].[LoadResellerSales]
as

truncate table dbo.factResellerSales

--CREATE TABLE [dbo].[factResellerSales] (
--    [SalesOrderID]         INT             NULL,
--    [SalesOrderNumber]     NVARCHAR (20)   NULL,
--    [SalesOrderDetailID]   INT             NULL,
--    [DateKey]              INT             NULL,
--    [ResellerKey]          INT             NULL,
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

INSERT INTO dbo.factResellerSales
(
	[SalesOrderID],
	[SalesOrderNumber],
	[SalesOrderDetailID],
	[DateKey],
	[ResellerKey],
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
	DR.ResellerKey AS [ResellerKey],
	DP.ProductKey AS [ProductKey],
	DC.CurrencyKey AS [CurrencyKey],
	OD.OrderQty AS [OrderQuantity],
	OD.UnitPrice/DC.AverageRate AS [UnitPrice],
	OD.UnitPrice*OD.OrderQty/DC.AverageRate AS [ExtendedAmount],
	OD.UnitPriceDiscount/DC.AverageRate AS [UnitPriceDiscountPct],
	(OD.UnitPriceDiscount*OD.UnitPrice*OD.OrderQty)/DC.AverageRate AS [DiscountAmount],
	DP.StandardCost/DC.AverageRate AS [ProductStandardCost],
	(DP.StandardCost*OD.OrderQty)/DC.AverageRate AS [TotalProductCost],
	OD.UnitPrice*OD.OrderQty-OD.UnitPriceDiscount*OD.UnitPrice*OD.OrderQty/DC.AverageRate AS [SalesAmount],
	GETDATE() AS [CreatedDate],
	GETDATE() AS [ModifiedDate]

FROM stg.Sales_SalesOrderHeader AS OH JOIN
	stg.Sales_SalesOrderDetail AS OD ON OH.SalesOrderID = OD.SalesOrderID
	JOIN dbo.DimReseller AS DR ON OH.CustomerID = DR.CustomerID
	LEFT JOIN dbo.DimProduct AS DP ON DP.ProductID = OD.ProductID
	LEFT JOIN dbo.DimCurrency AS DC ON DC.CurrencyKey = OH.CurrencyRateID 
	LEFT JOIN dbo.DimDate AS DD ON OH.OrderDate = DD.Date