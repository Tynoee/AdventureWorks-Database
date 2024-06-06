--AdventureWorks 2019 database

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
Select AdventureWorks2019.Sales.Customer.CustomerID, COUNT(*) AS SalesOrderCount
From AdventureWorks2019.Sales.SalesOrderHeader
JOIN AdventureWorks2019.Sales.Customer 
ON AdventureWorks2019.Sales.SalesOrderHeader.CustomerID = AdventureWorks2019.Sales.Customer.CustomerID
JOIN AdventureWorks2019.Sales.SalesOrderDetail
ON AdventureWorks2019.Sales.SalesOrderHeader.SalesOrderID = AdventureWorks2019.Sales.SalesOrderDetail.SalesOrderID
Group by AdventureWorks2019.Sales.Customer.CustomerID
Having Count(*) = 5