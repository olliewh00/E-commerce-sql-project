DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;


CREATE TABLE Customers(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    address VARCHAR(200)
);

Create table products(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL
);


create table orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0.00 not NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

create table orderitems(
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);





-- Insert sample data into Customers table--


-- Insert Sample Customers
INSERT INTO Customers (first_name, last_name, email, registration_date) VALUES
('Alice', 'Smith', 'alice@example.com', '2024-01-10'),
('Bob', 'Johnson', 'bob@example.com', '2024-02-15'),
('Charlie', 'Brown', 'charlie@example.com', '2024-03-01'),
('Diana', 'Prince', 'diana@example.com', '2024-04-22');

-- Insert Sample Products
INSERT INTO Products (product_name, price, quantity) VALUES
('Wireless Keyboard', 45.99, 150), -- Product ID 1
('Gaming Mousepad', 19.99, 50),     -- Product ID 2
('4K Monitor 27"', 350.00, 75),     -- Product ID 3
('USB-C Hub', 25.50, 200),         -- Product ID 4
('Ergonomic Chair', 250.00, 30);    -- Product ID 5

-- Insert Sample Orders (Note: Total amount will be calculated)
INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2024-03-05 10:00:00', 'Shipped'), -- Order 1 (Alice)
(2, '2024-03-15 14:30:00', 'Completed'), -- Order 2 (Bob)
(1, '2024-04-10 11:15:00', 'Completed'), -- Order 3 (Alice - Repeat Customer)
(3, '2024-05-01 16:00:00', 'Processing'), -- Order 4 (Charlie)
(4, '2024-05-02 09:00:00', 'Shipped'), -- Order 5 (Diana)
(1, '2024-05-15 12:00:00', 'Processing'); -- Order 6 (Alice - 3rd Order)


-- Insert Sample OrderItems
-- Order 1: 1 Keyboard (45.99)
INSERT INTO orderitems(order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 45.99);

-- Order 2: 2 Mousepads (19.99) + 1 Monitor (350.00)
INSERT INTO orderitems (order_id, product_id, quantity, unit_price) VALUES
(2, 2, 2, 19.99),
(2, 3, 1, 350.00);

-- Order 3: 3 USB-C Hubs (25.50)
INSERT INTO orderitems (order_id, product_id, quantity, unit_price) VALUES
(3, 4, 3, 25.50);

-- Order 4: 1 Ergonomic Chair (250.00)
INSERT INTO orderitems (order_id, product_id, quantity, unit_price) VALUES
(4, 5, 1, 250.00);

-- Order 5: 1 Keyboard (45.99)
INSERT INTO orderitems (order_id, product_id, quantity, unit_price) VALUES
(5, 1, 1, 45.99);

-- Order 6: 1 Monitor (350.00) + 1 Mousepad (19.99)
INSERT INTO orderitems (order_id, product_id, quantity, unit_price) VALUES
(6, 3, 1, 350.00),
(6, 2, 1, 19.99);

-- Update the Total_Amount for all orders (Best Practice: Use Triggers, but for SQL practice, an UPDATE is fine)
UPDATE Orders o
SET total_amount = (
    SELECT SUM(oi.quantity * oi.unit_price)
    FROM OrderItems oi
    WHERE oi.order_id = o.order_id
)
WHERE total_amount IS NULL OR total_amount = 0;


