select   id.ProductID
	   , be.MasterWarehouseID
	   , ih.InvoiceDate as [Date]
	   , SUM(id.Qty) as [Quantity]
	   , COUNT(*) as [NumInvoices]
	   , COUNT(DISTINCT CustomerID) as [NumCustomers]

from [SalesOrderDetail] id 
JOIN [SalesOrderHeader] ih ON id.InvoiceID = ih.InvoiceID
JOIN [Branches] be ON ih.ShippingBranchID = be.BranchID

where YEAR(ih.InvoiceDate) IN (2016, 2017, 2018, 2019)

group by id.ProductID, be.MasterWarehouseID, ih.InvoiceDate