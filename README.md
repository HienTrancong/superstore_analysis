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
- Create fact tables for analysis `fact_sales`<br>
- **Derive fields**:
  - `cost` = `sales - profit`
  - `margin` = `profit / sales`
  - `unit_price` = `sales / quantity`
  - `gross_sales` = `sales / (1 - discount)`
  - `gross_unit_price` = `(sales / (1 - discount)) / quantity`

**4. Analyze** <br>
- Product performance
  - Top 5 product by sales
    - Using `ROW_NUMBER()` for top-N
  - Top subcategory by return rate
    - *Return rate (quantity based) = return_quantity / total_quantity*
  - Top country by sales growth YoY
    - Using `LAG()` for previous year(s) comparisons
- Shipping performance
  - Processing time by ship mode
- Time Series analysis
  - YoY sales, profit, margin summary by category
  - MoM sales seasonality
  
**5. Visualize** Connect Tableau and build dashboards | Tableau Public dashboard <br>
**6. Document** | Summarize results and insights | `README.md`, screenshots <br>

## Outputs



