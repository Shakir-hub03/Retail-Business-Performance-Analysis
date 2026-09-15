-- =====================================================
-- Retail Business Performance Analysis
-- Product Performance Analysis 
-- =====================================================

-- Top 10 Products by Quantity Sold
SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY product_id, product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- Top 10 Products by Sales
SELECT
    product_id,
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity
FROM superstore
GROUP BY product_id, product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Products by Profit
SELECT
    product_id,
    product_name,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales,
    SUM(quantity) AS total_quantity
FROM superstore
GROUP BY product_id, product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Bottom 10 Products by Profit
SELECT
    product_id,
    product_name,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales,
    SUM(quantity) AS total_quantity
FROM superstore
GROUP BY product_id, product_name
ORDER BY total_profit ASC
LIMIT 10;

-- Products with Negative Profit
SELECT
    COUNT(*) AS loss_making_products
FROM (
    SELECT
        product_id,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY product_id
    HAVING SUM(profit) < 0
) AS product_summary;

-- Category Performance 
SELECT
    category,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- Sub-category Performance
SELECT
    sub_category,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC;

-- High Sales but Low/Negative Profit Products
SELECT
    product_id,
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY product_id, product_name
HAVING SUM(sales) >= 5000
   AND SUM(profit) <= 0
ORDER BY total_sales DESC;

-- High Quantity but Low-Profit Products
SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY product_id, product_name
HAVING SUM(quantity) >= 500
   AND SUM(profit) < 500
ORDER BY total_quantity DESC;

-- Product Profitability by Category + Subcategory
SELECT
    category,
    sub_category,
    COUNT(DISTINCT product_id) AS number_of_products,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY category, sub_category
ORDER BY total_profit DESC;

-- Product Revenue vs Profit
SELECT
    product_id,
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY product_id, product_name
ORDER BY total_sales DESC
LIMIT 20;