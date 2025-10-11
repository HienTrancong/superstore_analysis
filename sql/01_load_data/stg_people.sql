DROP TABLE IF EXISTS stg_people;
CREATE TABLE stg_people (person TEXT, region TEXT);
COPY stg_people
FROM 'D:\\Portfolio\\superstore\\sql\\People.csv' WITH (
		FORMAT csv,
		HEADER true,
		DELIMITER ',',
		QUOTE '"',
		ESCAPE '"',
		ENCODING 'UTF8'
	);
SELECT *
FROM stg_people
LIMIT 5;