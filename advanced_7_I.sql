-- Union
SELECT first_name FROM actor
UNION
SELECT first_name FROM customer;

SELECT first_name, 'actor' FROM actor
UNION
SELECT first_name, 'customer' FROM customer;

SELECT first_name, 'actor' as origin FROM actor
UNION
SELECT first_name, 'customer' as test FROM customer;

SELECT first_name, 'actor' as origin FROM actor
UNION
SELECT first_name, 'customer' as test FROM customer
ORDER BY 2 DESC;

SELECT first_name, 'actor' as origin FROM actor
UNION
SELECT LOWER(first_name), 'customer' as test FROM customer
ORDER BY 2 DESC;

-- UNION ALL
SELECT first_name, 'actor' as origin FROM actor
UNION ALL
SELECT first_name, 'customer' as test FROM customer
ORDER BY 1 ASC;


--sub queries in WHERE
SELECT * FROM payment 
WHERE amount > (SELECT AVG(amount) FROM payment);

SELECT * FROM payment
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'ADAM');

SELECT * FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer WHERE first_name LIKE 'A%');


--sub queries in FROM

SELECT customer_id, SUM(amount) as total_amount
FROM payment
GROUP BY customer_id;

SELECT AVG(total_amount) 
FROM (
	SELECT customer_id, SUM(amount) as total_amount
	FROM payment
	GROUP BY customer_id) as subquery;
	
--sub queries in FROM
SELECT *, (SELECT AVG(amount) FROM payment)
FROM payment;

-- Correlated sub queries - where
-- show only those payments that have the highest amount per customer

SELECT * FROM payment p1
WHERE  amount = (
	SELECT MAX(amount) 
	FROM payment p2 
	WHERE p1.customer_id = p2.customer_id)
	
-- Correlated sub queries - SELECT
-- show the maximum amount of every customer next to all of his payment
SELECT * , (
	SELECT MAX(amount) 
	FROM payment p2 
	WHERE p1.customer_id = p2.customer_id)
FROM payment p1
ORDER BY p1.customer_id

