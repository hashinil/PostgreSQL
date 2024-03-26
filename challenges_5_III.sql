-- Challenge 3
SELECT
CASE
	WHEN rating IN ('PG', 'PG-13') OR length > 210 THEN 'tier 1'
	WHEN description like '%Drama%' AND length > 90 THEN 'tier 2'
	WHEN description like '%Drama%' THEN 'tier 3'
	WHEN rental_rate < 1 THEN 'tier 4'
END as cat
FROM film
WHERE 
CASE
	WHEN rating IN ('PG', 'PG-13') OR length > 210 THEN 'tier 1'
	WHEN description like '%Drama%' AND length > 90 THEN 'tier 2'
	WHEN description like '%Drama%' THEN 'tier 3'
	WHEN rental_rate < 1 THEN 'tier 4'
END is not null


-- Challenge
-- replace return date null values with 'no return'
SELECT 
rental_date, COALESCE(CAST(return_date AS VARCHAR), 'No Return')
FROM rental
ORDER BY rental_date DESC;