--AdventureWorks2019 Database

--select id, name, number, model name for all products with model like �Sport�
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

--select id, product name, vendor name for all vendors who selling product in unit of measure like �Pack�
Select PP.ProductID, PP.[Name], PV.[Name]
From Production.Product AS PP 
INNER JOIN Purchasing.ProductVendor AS PPV
ON PP.ProductID = PPV.ProductID
INNER JOIN Purchasing.Vendor AS PV
ON PPV.BusinessEntityID = PV.BusinessEntityID
INNER JOIN Production.UnitMeasure AS PUM
ON PPV.UnitMeasureCode = PUM.UnitMeasureCode
Where PUM.[Name] Like 'Pack'

--select id, customer name, territory name, person name, store name for all customers