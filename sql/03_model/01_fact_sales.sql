DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales AS
SELECT 
  o.*,
  r.returned, 
  p.person,
  (o.sales - o.profit) AS cost,
  (o.profit/NULLIF(o.sales,0)) AS margin,
  (o.sales/NULLIF(1 - o.discount,0)) AS list_sales,
  (o.sales/NULLIF(o.quantity,0)) AS unit_price,
  ((o.sales / NULLIF(1 - o.discount,0)) / NULLIF(o.quantity,0)) AS list_unit_price
FROM clean_orders o
LEFT JOIN clean_returns r ON o.order_id = r.order_id
LEFT JOIN clean_people p ON o.region = p.region
;

SELECT * FROM fact_sales LIMIT 5;

