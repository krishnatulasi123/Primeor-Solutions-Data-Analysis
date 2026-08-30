CREATE DATABASE primeor_ecommerce;

USE primeor_ecommerce;

SELECT DATABASE();

CREATE TABLE ecommerce_sales (
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_name VARCHAR(150),
    segment VARCHAR(50),
    state VARCHAR(100),
    country VARCHAR(100),
    market VARCHAR(50),
    region VARCHAR(100),
    product_id VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product_name VARCHAR(255),
    sales DECIMAL(15,2),
    quantity INT,
    discount DECIMAL(10,4),
    profit DECIMAL(15,2),
    shipping_cost DECIMAL(15,2),
    order_priority VARCHAR(50),
    year INT
);

SHOW TABLES;

DESCRIBE ecommerce_sales;

LOAD DATA LOCAL INFILE 'C:/Users/krish/OneDrive/Documents/Primeor_Ecommerce_Cleaned_Data.csv'
INTO TABLE ecommerce_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_date, ship_date, ship_mode, customer_name, segment,
 state, country, market, region, product_id, category, sub_category,
 product_name, sales, quantity, discount, profit, shipping_cost,
 order_priority, year);
 
 SELECT COUNT(*) AS total_rows
FROM ecommerce_sales;

SELECT *
FROM ecommerce_sales
LIMIT 5;

TRUNCATE TABLE ecommerce_sales;

LOAD DATA LOCAL INFILE 'C:/Users/krish/OneDrive/Documents/Primeor_Ecommerce_Cleaned_Data.csv'
INTO TABLE ecommerce_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    @order_date,
    @ship_date,
    ship_mode,
    customer_name,
    segment,
    state,
    country,
    market,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit,
    shipping_cost,
    order_priority,
    year
)
SET
    order_date = STR_TO_DATE(@order_date, '%d-%m-%Y'),
    ship_date = STR_TO_DATE(@ship_date, '%d-%m-%Y');
    
SELECT 
    order_date,
    ship_date,
    sales,
    profit
FROM ecommerce_sales
LIMIT 10;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(order_date) AS valid_order_dates,
    COUNT(ship_date) AS valid_ship_dates,
    COUNT(profit) AS profit_values
FROM ecommerce_sales;

SHOW WARNINGS LIMIT 10;

SELECT 
    ROUND(SUM(sales), 2) AS total_sales
FROM ecommerce_sales;

SELECT 
    ROUND(SUM(profit), 2) AS total_profit
FROM ecommerce_sales;

SELECT 
    ROUND(AVG(discount), 4) AS average_discount
FROM ecommerce_sales;

SELECT 
    SUM(quantity) AS total_quantity
FROM ecommerce_sales;

SELECT
    product_name,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

SELECT
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM ecommerce_sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT 
    region,
    ROUND(SUM(sales), 2) AS total_sales
FROM ecommerce_sales
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    category,
    ROUND(AVG(profit), 2) AS average_profit
FROM ecommerce_sales
GROUP BY category
ORDER BY average_profit DESC;

SELECT 
    category,
    AVG(discount) AS average_discount
FROM ecommerce_sales
GROUP BY category
ORDER BY average_discount DESC
LIMIT 1;

SELECT
    order_date,
    ship_date,
    sales,
    profit
FROM ecommerce_sales
WHERE profit < 0
ORDER BY profit ASC;

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

SELECT
    market,
    SUM(sales) AS total_revenue
FROM ecommerce_sales
GROUP BY market
ORDER BY total_revenue DESC;

SELECT
    sub_category,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY sub_category
ORDER BY total_sales DESC;

SELECT
    ship_mode,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY ship_mode
ORDER BY total_orders DESC;