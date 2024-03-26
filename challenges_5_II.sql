-- Challenge 1
-- ticket sell in below catergory, <20000 - low, 20000 <= mid <150000, high >= 150000

SELECT
COUNT(*),
CASE
	WHEN total_amount < 20000 THEN 'Low'
	WHEN total_amount < 150000 THEN 'Mid'
	ELSE 'High'
END as price_group
FROM bookings
GROUP BY price_group

-- Challenge 
-- how many flights departed in seasons
SELECT
COUNT(*),
CASE
	WHEN EXTRACT(month from scheduled_departure) IN(12,1,2) THEN 'Winter'
	WHEN EXTRACT(month from scheduled_departure) <=5 THEN 'Spring'
	WHEN EXTRACT(month from scheduled_departure) <=8 THEN 'Summer'
	ELSE 'Fall'
END as season
FROM flights
GROUP BY season;

-- Challenge
-- replace PG in Flight number
SELECT 
REPLACE(flight_no, 'PG','')
FROM flights;



