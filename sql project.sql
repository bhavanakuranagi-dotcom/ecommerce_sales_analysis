CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE sales(
Order_Date DATE,
Product_Name VARCHAR(50),
Category VARCHAR(50),
Region VARCHAR(50),
Quantity INT,
Sales FLOAT,
Profit FLOAT
);

SELECT SUM(Sales) AS TotalSales
FROM sales;

SELECT SUM(Profit)
FROM sales;

SELECT AVG(Sales)
FROM sales;

SELECT Category,
SUM(Sales)
FROM sales
GROUP BY Category;

SELECT Category,
SUM(Profit)
FROM sales
GROUP BY Category;

SELECT Region,
SUM(Sales)
FROM sales
GROUP BY Region;

SELECT Region,
SUM(Profit)
FROM sales
GROUP BY Region;

SELECT `Product Name`,
       SUM(Sales) AS Total_Sales
FROM sales
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT
MONTH(`Order Date`) AS Month_No,
SUM(Sales) AS Total_Sales
FROM sales
GROUP BY MONTH(`Order Date`);

SELECT Region,
SUM(Sales)
FROM sales
GROUP BY Region
ORDER BY SUM(Sales) DESC;

SELECT Category,
SUM(Profit)
FROM sales
GROUP BY Category
ORDER BY SUM(Profit) DESC;

SELECT * FROM sales;

SELECT COUNT(*) AS Total_Orders
FROM sales;

SELECT SUM(Sales) AS Total_Sales
FROM sales;

SELECT SUM(Profit) AS Total_Profit
FROM sales;

SELECT SUM(Quantity) AS Total_Quantity
FROM sales;

SELECT MAX(Sales) AS Highest_Sale
FROM sales;

SELECT MIN(Sales) AS Lowest_Sale
FROM sales;

SELECT DISTINCT Category
FROM sales;

SELECT Category,
SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Category;


SELECT
    YEAR(`Order Date`) AS Year,
    MONTHNAME(`Order Date`) AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`), MONTHNAME(`Order Date`)
ORDER BY YEAR(`Order Date`), MONTH(`Order Date`);

SELECT
    YEAR(`Order Date`) AS Year,
    MONTHNAME(`Order Date`) AS Month,
    SUM(Sales) AS Monthly_Sales,
    LAG(SUM(Sales)) OVER (
        ORDER BY YEAR(`Order Date`), MONTH(`Order Date`)
    ) AS Previous_Month_Sales,
    ROUND(
        (
            SUM(Sales) - LAG(SUM(Sales)) OVER (
                ORDER BY YEAR(`Order Date`), MONTH(`Order Date`)
            )
        ) /
        LAG(SUM(Sales)) OVER (
            ORDER BY YEAR(`Order Date`), MONTH(`Order Date`)
        ) * 100,
        2
    ) AS Growth_Percentage
FROM sales
GROUP BY
    YEAR(`Order Date`),
    MONTH(`Order Date`),
    MONTHNAME(`Order Date`);
    
    
   SELECT
`Product Name`,
Profit,
CASE
    WHEN Profit >= 300 THEN 'High Profit'
    WHEN Profit >= 100 THEN 'Medium Profit'
    ELSE 'Low Profit'
END AS Profit_Level
FROM sales; 
  
  
SELECT *
FROM (
    SELECT
        Category,
        `Product Name`,
        SUM(Sales) AS Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS Rank_No
    FROM sales
    GROUP BY Category, `Product Name`
) t
WHERE Rank_No = 1;

SELECT
COUNT(*) AS Total_Orders,
SUM(Sales) AS Total_Sales,
SUM(Profit) AS Total_Profit,
SUM(Quantity) AS Total_Quantity,
AVG(Sales) AS Avg_Sales,
AVG(Profit) AS Avg_Profit,
MAX(Sales) AS Highest_Sale,
MIN(Sales) AS Lowest_Sale
FROM sales;