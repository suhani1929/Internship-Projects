USE ecommerce;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    Row_id TEXT,
    Order_id TEXT,
    Order_date TEXT,
    Ship_date TEXT,
    Ship_mode TEXT,
    Customer_id TEXT,
    Customer_name TEXT,
    Segment TEXT,
    Country TEXT,
    City TEXT,
    State TEXT,
    Postal_code INTEGER,
    Region TEXT,
    Product_id TEXT,
    Product_Category TEXT,
    Product_Sub_Category TEXT,
    Product_Name TEXT,
    Sales REAL,
    Quantity INTEGER,
    Discount REAL,
    Profit REAL
);


SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Retail_Sales_Dataset.csv'
INTO TABLE retail_sales
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Check for the NULLs in the Table
SELECT * FROM retail_sales
WHERE Order_id IS NULL OR Product_Name IS NULL OR SALES IS NULL; 

-- Calculate Profit Margins by Category/Sub-Category
SELECT
   Product_Category,
   Product_Sub_Category,
   SUM(Sales) AS Total_Sales,
   SUM(Profit) AS Total_Profit,
   ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM retail_sales
GROUP BY Product_Category, Product_Sub_Category
ORDER BY Profit_Margin_Percentage DESC ;




