-- challenge 1
-- How many payments were made by customer with customer ID 100.
SELECT COUNT(*) 
FROM payment 
WHERE customer_id = 100;

-- find out the last name of the customer with the first name ERICA.
SELECT last_name 
FROM customer 
WHERE first_name = 'ERICA';

-- challenge 2
-- how many rentals have not been returned yet
-- which means that the return date is null.
SELECT COUNT(*) 
FROM rental 
WHERE return_date is null;

-- list of all of the payment IDs and amount where the amount is less than or equal to $2.
SELECT payment_id, amount
FROM payment 
WHERE amount <= 2;

-- challenge 3
-- a list of all of the payments of the three customers 322, 346 and 354.
-- amount is either less than $2 or greater than $10.
-- the ordering of this list should be first by the customers in a ascending order.
-- a second order condition, we want to also order by the amount in a descending order.

SELECT 
	*
FROM 
	payment
WHERE 
	(customer_id = 322 OR customer_id = 346 OR customer_id = 354)
	AND 
	(amount < 2 OR amount > 10)
ORDER BY 
	customer_id ASC, amount DESC;
	
--  Challenge 4
-- how many payments have been made on January 26 and 27, 2020, 
-- with an amount between 1.99 and 3.99.

SELECT COUNT(*) 
FROM payment
WHERE (payment_date BETWEEN '2020-01-26' AND '2020-01-27 23:59')
AND (amount BETWEEN 1.99 AND 3.99);

-- Challenge 5
-- List of 6 complaints done by customer_id 12,25, 67, 93, 124, 234.
-- payment amount 4.99, 7.99, 9.99
-- in Jan 2020
SELECT * 
FROM payment
WHERE customer_id IN (12,25, 67, 93, 124, 234) 
AND amount IN (4.99, 7.99, 9.99)
AND payment_date BETWEEN '2020-01-01' AND '2020-01-31 23:59';

-- Challenge 6
-- how many movies are there that contain the word documentary in the description.
SELECT COUNT(*)
FROM film
WHERE description LIKE '%Documentary%';

-- many customers are in the database with a first name that is three letters long 
-- either an X or a Y as the last letter in the last name.
SELECT count(*) 
FROM customer
WHERE first_name LIKE '___'
AND (last_name LIKE '%X' OR last_name LIKE '%Y');

-- Challenge 7
-- how many movies are there that contain the word 'Saga' in the description 
-- and where the title starts either with an A or ends with an R.
-- And you should also use the alias no_of_movies in the data output.
SELECT COUNT(*) AS no_of_movies
FROM film
WHERE description LIKE '%Saga%'
AND (title LIKE 'A%' OR title LIKE '%R');

-- a list of all of the customers where the first name contains ER 
-- and have an A as the second letter 
-- and the results should be ordered by the last name in a descending
SELECT *
FROM customer
WHERE first_name LIKE '%ER%' AND first_name LIKE '_A%'
ORDER BY last_name DESC;

-- how many payments are there where the amount is either zero 
-- or is between 3.99 and 7.99 
-- and in the same time have occurred on 2020-05-01.
SELECT COUNT(*) 
FROM payment
WHERE (amount = 0 OR amount BETWEEN 3.99 AND 7.99)
AND payment_date BETWEEN '2020-05-01' AND '2020-05-01 23:59';


