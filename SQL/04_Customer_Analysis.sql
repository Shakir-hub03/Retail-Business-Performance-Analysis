-- =====================================================
-- Retail Business Performance Analysis
-- Customer Performance Analysis 
-- =====================================================

-- Customer Revenue Ranking
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Customers by Profit
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- Bottom 10 Customers by Profit
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_profit ASC
LIMIT 10;

-- Orders per Customer
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_orders DESC
LIMIT 10;

-- Customer Revenue Segmentation
SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(total_sales), 2) AS total_sales,
    ROUND(SUM(total_profit), 2) AS total_profit
FROM (
    SELECT
        customer_id,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        CASE
            WHEN SUM(sales) >= 10000 THEN 'High Value'
            WHEN SUM(sales) >= 5000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM superstore
    GROUP BY customer_id
) AS customer_summary
GROUP BY customer_segment
ORDER BY total_sales DESC;

-- Repeat vs One-Time Customers
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customers,
    ROUND(SUM(total_sales), 2) AS total_sales,
    ROUND(SUM(total_profit), 2) AS total_profit
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY customer_id
) AS customer_summary
GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;

-- Average Customer Value
SELECT
    ROUND(SUM(total_sales) / COUNT(*), 2) AS average_customer_revenue,
    ROUND(SUM(total_profit) / COUNT(*), 2) AS average_customer_profit
FROM (
    SELECT
        customer_id,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY customer_id
) AS customer_summary;

-- Customer Profit Margin
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY profit_margin DESC
LIMIT 10;

-- High-Revenue but Low/Negative-Profit Customers
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore
GROUP BY customer_id, customer_name
HAVING SUM(sales) >= 5000
   AND SUM(profit) <= 0
ORDER BY total_sales DESC;

-- Customer Contribution
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(
        (SUM(sales) / (SELECT SUM(sales) FROM superstore)) * 100,
        2
    ) AS revenue_contribution_percentage
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;
