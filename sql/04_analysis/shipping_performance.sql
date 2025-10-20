/*
Shipping performance
  Processing time by ship mode
*/

SELECT DISTINCT ship_mode FROM fact_sales;

SELECT
ship_mode, 
EXTRACT(YEAR FROM order_date),
ROUND(AVG(ship_date - order_date),2)
FROM fact_sales
GROUP BY 1
ORDER BY 1 ASC
;

SELECT
--ship_mode, 
EXTRACT(YEAR FROM order_date),
--AVG(ship_date - order_date),
ROUND(AVG(CASE WHEN ship_mode = 'Same Day'  THEN ship_date - order_date END),2) AS sameday_avg,
ROUND(AVG(CASE WHEN ship_mode = 'First Class' THEN ship_date - order_date END),2) AS firstclass_avg,
ROUND(AVG(CASE WHEN ship_mode = 'Second Class' THEN ship_date - order_date END),2) AS secondclass_avg,
ROUND(AVG(CASE WHEN ship_mode = 'Standard Class' THEN ship_date - order_date END),2) AS standardclass_avg

FROM fact_sales
GROUP BY 1
ORDER BY 1 ASC
;