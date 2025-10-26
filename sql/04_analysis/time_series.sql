/*
Time Series analysis
  YoY Summary table of sales, profit, margin and YoY
  MoM seasonality analysis MoM difference from previous month
*/

-- Region Year over year sales growth
WITH base AS (
  SELECT 
  region,
  person,
  EXTRACT(YEAR FROM order_date)::INT AS order_year,
  SUM(sales) AS total_sales
  FROM fact_sales
  WHERE order_date >= '2015-01-01' AND order_date < '2018-01-01'
  GROUP BY region,person,order_year
), 
lag AS (
  SELECT 
  region,
  person,
  order_year,
  total_sales,
  LAG(total_sales,1) OVER (PARTITION BY region,person ORDER BY order_year) AS lastyear_sales,
  LAG(total_sales,2) OVER (PARTITION BY region,person ORDER BY order_year) AS last2year_sales
FROM base
)
SELECT 
  region,
  person,
  order_year AS base_year,
  total_sales,
  ROUND(100*((total_sales::NUMERIC/ NULLIF(lastyear_sales,0)) - 1),2) AS yoy_growth_pct,
  lastyear_sales,
  ROUND(100*((lastyear_sales::NUMERIC/NULLIF(last2year_sales,0)) - 1),2) AS yoy2_growth_pct,
  last2year_sales
FROM lag
WHERE order_year = 2017
ORDER BY region, person;
;
