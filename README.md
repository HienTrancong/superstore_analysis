# superstore_analysis

Data analysis and visualization of the Tableau Superstore dataset using SQL and Tableau.


## Objectives


## Data
 [Tableau Sample – Superstore](https://public.tableau.com/app/resources/sample-data)

## Technologies
**SQL** - data cleaning, joins, calculations, and KPI modeling  
**Tableau** – dashboard creation and visual exploration  
**Excel** – initial data inspection and export  

## Process

**1. Load data** <br> 
Imported Superstore dataset into PostgreSQL staging tables `stg_orders`, `stg_returns`, `stg_people`<br> 
**2. Clean & prepare** <br>
Performed data cleaning and validation in `01_staging_cleaning.sql`:<br>
- **Data structure validation:** checked row counts and previewed sample rows, verified table schema and data types. 
- **Data quality checks:** Checked for null, duplicates, invalid dates, text formating, outliers.
- **Findings:**
  - Found **trailing spaces** in `product_name` in `stg_orders` -> clean with `TRIM()`
  - Detected **high sales outlier (~22,638)**
  - No missing or duplicate records in key fields
- **Create clean tables:** `clean_orders`, `clean_returns`, `clean_people`

**3. Model data** <br>
- Create schemas: *stg, clean, mart*
- Create `fact_sales` table for analysis and visualization <br>
  - Derive fields:
    - *cost = sales - profit*
    - *margin = profit / sales*
    - *unit_price = sales / quantity*
    - *gross_sales = sales / (1 - discount)*
    - *gross_unit_price = (sales / (1 - discount)) / quantity*
- Create view `fact_sales` in *mart* schema

**4. Analyze** <br>
- Product performance
  - Top 5 product by sales
    - Using `ROW_NUMBER()` for top-N
  - Top subcategory by return rate
    - *Return rate (quantity based) = return_quantity / total_quantity*
- Shipping performance
  - Processing time by year in 3 years
    - *Processing_time = ship_date - order_date*
  - Processing time and order percentage by `ship_mode`
- Time Series analysis
  - Top country by sales growth YoY
    - Using `LAG()` for previous year(s) comparisons
  - MoM sales seasonality

**5. Access control**<br>
- Create access tole *bi_readonly* for business intelligence 
- Grant **read only** access for *bi_readonly* to view `mart.fact_sales`
  
**6. Visualize**<br>
- Setup Tableau connection to Tableau
  - Download and install 
  [Tableau driver](https://www.tableau.com/en-gb/support/drivers?edition=pro&lang=en-gb&platform=windows&cpu=64&version=2025.1&__full-version=20251.25.0313.2002) for PostgreSQL
  -  Connect to postgre superstore database / mart.fact_sales

**7. Document** | Summarize results and insights | `README.md`, screenshots <br>

## Outputs



