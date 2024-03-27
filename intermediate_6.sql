-- INNER JOIN
SELECT P.*, C.first_name
FROM payment P
INNER JOIN customer C
ON P.customer_id = C.customer_id;

SELECT *
FROM payment
INNER JOIN staff
ON payment.staff_id =  staff.staff_id
WHERE payment.staff_id = 1;

