-- =====================================================
-- Retail Business Performance Analysis
-- Sales Analysis 
-- =====================================================

-- Sales by Month
Select YEAR(order_date) order_year, MONTH(order_date) order_month,
ROUND(SUM(sales),2) total_sales
From superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- Sales by Year
Select YEAR(order_date) order_year, 
ROUND(SUM(sales),2) total_sales, ROUND(SUM(profit),2) total_profit,
COUNT(DISTINCT order_id) total_orders
From superstore
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- Sales by Region
Select region, ROUND(SUM(sales),2) total_sales,
COUNT(DISTINCT order_id) total_orders,
COUNT(DISTINCT customer_id) total_customers
From superstore
GROUP BY region
ORDER BY ROUND(SUM(sales),2) DESC;

-- Profit by Region
Select region, ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit, ROUND(SUM(profit)*100 / SUM(sales),2) profit_margin
From superstore
GROUP BY region
ORDER BY ROUND(SUM(profit),2) DESC;

-- Sales by Customer Segment
Select segment,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit,
COUNT(DISTINCT order_id) total_orders,
COUNT(DISTINCT customer_id) total_customers
From superstore
GROUP BY segment
ORDER BY ROUND(SUM(sales),2) DESC;

-- Sales by Category
Select category,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit,
ROUND(SUM(profit)*100 / SUM(sales),2) profit_margin,
SUM(quantity) total_quantity
From superstore
GROUP BY category
ORDER BY ROUND(SUM(sales),2) DESC;

-- Sales by sub-category
Select sub_category,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit,
ROUND(SUM(profit)*100 / SUM(sales),2) profit_margin,
SUM(quantity) total_quantity
From superstore
GROUP BY sub_category
ORDER BY ROUND(SUM(sales),2) DESC;

-- Top 10 products by sales
Select product_id, product_name, category, sub_category,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit
From superstore
GROUP BY product_id, product_name, category, sub_category
ORDER BY ROUND(SUM(sales),2) DESC
LIMIT 10;

-- Top 10 products by profit
Select product_id, product_name, category, sub_category,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit
From superstore
GROUP BY product_id, product_name, category, sub_category
ORDER BY ROUND(SUM(profit),2) DESC
LIMIT 10;

-- Bottom 10 products by profit
Select product_id, product_name, category, sub_category,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit
From superstore
GROUP BY product_id, product_name, category, sub_category
ORDER BY ROUND(SUM(profit),2) 
LIMIT 10;

-- Sales by shipmode
Select ship_mode,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit, COUNT(DISTINCT order_id) total_orders
From superstore
GROUP BY ship_mode
ORDER BY ROUND(SUM(sales),2) DESC;

-- Highest Sales Month
Select YEAR(order_date) order_year, MONTH(order_date) order_month,
ROUND(SUM(sales),2) total_sales
From superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY ROUND(SUM(sales),2) DESC
LIMIT 1;

-- Lowest Sales Month
Select YEAR(order_date) order_year, MONTH(order_date) order_month,
ROUND(SUM(sales),2) total_sales
From superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY ROUND(SUM(sales),2)
LIMIT 1;