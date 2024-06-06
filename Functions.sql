--AdventureWorks2019 Database

--Never ordered products yet, use EXISTS: ProductName
SELECT ProductID, [Name]
FROM Production.Product AS PP
WHERE NOT EXISTS (
    SELECT 1
    FROM Sales.SalesOrderDetail AS SOD
    WHERE SOD.ProductID = PP.ProductID
);

--Quantity of products ordered in a given class, products without a class should be named ’No Class’: ClassName, OrderQuantity
SELECT
    CASE 
        WHEN PP.Class IS NULL OR PP.Class = '' THEN 'No Class'
        ELSE PP.Class
    END AS ClassName,
    SUM(sod.OrderQty) AS OrderQuantity
FROM Production.Product AS PP
LEFT JOIN Sales.SalesOrderDetail AS SOD ON PP.ProductID = SOD.ProductID
GROUP BY
    CASE 
        WHEN PP.Class IS NULL OR PP.Class = '' THEN 'No Class'
        ELSE PP.Class
    END;


--Top 3 best months of the year in terms of sales value: MonthName, SalesAmount
WITH MonthlySales AS (
    SELECT 
        DATENAME(MONTH, SSOH.OrderDate) AS MonthName,
        YEAR(SSOH.OrderDate) AS Year,
        SUM(SSOH.TotalDue) AS SalesAmount
    FROM Sales.SalesOrderHeader AS SSOH
    GROUP BY 
        DATENAME(MONTH, SSOH.OrderDate),
        MONTH(SSOH.OrderDate),
        YEAR(SSOH.OrderDate)
)
SELECT TOP 3 
    year,MonthName,
    SUM(SalesAmount) AS SalesAmount
FROM MonthlySales
GROUP BY year,MonthName
ORDER BY SalesAmount DESC;


--Dates of the last orders placed by employees in comparison to the current date: First and Last Name, Last Order Date, Current Date
SELECT 
    PP.FirstName,
    PP.LastName,
    MAX(SSOH.OrderDate) AS LastOrderDate,
    GETDATE() AS CurrentDate
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON HRE.BusinessEntityID = PP.BusinessEntityID
JOIN Sales.SalesOrderHeader SSOH ON HRE.BusinessEntityID = SSOH.SalesPersonID
GROUP BY 
    PP.FirstName, 
    PP.LastName
ORDER BY 
    LastOrderDate DESC;


--Quantity of products of each color, use Polish color names: PolishColorName, Quantity
SELECT 
    CASE 
        WHEN PP.Color = 'Black' THEN 'Czarny'
        WHEN PP.Color = 'Blue' THEN 'Niebieski'
        WHEN PP.Color = 'Grey' THEN 'Szary'
        WHEN PP.Color = 'Multi' THEN 'Wielokolorowy'
        WHEN PP.Color = 'Red' THEN 'Czerwony'
        WHEN PP.Color = 'Silver' THEN 'Srebrny'
        WHEN PP.Color = 'White' THEN 'Bia?y'
        ELSE 'Inny'
    END AS PolishColorName,
    COUNT(*) AS Quantity
FROM 
    Production.Product AS PP
GROUP BY 
    CASE 
        WHEN PP.Color = 'Black' THEN 'Czarny'
        WHEN PP.Color = 'Blue' THEN 'Niebieski'
        WHEN PP.Color = 'Grey' THEN 'Szary'
        WHEN PP.Color = 'Multi' THEN 'Wielokolorowy'
        WHEN PP.Color = 'Red' THEN 'Czerwony'
        WHEN PP.Color = 'Silver' THEN 'Srebrny'
        WHEN PP.Color = 'White' THEN 'Bia?y'
        ELSE 'Inny'
    END
ORDER BY 
    Quantity DESC;