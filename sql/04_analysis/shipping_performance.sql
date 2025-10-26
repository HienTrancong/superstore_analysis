/*
Shipping performance
*/

SELECT DISTINCT ship_mode FROM fact_sales;

-- Avg processing time over 3 years
-- Findings: processing time decline over time
SELECT
  EXTRACT(YEAR FROM order_date) AS order_year,
  ROUND(AVG(ship_date - order_date),2) AS avg_processing_time
FROM fact_sales
WHERE order_date >= '2015-01-01'
GROUP BY 1
ORDER BY 1 ASC
;

-- Avg processing time
SELECT
EXTRACT(YEAR FROM order_date) AS order_year,
ROUND(AVG(ship_date - order_date),2) AS avg_processing_time,
ROUND(AVG(CASE WHEN ship_mode = 'Same Day'  THEN ship_date - order_date END),2) AS sameday_avg_processingtime,
ROUND(100*COUNT (DISTINCT(CASE WHEN ship_mode = 'Same Day' THEN order_id END))::NUMERIC / COUNT (DISTINCT order_id),1) AS sameday_order_pct,
ROUND(AVG(CASE WHEN ship_mode = 'First Class' THEN ship_date - order_date END),2) AS firstclass_avg_processingtime,
ROUND(100*COUNT (DISTINCT(CASE WHEN ship_mode = 'First Class' THEN order_id END))::NUMERIC / COUNT (DISTINCT order_id),1) AS firstclass_order_pct,
ROUND(AVG(CASE WHEN ship_mode = 'Second Class' THEN ship_date - order_date END),2) AS secondclass_avg_processingtime,
ROUND(100*COUNT (DISTINCT(CASE WHEN ship_mode = 'Second Class' THEN order_id END))::NUMERIC / COUNT (DISTINCT order_id),1) AS secondclass_order_pct,
ROUND(AVG(CASE WHEN ship_mode = 'Standard Class' THEN ship_date - order_date END),2) AS standardclass_avg_processingtime,
ROUND(100*COUNT (DISTINCT(CASE WHEN ship_mode = 'Standard Class' THEN order_id END))::NUMERIC / COUNT (DISTINCT order_id),1) AS standardclass_order_pct
FROM fact_sales
WHERE order_date >= '2015-01-01'
GROUP BY 1
ORDER BY 1 ASC
;



