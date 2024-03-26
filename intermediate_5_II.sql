-- CASE WHEN
SELECT 
TO_CHAR(book_date,'Dy'),
TO_CHAR(book_date,'Mon'),
CASE
	WHEN TO_CHAR(book_date,'Dy')='Mon' THEN 'Monday Special'
	WHEN TO_CHAR(book_date,'Mon')='Jul' THEN 'July Special'
	ELSE 'No Special'
END
FROM bookings;

SELECT 
COUNT(*),
CASE
	WHEN  actual_departure is null THEN 'No Depature Time'
	WHEN  actual_departure - scheduled_departure <'00:05' THEN 'On Time'
	WHEN  actual_departure - scheduled_departure <'01:00' THEN 'Late'
	ELSE 'Very Late'
END as late
FROM flights
GROUP BY late;


-- COALESCE
SELECT 
COALESCE(actual_arrival-scheduled_arrival, '00:00')
FROM Flights

-- CAST
SELECT 
COALESCE(CAST(actual_arrival-scheduled_arrival AS VARCHAR), 'NOT ARRIVED')
FROM Flights

-- Replace
SELECT 
passenger_id, CAST(REPLACE(passenger_id, ' ','') AS BIGINT)
FROM tickets;