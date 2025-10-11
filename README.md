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

**1. Load data** Get Superstore data into PostgreSQL `stg_orders`, `stg_returns`, `stg_people` tables <br> 
**2. Clean & prepare** Remove duplicates, handle nulls, standardize columns `01_staging_cleaning.sql`<br>
**3. Model data** Create fact and mart tables for analysis `fact_sales`, `mart_sales_returns`<br>
**4. Analyze** Write KPI queries (Sales, Margin, Returns) `03_analysis_queries.sql`<br>
**5. Visualize** Connect Tableau and build dashboards | Tableau Public dashboard <br>
**6. Document** | Summarize results and insights | `README.md`, screenshots <br>

## Outputs


