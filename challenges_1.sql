-- Challenge 1
-- a list of all of the customers with the first name of the customer, the last name and customer's email address.
SELECT * 
FROM customer;

SELECT first_name, last_name, email  
FROM customer;

-- Challenge 2
SELECT first_name, last_name, email  
FROM customer
ORDER BY last_name DESC, first_name DESC;

SELECT first_name, last_name, email  
FROM customer
ORDER BY 2 DESC, 1 DESC;

-- Challenge 3
SELECT DISTINCT amount
FROM payment
ORDER BY amount DESC
LIMIT 10;

-- challenge 4
SELECT DISTINCT(district)
FROM address;

SELECT rental_date 
FROM rental 
ORDER By rental_date DESC
LIMIT 1;

SELECT COUNT(*)
FROM film;

SELECT COUNT(DISTINCT last_name) 
FROM customer;
