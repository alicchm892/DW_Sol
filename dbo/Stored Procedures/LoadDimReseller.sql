CREATE procedure [dbo].[LoadDimReseller] as
	
	drop table if exists #resellers

	select 
		C.CustomerID as [CustomerID],
		C.AccountNumber as [ResellerAlternateKey],
		S.Name as [ResellerName]
	into #resellers
	from [stg].[Sales_Customer] C
	join [stg].[Sales_Store] S on C.StoreID = S.BusinessEntityID

	--select * from #resellers

	update a
	set
		[CustomerID] = b.[CustomerID],
		[ResellerAlternateKey] = b.[ResellerAlternateKey],
		[ResellerName] = b.[ResellerName],
		[ModifiedDate] = getdate()
	from [dbo].[dimReseller] a
	join #resellers b on a.CustomerID = b.CustomerID
	where
		a.[CustomerID] != b.[CustomerID]
		or a.[ResellerAlternateKey] != b.[ResellerAlternateKey]
		or a.[ResellerName] != b.[ResellerName]

	insert into [dbo].[dimReseller](
		[CustomerID], [ResellerAlternateKey], [ResellerName], [CreatedDate], [ModifiedDate])
	select b.*, getdate(), getdate()
	from [dbo].dimReseller a
	right join #resellers b on a.CustomerID = b.CustomerID
	where a.CustomerID is null