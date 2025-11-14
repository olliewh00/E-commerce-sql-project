-- Calculate Total revenue for each month -- 
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM(o.total_amount) AS total_revenue
FROM Orders o 
WHERE o.status IN ('Completed', 'Shipped')
Group BY order_month
ORDER BY order_month;

-- Find Top 3 Products by total sales amount --

SELECT
    p.product_name as product_name,
    SUM(oi.quantity) as total_units_sold
From Products p 
JOIN orderitems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC
LIMIT 3;


-- Query 3: Identify Customers who placed more than 2 orders (Loyalty Check)
SELECT
    c.first_name,
    c.last_name,
    c.email,
    COUNT(o.order_id) AS total_orders_placed
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(o.order_id) > 2
ORDER BY total_orders_placed DESC;


-- Query 4: List products where stock is below the reorder level (e.g., stock < 50)
SELECT
    product_id,
    product_name,
    quantity
FROM Products
WHERE quantity < 50
ORDER BY quantity;



