-- SUM
SELECT SUM(amount) 
FROM payment;

-- AVG
SELECT AVG(amount) 
FROM payment;

--ROUND
SELECT ROUND(AVG(amount), 2)
FROM payment;

-- SUM, AVG, ROUND
SELECT SUM(amount), ROUND(AVG(amount), 2) AS average
FROM payment;

-- GROUP BY
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

SELECT customer_id, SUM(amount)
FROM payment
WHERE customer_id = 184
GROUP BY customer_id;

-- multiple columns
SELECT staff_id, customer_id, SUM(amount)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY staff_id, customer_id, SUM(amount);

-- HAVING
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 200;
