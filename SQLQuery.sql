--AdventureWorks2019 database

--select id, person type, first name and last name for each persons where the same first lettes first and last name are the same like yours.
Select BusinessEntityID, PersonType, FirstName, LastName
From Person.Person
Where FirstName like 'T%' and LastName like 'C%'

--select persons with first name Adam, order records by last name ascending
Select *
From Person.Person
Where FirstName = 'Adam'
Order by LastName ASC

--select id, name, number, list price for all red products, order records by list price descending
Select ProductID, [Name], ProductNumber, ListPrice
From Production.Product
Where Color = 'Red'
Order by ListPrice DESC

--select id, name, number, list price, size for all products with size M
Select ProductID, [Name], ProductNumber, ListPrice, Size
From Production.Product
Where Size = 'M'

--select id, name, sales person id for all stores where sales person id is 275 or 276 or 278
Select BusinessEntityID, [Name], SalesPersonID
From Sales.Store
Where SalesPersonID IN (275,276,278)

--select sales order detail for sales order id is greater than 69000 and less than 70000
Select *
From Sales.SalesOrderDetail
Where SalesOrderID > 69000 And SalesOrderID < 70000

--. select all employees employed as specialists
Select *
From HumanResources.Employee
Where JobTitle = 'Specialists'

--select only vendors with purchasing web service
Select *
From Purchasing.Vendor
Where PurchasingWebServiceURL != 'NULL'

--select only products with an unspecified class
Select *
From Production.Product
Where Class IS NULL

-- select only sales order ordered in 2014 on the territory of Australia
Select *
From Sales.SalesOrderHeader
Where TerritoryID = 9 and OrderDate Like '%2014%'

--select count of products for each product color: color, count
Select Color, COUNT(*) As TotalProducts
From Production.Product
Group by Color

--select minimum, maximum and average of vacation hours for each job title of employee: job title, min, max, avg
Select JobTitle, MIN(VacationHours) As MinVacationHours, MAX(VacationHours) As MaxVacationHours, AVG(VacationHours) As AvgVacationHours
From HumanResources.Employee
Group by JobTitle

-- select sum of product quantity for each ordered product: product name, sum
Select [Name] As ProductName, SUM(OrderQty) As TotalOrderQuantity
From Production.Product INNER JOIN Sales.SalesOrderDetail
On Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
Group by [Name]

--select sum of order subtotal for each territory: territory name, sum
Select [Name] As TerritoryName, SUM(SubTotal) As TotalSubTotal
From Sales.SalesTerritory INNER JOIN Sales.SalesOrderHeader
ON Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID
Group by [Name]

--select how many employees, with the same first lettes first and last name like yours, work in each department: department name, count
Select [Name] As DepartmentName, COUNT(*) As TotalEmployees
From HumanResources.Department  INNER JOIN HumanResources.EmployeeDepartmentHistory
On HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
INNER JOIN Person.Person 
On Person.Person.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
Where FirstName LIKE 'T%' AND LastName LIKE 'C%'
Group by [Name]

--select count of products and average of list price for each product category: category, count, average
Select PPC.[Name] As Category, COUNT(*) As TotalProducts, AVG(PP.ListPrice) As AvgListPrice
From  Production.Product As PP INNER JOIN Production.ProductSubCategory As PPSC
On PP.ProductSubcategoryID = PPSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory As PPC
On PPC.ProductCategoryID = PPSC.ProductCategoryID
Group by PPC.[Name]

--select top 5 the most frequently ordered products
Select Top 5 [Name] As ProductName, SUM(OrderQty) As TotalOrderedProducts
From Production.Product INNER JOIN Sales.SalesOrderDetail
On Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
Group by [Name]
Order by TotalOrderedProducts DESC

--select customers which placed order exactly 5 times
Select CustomerID, COUNT(AccountNumber) As TotalOrders
From Sales.SalesOrderHeader
Where CustomerID IN ( Select CustomerID
From Sales.SalesOrderHeader
Group by CustomerID
Having COUNT(AccountNumber) = 5)
Group by CustomerID;
