-- E-Commerce Sales Analysis SQL Project
CREATE DATABASE IF NOT EXISTS ecommerce_sales;
USE ecommerce_sales;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    `Order Date` DATE,
    `Product Name` VARCHAR(150),
    Category VARCHAR(100),
    Region VARCHAR(50),
    Quantity INT,
    Sales DECIMAL(10,2),
    Profit DECIMAL(10,2),
    Year INT,
    Month VARCHAR(20),
    Quarter VARCHAR(10),
    `profit margin` DECIMAL(10,2)
);

-- Import ecommerce_sales_cleaned.csv using Table Data Import Wizard

SELECT * FROM sales;
SELECT COUNT(*) AS Total_Orders FROM sales;
SELECT ROUND(SUM(Sales),2) AS Total_Sales FROM sales;
SELECT ROUND(SUM(Profit),2) AS Total_Profit FROM sales;
SELECT ROUND(AVG(Sales),2) AS Average_Sales FROM sales;
SELECT MAX(Sales) AS Highest_Sale FROM sales;
SELECT MIN(Sales) AS Lowest_Sale FROM sales;
SELECT SUM(Quantity) AS Total_Quantity FROM sales;

SELECT Category,SUM(Sales) AS Total_Sales
FROM sales GROUP BY Category ORDER BY Total_Sales DESC;

SELECT Category,SUM(Profit) AS Total_Profit
FROM sales GROUP BY Category ORDER BY Total_Profit DESC;

SELECT Region,SUM(Sales) AS Total_Sales
FROM sales GROUP BY Region ORDER BY Total_Sales DESC;

SELECT `Product Name`,SUM(Sales) AS Total_Sales
FROM sales GROUP BY `Product Name`
ORDER BY Total_Sales DESC LIMIT 10;

SELECT Month,SUM(Sales) AS Total_Sales
FROM sales GROUP BY Month
ORDER BY FIELD(Month,'January','February','March','April','May','June','July','August','September','October','November','December');

SELECT Year,SUM(Sales) AS Total_Sales
FROM sales GROUP BY Year;

SELECT Quarter,SUM(Sales) AS Total_Sales
FROM sales GROUP BY Quarter;

SELECT ROUND(AVG(`profit margin`),2) AS Avg_Profit_Margin FROM sales;

SELECT Category,ROUND(AVG(`profit margin`),2) AS Avg_Profit_Margin
FROM sales GROUP BY Category ORDER BY Avg_Profit_Margin DESC;

SELECT `Product Name`,Sales,
CASE
WHEN Sales>=1000 THEN 'High Sales'
WHEN Sales>=500 THEN 'Medium Sales'
ELSE 'Low Sales'
END AS Sales_Level
FROM sales;

SELECT `Product Name`,SUM(Sales) AS Total_Sales,
RANK() OVER(ORDER BY SUM(Sales) DESC) AS Product_Rank
FROM sales
GROUP BY `Product Name`;

SELECT `Order Date`,Sales,
LAG(Sales) OVER(ORDER BY `Order Date`) AS Previous_Sale
FROM sales;

SELECT `Order Date`,Sales,
SUM(Sales) OVER(ORDER BY `Order Date`) AS Running_Total
FROM sales;

SELECT
COUNT(*) AS Total_Orders,
COUNT(DISTINCT `Product Name`) AS Total_Products,
SUM(Sales) AS Total_Sales,
SUM(Profit) AS Total_Profit,
AVG(Sales) AS Average_Sales,
SUM(Quantity) AS Total_Quantity
FROM sales;
