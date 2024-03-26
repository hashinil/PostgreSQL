-- SUM
SELECT 
SUM(CASE
	WHEN rating IN ('PG', 'G') THEN 1
	ELSE 0
END) as rating_with_pg
FROM film;

SELECT 
SUM(CASE
	WHEN rating = 'G' THEN 1
	ELSE 0
END) as "G",
SUM(CASE
	WHEN rating = 'R' THEN 1
	ELSE 0
END) as "R",
SUM(CASE
	WHEN rating = 'NC-17' THEN 1
	ELSE 0
END) as "NC-17",
SUM(CASE
	WHEN rating = 'PG-13' THEN 1
	ELSE 0
END) as "PG-13",
SUM(CASE
	WHEN rating = 'PG' THEN 1
	ELSE 0
END) as "PG"
FROM film;

