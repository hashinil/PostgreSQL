-- challenge
-- how many people choose seats in the category
-- business, economy or comfort

SELECT S.fare_conditions, COUNT(BP.seat_no)
FROM boarding_passes BP
INNER JOIN seats S
ON BP.seat_no = S.seat_no
GROUP BY S.fare_conditions;

-- Challenge2 
-- what is their popular seat
SELECT B.seat_no, COUNT(*) AS tot
FROM seats S
LEFT OUTER JOIN boarding_passes B
ON S.seat_no = B.seat_no
GROUP BY B.seat_no
ORDER BY tot DESC;

SELECT RIGHT(B.seat_no,1), COUNT(*) AS tot
FROM seats S
LEFT OUTER JOIN boarding_passes B
ON S.seat_no = B.seat_no
GROUP BY  RIGHT(B.seat_no,1)
ORDER BY tot DESC

SELECT * FROM seats
SELECT * FROM boarding_passes

-- Challeng 3
-- multiple conditions on JOIN
-- find average seat price
SELECT * FROM ticket_flights;
SELECT * FROM boarding_passes;

SELECT BP.seat_no, ROUND(AVG(TF.amount),2) FROM ticket_flights TF
LEFT JOIN boarding_passes BP
ON TF.ticket_no = BP.ticket_no
AND TF.flight_id = BP.flight_id
GROUP BY  BP.seat_no
ORDER BY 2 DESC;

-- Challenge3
-- which pasenger spend moe on thier tickets
SELECT  passenger_name, SUM(total_amount)
FROM tickets T 
INNER JOIN bookings B
ON T.book_ref = B.book_ref
GROUP BY passenger_name
ORDER BY SUM(total_amount) DESC 
LIMIT 1;

-- Which fare condition 'ALEKSANDR IVANOV' bought frequently
SELECT  fare_conditions, COUNT(*)
FROM tickets T
INNER JOIN bookings B 
ON T.book_ref = B.book_ref
INNER JOIN ticket_flights TF
ON T.ticket_no = TF.ticket_no
AND T.passenger_name = 'ALEKSANDR IVANOV'
GROUP BY fare_conditions;











