"Dataset too large for GitHub. Available upon request."

-- KPI Metrics

-- Total Revenue
SELECT SUM(price) AS total_revenue
FROM order_items;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- Revenue by Product Category
SELECT
    p.product_category_name AS category,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY category
ORDER BY total_revenue DESC;

-- Top 10 Products by Revenue
SELECT
    oi.product_id,
    p.product_category_name AS category,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY oi.product_id, category
ORDER BY total_revenue DESC
LIMIT 10;

-- Revenue by Month
SELECT
    strftime('%Y-%m', o.order_purchase_timestamp) AS year_month,
    SUM(oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY year_month
ORDER BY year_month;

-- Top 10 Customers by Spend
SELECT
    c.customer_unique_id,
    SUM(oi.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Customers with Most Orders
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;
