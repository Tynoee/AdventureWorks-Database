--AdventureWorks2019 Database

--select id, name, number, model name for all products with model like „Sport”
Select ProductID, PP.[Name], ProductNumber, PPM.[Name] AS ModelName
From Production.Product AS PP INNER JOIN Production.ProductModel AS PPM
On PP.ProductModelID = PPM.ProductModelID
Where PPM.[Name] Like '%Sport%'

--select id, person type, first name, last name and email address for all persons
Select PP.BusinessEntityID, PersonType, FirstName, LastName, EmailAddress
From Person.Person AS PP INNER JOIN Person.EmailAddress	AS PE
On PP.BusinessEntityID = PE.BusinessEntityID

--select id, name, subcategory, category for all products and order records by id ascending
Select ProductID, PP.[Name], PPS.[Name] AS SubCategory, PPC.[Name] AS Category
From Production.Product AS PP 
INNER JOIN Production.ProductSubcategory AS PPS
On PP.ProductSubcategoryID = PPS.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PPC
ON PPS.ProductCategoryID = PPC.ProductCategoryID
Order By ProductID ASC

--select id, product name, vendor name for all vendors who selling product in unit of measure like „Pack”
Select PP.ProductID, PP.[Name], PV.[Name]
From Production.Product AS PP 
INNER JOIN Purchasing.ProductVendor AS PPV
ON PP.ProductID = PPV.ProductID
INNER JOIN Purchasing.Vendor AS PV
ON PPV.BusinessEntityID = PV.BusinessEntityID
INNER JOIN Production.UnitMeasure AS PUM
ON PPV.UnitMeasureCode = PUM.UnitMeasureCode
Where PUM.[Name] Like 'Pack'

--select id, customer name, territory name, person name, store name for all customersSelect CustomerID, SST.[Name] AS TerritoryName, PP.FirstName,PP.LastName,  SS.[Name]  AS StoreNameFrom Sales.Customer AS SC LEFT JOIN Sales.SalesTerritory AS SST ON SC.TerritoryID = SST.TerritoryIDLEFT JOIN Sales.Store AS SS ON SC.StoreID = SS.BusinessEntityIDLEFT JOIN Sales.SalesPerson AS SSP ON SSP.[BusinessEntityID] = SS.[SalesPersonID]LEFT JOIN Person.Person AS PP ON SSp.BusinessEntityID = PP.BusinessEntityID--select only sales order ordered in 06-2014 on the territory of „France”Select SSOD.SalesOrderID, SSOH.OrderDate, SST.[Name]From Sales.SalesOrderDetail AS SSOD RIGHT JOIN Sales.SalesOrderHeader AS SSOHON SSOD.SalesOrderID = SSOH.SalesOrderIDRIGHT JOIN Sales.SalesTerritory AS SSTON SSOH.TerritoryID = SST.TerritoryIDWhere 1=1and convert(nvarchar(10),OrderDate,121) LIKE '%2014-06%' AND SST.[Name] = 'France'--select sales order details with special offers like „Sale”Select SSOD.*,SSO.*From Sales.SalesOrderDetail AS SSOD INNER JOIN Sales.SpecialOfferProduct AS SSOP On SSOD.ProductID = SSOP.ProductIDINNER JOIN Sales.SpecialOffer AS SSO On SSO.SpecialOfferID = SSOP.SpecialOfferIDWhere SSO.[description] like '%Sale%'--select products which have not been ordered yetSelect PP.ProductID, PP.[Name], PP.ProductNumber, SSOH.OrderDateFrom Production.Product AS PPLEFT JOIN Sales.SalesOrderDetail AS SSOD On SSOD.ProductID = PP.ProductIDLEFT JOIN Sales.SalesOrderHeader AS SSOH ON SSOD.SalesOrderID = SSOH.SalesOrderIDWhere SSOH.OrderDate IS NULLOrder by PP.ProductID ASC