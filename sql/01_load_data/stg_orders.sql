DROP TABLE IF EXISTS stg_orders;
CREATE TABLE stg_orders (
	row_id INT,
	order_id TEXT,
	order_date DATE,
	ship_date DATE,
	ship_mode TEXT,
	customer_id TEXT,
	customer_name TEXT,
	segment TEXT,
	country TEXT,
	city TEXT,
	state TEXT,
	postal_code TEXT,
	region TEXT,
	product_id TEXT,
	category TEXT,
	sub_category TEXT,
	product_name TEXT,
	sales NUMERIC,
	quantity INT,
	discount NUMERIC,
	profit NUMERIC
);
COPY stg_orders
FROM 'D:\\Portfolio\\superstore\\data\\Orders.csv' WITH (
		FORMAT csv,
		HEADER true,
		DELIMITER ',',
		QUOTE '"',
		ESCAPE '"',
		ENCODING 'UTF8'
	);
SELECT *
FROM stg_orders;
SELECT *
FROM stg_orders
LIMIT 1;