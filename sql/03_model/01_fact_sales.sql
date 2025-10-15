DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales AS
  SELECT 
    o.row_id,
    o.order_id,
    o.order_date,
    o.ship_date,
    o.ship_mode,
    o.customer_id,
    o.customer_name,
    o.segment,
    o.country,
    o.city,
    o.state,
    o.postal_code,
    o.region,
    o.product_id,
    o.category,
    o.sub_category,
    o.product_name,
    o.sales,
    o.quantity,
    o.discount,
    o.profit,
    r.returned, 
    p.person,
    (o.sales - o.profit) AS cost,
    (o.profit/NULLIF(o.sales,0)) AS margin,
    (o.sales/NULLIF(1 - o.discount,0)) AS gross_sales,
    (o.sales/NULLIF(o.quantity,0)) AS unit_price,
    ((o.sales / NULLIF(1 - o.discount,0)) / NULLIF(o.quantity,0)) AS gross_unit_price
FROM clean_orders o
LEFT JOIN clean_returns r ON o.order_id = r.order_id
LEFT JOIN clean_people p ON o.region = p.region
;

