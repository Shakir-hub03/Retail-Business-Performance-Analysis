-- =====================================================
-- Retail Business Performance Analysis
-- Profitability Analysis 
-- =====================================================

-- Profitability by Region
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY region
ORDER BY profit_margin DESC;

-- Profitability by Segment
SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders
FROM superstore
GROUP BY segment
ORDER BY profit_margin DESC;

-- Profitability by Category
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY category
ORDER BY profit_margin DESC;

-- Profitability by sub-category
Select sub_category,
ROUND(SUM(sales),2) total_sales,
ROUND(SUM(profit),2) total_profit,
ROUND(SUM(profit)*100 / SUM(sales),2) profit_margin,
SUM(quantity) total_quantity
From superstore
GROUP BY sub_category
ORDER BY profit_margin DESC;

-- Discount vs Profit
SELECT
    discount,
    COUNT(*) AS transactions,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY discount
ORDER BY discount;

-- Discount by Category
SELECT
    category,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY category
ORDER BY avg_discount_percentage DESC;

-- Discount by Sub-category
SELECT
    sub_category,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY sub_category
ORDER BY avg_discount_percentage DESC;

-- High Discount Transactions
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.20 THEN 'Low Discount'
        WHEN discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_category,
    COUNT(*) AS transactions,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY discount_category
ORDER BY total_sales DESC;

-- Loss-making Orders
SELECT
    COUNT(*) AS loss_making_transactions,
    ROUND(SUM(sales), 2) AS sales_from_loss_transactions,
    ROUND(SUM(profit), 2) AS total_loss
FROM superstore
WHERE profit < 0;

-- Loss-Making Products Count
SELECT
    COUNT(*) AS loss_making_products
FROM (
    SELECT product_id
    FROM superstore
    GROUP BY product_id
    HAVING SUM(profit) < 0
) AS loss_products;

-- Products With High Sales but Negative Profit
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
HAVING SUM(profit) < 0
ORDER BY total_sales DESC
LIMIT 15;

-- Monthly Profitability
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;
