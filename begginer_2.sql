-- WHERE --
SELECT COUNT(*)
FROM payment
WHERE amount = 0;

SELECT *
FROM customer
WHERE first_name = 'ADAM';

SELECT *
FROM payment 
WHERE customer_id = 30 OR customer_id = 31 AND amount = 2.99; 

SELECT *
FROM payment 
WHERE (customer_id = 30 OR customer_id = 31) AND amount = 2.99; 

-- BETWEEN

SELECT * 
FROM rental
WHERE rental_date BETWEEN '2005-05-24' AND '2005-05-26'
ORDER BY rental_date DESC;

SELECT * 
FROM rental
WHERE rental_date BETWEEN '2005-05-24' AND '2005-05-26 23:59'
ORDER BY rental_date DESC;

-- LIKE
SELECT *
FROM film 
WHERE description LIKE '%Drama%' 
AND title LIKE '%A_';
