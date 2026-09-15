-- =====================================================
-- Retail Business Performance Analysis
-- Data Exploration 
-- =====================================================

--  Total Records
SELECT COUNT(*) AS total_records From superstore;

-- First and Last Order date
Select MIN(order_date) First_Order, MAX(order_date) Last_Order From superstore;

-- Total Customers
Select COUNT(DISTINCT customer_id) Customers From superstore;

-- Total Orders 
Select COUNT(DISTINCT order_id) Orders From superstore;

-- Total Products 
Select COUNT(DISTINCT product_id) Products From superstore;

-- KPI Analysis
Select ROUND(SUM(sales),2) Total_sales, ROUND(SUM(profit),2) Total_profit,
SUM(quantity) Total_quantity, COUNT(DISTINCT order_id) Orders, COUNT(DISTINCT customer_id) Customers
From superstore;

-- Profitability Analysis
Select ROUND(SUM(sales),2) total_sales, ROUND(SUM(profit),2) total_profit,
ROUND(SUM(profit)*100 / SUM(sales),2) profit_margin, ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AOV
From superstore;