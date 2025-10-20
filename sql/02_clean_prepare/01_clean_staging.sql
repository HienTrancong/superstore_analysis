-- See how many rows
SELECT COUNT(*) FROM stg_orders;
SELECT COUNT(*) FROM stg_returns;
SELECT COUNT(*) FROM stg_people;

-- Preview first rows
SELECT * FROM stg_orders LIMIT 10;
SELECT * FROM stg_returns LIMIT 10;
SELECT * FROM stg_people LIMIT 10;

-- Inspect columns, data types
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'stg_orders';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'stg_returns';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'stg_people';

-- Check null
SELECT COUNT(*) - COUNT(row_id) AS null_row_id,
  COUNT(*) - COUNT(order_id) AS null_order_id,
  COUNT(*) - COUNT(order_date) AS null_order_date,
  COUNT(*) - COUNT(ship_date) AS null_ship_date,
  COUNT(*) - COUNT(sales) AS null_sales,
  COUNT(*) - COUNT(quantity) AS null_quantity,
  COUNT(*) - COUNT(discount) AS null_discount,
  COUNT(*) - COUNT(profit) AS null_profit,
  COUNT(*) - COUNT(customer_id) AS null_customer_id,
  COUNT(*) - COUNT(customer_name) AS null_customer_name,
  COUNT(*) - COUNT(product_id) AS null_product_id,
  COUNT(*) - COUNT(product_name) AS null_product_name,
  COUNT(*) - COUNT(category) AS null_category,
  COUNT(*) - COUNT(sub_category) AS null_sub_category,
  COUNT(*) - COUNT(ship_mode) AS null_ship_mode,
  COUNT(*) - COUNT(country) AS null_country,
  COUNT(*) - COUNT(city) AS null_city,
  COUNT(*) - COUNT(state) AS null_state,
  COUNT(*) - COUNT(postal_code) AS null_postal_code,
  COUNT(*) - COUNT(region) AS null_region,
  COUNT(*) - COUNT(segment) AS null_segment
FROM stg_orders;
SELECT COUNT(*) - COUNT(returned) AS null_returned,
  COUNT(*) - COUNT(order_id) AS null_order_id
FROM stg_returns;
-- Check duplicates
SELECT COUNT(*) - COUNT(DISTINCT row_id) AS dup_row_id,
  COUNT(*) - COUNT(DISTINCT order_id) AS dup_order_id,
  COUNT(*) - COUNT(DISTINCT order_date) AS dup_order_date,
  COUNT(*) - COUNT(DISTINCT ship_date) AS dup_ship_date,
  COUNT(*) - COUNT(DISTINCT sales) AS dup_sales,
  COUNT(*) - COUNT(DISTINCT quantity) AS dup_quantity,
  COUNT(*) - COUNT(DISTINCT discount) AS dup_discount,
  COUNT(*) - COUNT(DISTINCT profit) AS dup_profit,
  COUNT(*) - COUNT(DISTINCT customer_id) AS dup_customer_id,
  COUNT(*) - COUNT(DISTINCT customer_name) AS dup_customer_name,
  COUNT(*) - COUNT(DISTINCT product_id) AS dup_product_id,
  COUNT(*) - COUNT(DISTINCT product_name) AS dup_product_name,
  COUNT(*) - COUNT(DISTINCT category) AS dup_category,
  COUNT(*) - COUNT(DISTINCT sub_category) AS dup_sub_category,
  COUNT(*) - COUNT(DISTINCT ship_mode) AS dup_ship_mode,
  COUNT(*) - COUNT(DISTINCT country) AS dup_country,
  COUNT(*) - COUNT(DISTINCT city) AS dup_city,
  COUNT(*) - COUNT(DISTINCT state) AS dup_state,
  COUNT(*) - COUNT(DISTINCT postal_code) AS dup_postal_code,
  COUNT(*) - COUNT(DISTINCT region) AS dup_region,
  COUNT(*) - COUNT(DISTINCT segment) AS dup_segment
FROM stg_orders;


SELECT 
  COUNT(*) - COUNT(DISTINCT returned) AS dup_returned,
  COUNT(*) - COUNT(DISTINCT order_id) AS dup_order_id
FROM stg_returns;

-- Are there returns pointing to missing orders?
SELECT COUNT(*) AS orphan_returns
FROM clean_returns r
LEFT JOIN clean_orders o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Check space
SELECT
  CASE WHEN order_id      LIKE ' %' OR order_id      LIKE '% ' THEN 'Y' END AS space_order_id,
  CASE WHEN returned     LIKE ' %' OR returned     LIKE '% ' THEN 'Y' END AS space_ship_mode
  FROM stg_returns
  WHERE order_id      LIKE ' %' OR order_id      LIKE '% '
    OR returned    LIKE ' %' OR returned     LIKE '% '
;

SELECT
  CASE WHEN order_id      LIKE ' %' OR order_id      LIKE '% ' THEN 'Y' END AS space_order_id,
  CASE WHEN ship_mode     LIKE ' %' OR ship_mode     LIKE '% ' THEN 'Y' END AS space_ship_mode,
  CASE WHEN customer_id   LIKE ' %' OR customer_id   LIKE '% ' THEN 'Y' END AS space_customer_id,
  CASE WHEN customer_name LIKE ' %' OR customer_name LIKE '% ' THEN 'Y' END AS space_customer_name,
  CASE WHEN segment       LIKE ' %' OR segment       LIKE '% ' THEN 'Y' END AS space_segment,
  CASE WHEN country       LIKE ' %' OR country       LIKE '% ' THEN 'Y' END AS space_country,
  CASE WHEN city          LIKE ' %' OR city          LIKE '% ' THEN 'Y' END AS space_city,
  CASE WHEN state         LIKE ' %' OR state         LIKE '% ' THEN 'Y' END AS space_state,
  CASE WHEN region        LIKE ' %' OR region        LIKE '% ' THEN 'Y' END AS space_region,
  CASE WHEN postal_code::text LIKE ' %' OR postal_code::text LIKE '% ' THEN 'Y' END AS space_postal_code,
  CASE WHEN product_id    LIKE ' %' OR product_id    LIKE '% ' THEN 'Y' END AS space_product_id,
  CASE WHEN category      LIKE ' %' OR category      LIKE '% ' THEN 'Y' END AS space_category,
  CASE WHEN sub_category  LIKE ' %' OR sub_category  LIKE '% ' THEN 'Y' END AS space_sub_category,
  CASE WHEN product_name  LIKE ' %' OR product_name  LIKE '% ' THEN 'Y' END AS space_product_name
  FROM stg_orders
  WHERE order_id      LIKE ' %' OR order_id      LIKE '% '
    OR ship_mode     LIKE ' %' OR ship_mode     LIKE '% '
    OR customer_id   LIKE ' %' OR customer_id   LIKE '% '
    OR customer_name LIKE ' %' OR customer_name LIKE '% '
    OR segment       LIKE ' %' OR segment       LIKE '% '
    OR country       LIKE ' %' OR country       LIKE '% '
    OR city          LIKE ' %' OR city          LIKE '% '
    OR state         LIKE ' %' OR state         LIKE '% '
    OR region        LIKE ' %' OR region        LIKE '% '
    OR postal_code::text LIKE ' %' OR postal_code::text LIKE '% '
    OR product_id    LIKE ' %' OR product_id    LIKE '% '
    OR category      LIKE ' %' OR category      LIKE '% '
    OR sub_category  LIKE ' %' OR sub_category  LIKE '% '
    OR product_name  LIKE ' %' OR product_name  LIKE '% '
;

SELECT product_id,
    '"' || product_name || '"' AS visible_name
  FROM stg_orders
  WHERE product_name LIKE '% '
  ORDER BY 1
;

-- Check date type
SELECT order_date, ship_date
  FROM stg_orders
  WHERE 
    order_date IS NULL OR order_date::text !~ '^\d{4}-\d{2}-\d{2}$' OR
    ship_date IS NULL OR ship_date::text !~ '^\d{4}-\d{2}-\d{2}$'
;

-- Check data range and outlier
SELECT MIN(sales), MAX(sales)
  FROM stg_orders
;

SELECT
  order_id,
  product_name,
  sales,
  quantity,
  profit,
  customer_name,
  order_date
FROM stg_orders
ORDER BY sales DESC
LIMIT 5;

SELECT
  ROUND(AVG(sales), 2) AS avg_sales,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sales) AS median_sales,
  PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY sales) AS p95_sales,
  PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY sales) AS p99_sales,
  MAX(sales) AS max_sales
FROM stg_orders;

-- Create clean tables

DROP TABLE IF EXISTS clean_orders;
CREATE TABLE clean_orders AS
  SELECT  row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    TRIM(product_name) AS product_name,
    sales,
    quantity,
    discount,
    profit
  FROM stg_orders
;

DROP TABLE IF EXISTS clean_returns;
CREATE TABLE clean_returns AS
  SELECT * FROM stg_returns
;

DROP TABLE IF EXISTS clean_people;
CREATE TABLE clean_people AS
  SELECT * FROM stg_people
;



