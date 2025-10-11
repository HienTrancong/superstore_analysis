DROP TABLE IF EXISTS stg_returns;
CREATE TABLE stg_returns (returned TEXT, order_id TEXT);
COPY stg_returns
FROM 'D:\\Portfolio\\superstore\\sql\\Returns.csv' WITH (
		FORMAT csv,
		HEADER true,
		DELIMITER ',',
		QUOTE '"',
		ESCAPE '"',
		ENCODING 'UTF8'
	);
SELECT *
FROM stg_returns;