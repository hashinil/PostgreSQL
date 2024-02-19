-- SELECT --
SELECT * 
FROM address;

SELECT address, district
FROM address;

SELECT * 
FROM customer;

SELECT first_name, last_name, email  
FROM customer;

-- ORDER BY --
SELECT *
FROM payment
ORDER BY customer_id;

SELECT *
FROM payment
ORDER BY customer_id, amount DESC;

-- DISTINCT --
SELECT DISTINCT rating, rental_duration 
FROM film;

-- LIMIT --
SELECT *
FROM rental
LIMIT 10;

SELECT *
FROM rental
ORDER BY rental_date DESC
LIMIT 10;

-- COUNT --
SELECT COUNT(*)
FROM customer;

SELECT COUNT(first_name)
FROM customer;

SELECT COUNT(DISTINCT first_name)
FROM customer;