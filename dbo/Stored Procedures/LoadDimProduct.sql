CREATE procedure [dbo].[LoadDimProduct] as
	
	drop table if exists #products

	select 
		P.ProductID as [ProductID],
		P.Name as [ProductName],
		P.ProductNumber as [ProductAlternateKey],
		P.StandardCost as [StandardCost],
		P.ListPrice as [ListPrice],
		P.DaysToManufacture as [DaysToManufacture],
		isnull(PC.ProductCategoryID,-1) as [ProductCategoryID],
		isnull(PC.Name,'N/D') as [ProductCategoryName],
		isnull(PM.ProductModelID,-1) as [ProductModelID],
		isnull(PM.Name,'N/D') as [ProductModelName],
		P.SellStartDate as [SellStartDate],
		isnull(P.SellEndDate,cast('99991231' as datetime)) as [SellEndDate],
		P.ModifiedDate as [SourceModifiedDate]
	into #products
	from [stg].[Production_Product] P
	left join [stg].[Production_ProductModel] PM on P.ProductModelID = PM.ProductModelID
	left join [stg].[Production_ProductSubcategory] PS on P.ProductSubcategoryID = PS.ProductSubcategoryID
	left join [stg].[Production_ProductCategory] PC on PS.ProductCategoryID = PC.ProductCategoryID

	--select * from #products

	update a
	set
		[ProductID]	= b.[ProductID],	
		[ProductName] = b.[ProductName], 
		[ProductAlternateKey] = b.[ProductAlternateKey],
		[StandardCost] = b.[StandardCost], 
		[ListPrice] = b.[ListPrice], 
		[DaysToManufacture] = b.[DaysToManufacture], 
		[ProductCategoryID] = b.[ProductCategoryID], 
		[ProductCategoryName] = b.[ProductCategoryName],
		[ProductModelID] = b.[ProductModelID], 
		[ProductModelName] = b.[ProductModelName], 
		[SellStartDate] = b.[SellStartDate], 
		[SellEndDate] = b.[SellEndDate],
		[SourceModifiedDate] = b.[SourceModifiedDate], 
		[ModifiedDate] = getdate()
	from [dbo].[dimProduct] a
	join #products b on a.ProductID = b.ProductID
	where
		a.[ProductID]	!= b.[ProductID]
		or a.[ProductName] != b.[ProductName]
		or a.[ProductAlternateKey] != b.[ProductAlternateKey]
		or a.[StandardCost] != b.[StandardCost]
		or a.[ListPrice] != b.[ListPrice]
		or a.[DaysToManufacture] != b.[DaysToManufacture]
		or a.[ProductCategoryID] != b.[ProductCategoryID]
		or a.[ProductCategoryName] != b.[ProductCategoryName]
		or a.[ProductModelID] != b.[ProductModelID]
		or a.[ProductModelName] != b.[ProductModelName]
		or a.[SellStartDate] != b.[SellStartDate]
		or a.[SellEndDate] != b.[SellEndDate]
		or a.[SourceModifiedDate] != b.[SourceModifiedDate]

	insert into [dbo].[dimProduct](
		[ProductID], [ProductName], [ProductAlternateKey], [StandardCost], [ListPrice], [DaysToManufacture], [ProductCategoryID],
		[ProductCategoryName], [ProductModelID], [ProductModelName], [SellStartDate], [SellEndDate], [SourceModifiedDate],
		[CreatedDate], [ModifiedDate])
	select b.*, getdate(), getdate()
	from [dbo].[dimProduct] a
	right join #products b on a.ProductID = b.ProductID
	where a.ProductID is null

