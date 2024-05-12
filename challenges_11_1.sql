--challenge 1
-- return running total of how late the flights are (actual arrival - shedula arrival)
-- order by flight id, departure airport
SELECT flight_id,departure_airport,(actual_arrival-scheduled_arrival) as delay,
SUM(actual_arrival-scheduled_arrival) OVER(ORDER BY flight_id,departure_airport)
FROM flights;

--cal same running total by partitioning dep airport 
SELECT flight_id,departure_airport,(actual_arrival-scheduled_arrival) as delay,
SUM(actual_arrival-scheduled_arrival) OVER(PARTITION BY departure_airport ORDER BY flight_id,departure_airport)
FROM flights;