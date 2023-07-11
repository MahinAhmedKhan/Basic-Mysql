-- Query #1: Get the maximum quantity and count of rows in the tr_orderdetails table
SELECT 
    MAX(Quantity) AS MaxQuantity,
    COUNT(*) AS TotalRows
FROM 
    tr_orderdetails;

-- Query #2: Get distinct ProductID and Quantity where Quantity is 3, ordered by ProductID ascending and Quantity descending
SELECT DISTINCT
    ProductID,
    Quantity
FROM 
    tr_orderdetails
WHERE 
    Quantity = 3
ORDER BY 
    ProductID ASC, 
    Quantity DESC;

-- Query #3: Get distinct PropertyID from tr_orderdetails
SELECT DISTINCT
    PropertyID
FROM 
    tr_orderdetails;

-- Query #4: Count the number of products in each ProductCategory, ordered by count in descending order
SELECT
    ProductCategory,
    COUNT(*) AS COUNT
FROM 
    tr_products
GROUP BY 
    ProductCategory
ORDER BY 
    COUNT DESC;

-- Query #5: Count the number of properties in each PropertyState, ordered by count in descending order
SELECT
    PropertyState,
    COUNT(*) AS COUNT
FROM 
    tr_propertyinfo
GROUP BY 
    PropertyState
ORDER BY 
    COUNT DESC;

-- Query #6: Get the total quantity of each ProductID, ordered by total quantity in descending order, limit to 5 rows
SELECT 
    ProductID,
    SUM(Quantity) AS Total_Quantity
FROM 
    tr_orderdetails
GROUP BY 
    ProductID
ORDER BY 
    Total_Quantity DESC
LIMIT 5;

-- Query #7: Get the total quantity of each PropertyID, ordered by total quantity in descending order, limit to 5 rows
SELECT 
    PropertyID,
    SUM(Quantity) AS Total_Quantity
FROM 
    tr_orderdetails
GROUP BY 
    PropertyID
ORDER BY 
    Total_Quantity DESC
LIMIT 5;

-- Query #8: Get detailed order information including product details using a left join
SELECT 
    o.*,
    p.ProductName,
    p.ProductCategory,
    p.Price
FROM 
    tr_orderdetails AS o
LEFT JOIN 
    tr_products AS p ON o.ProductID = p.ProductID;

-- Query #8.1: Get total sales for each product by multiplying quantity with price and summing them up, ordered by sales in descending order, limit to 5 rows
SELECT 
    p.ProductName,
    SUM(o.Quantity * p.Price) AS Sales 
FROM 
    tr_orderdetails AS o
LEFT JOIN 
    tr_products AS p ON o.ProductID = p.ProductID
GROUP BY 
    p.ProductName
ORDER BY 
    Sales DESC
LIMIT 5;

-- Query #9: Get total sales for each property city by multiplying quantity with price and summing them up, ordered by sales in descending order, limit to 5 rows
SELECT 
    pi.PropertyCity,
    SUM(o.Quantity * p.Price) AS Sales 
FROM 
    tr_orderdetails AS o
LEFT JOIN 
    tr_products AS p ON o.ProductID = p.ProductID
LEFT JOIN 
    tr_propertyinfo AS pi ON o.PropertyID = pi.`Prop ID`
GROUP BY 
    pi.PropertyCity
ORDER BY 
    Sales DESC
LIMIT 5;

-- Query #10: Get total sales for each product in Arlington city by multiplying quantity with price and summing them up, ordered by sales in descending order, limit to 5 rows
SELECT 
    pi.PropertyCity,
    p.ProductName,
    SUM(o.Quantity * p.Price) AS Sales 
FROM 
    tr_orderdetails AS o
LEFT JOIN 
    tr_products AS p ON o.ProductID = p.ProductID
LEFT JOIN 
    tr_propertyinfo AS pi ON o.PropertyID = pi.`Prop ID`
WHERE 
    pi.PropertyCity = 'Arlington'
GROUP BY 
    pi.PropertyCity, p.ProductName
ORDER BY 
    Sales DESC
LIMIT 5;
