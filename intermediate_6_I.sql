-- FULL OUTER JOIN
SELECT T.ticket_no FROM
boarding_passes BP 
FULL OUTER JOIN tickets T
ON BP.ticket_no = T.ticket_no
WHERE boarding_no is null

-- LEFT OUTER JOIN
SELECT * FROM 
aircrafts_data AD
LEFT OUTER JOIN flights F
ON AD.aircraft_code = F.aircraft_code
WHERE F.flight_id IS NULL;

-- RIGHT OUTER JOIN
SELECT * FROM 
aircrafts_data AD
RIGHT OUTER JOIN flights F
ON AD.aircraft_code = F.aircraft_code;

-- multiple conditions on JOIN
SELECT * FROM ticket_flights;
SELECT * FROM boarding_passes;

SELECT BP.seat_no, AVG(TF.amount) FROM ticket_flights TF
LEFT JOIN boarding_passes BP
ON TF.ticket_no = BP.ticket_no
AND TF.flight_id = BP.flight_id
GROUP BY  BP.seat_no;

-- Join multiple tables
SELECT T.ticket_no, passenger_name, scheduled_departure 
FROM tickets T
INNER JOIN ticket_flights TF
ON T.ticket_no = TF.ticket_no
INNER JOIN flights F
ON TF.flight_id = F.flight_id;

SELECT * FROM flights;
SELECT * FROM tickets;
SELECT * FROM ticket_flights;