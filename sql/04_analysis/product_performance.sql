/*
Product performance
  1. Top product by sales
  2. Top sub-category, category by return rate
  3. Top region by sales growth YoY
*/

-- Top product by sales
WITH 
  base_table AS (
    SELECT 
        -- Time aggregation
        EXTRACT (YEAR FROM order_date) AS order_year,
        product_id,
        product_name,
        -- KPI
        SUM(sales) AS total_sales
      FROM fact_sales 
      WHERE 
        -- Time frame
        order_date >= '2017-01-01' AND order_date < '2018-01-10'
      GROUP BY 1,2,3
  ),
  ranking_table AS (
    SELECT
      *,
      ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS ranking
    FROM base_table
  )
SELECT * FROM ranking_table
-- Rank
WHERE ranking <= 5
;


-- Top category by return rate
SELECT 
  sub_category,
  category,
  ROUND(100* SUM(CASE WHEN returned = 'Yes' THEN quantity ELSE 0 END)::NUMERIC/NULLIF(SUM(quantity),0),2) AS return_rate
FROM fact_sales
WHERE 
  -- Time frame
  order_date >= '2017-01-01' AND order_date < '2018-01-10'
GROUP BY 1,2
ORDER BY return_rate DESC
;

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
