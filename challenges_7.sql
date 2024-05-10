--challenge 1
-- Select all films where the length of film is longer than the average of all films
SELECT * FROM film
WHERE length > (SELECT AVG(length) FROM film);

--challenge 2
-- return all films in store 2 more than 3 times
SELECT * FROM inventory 
WHERE store_id =  2;

SELECT film_id
FROM inventory 
GROUP BY film_id
HAVING count(*) > 3;

SELECT * 
FROM film 
WHERE film_id IN (
	SELECT film_id
	FROM inventory 
	WHERE store_id =  2
	GROUP BY film_id
	HAVING count(*) > 3);
	
--challenge 3
-- All customers first name last name that have made payment on 2020-01-25
SELECT first_name, last_name 
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment
	WHERE DATE(payment_date) = '2020-01-25');

--challenge 4
-- all customers email and first name who spent more than $30 in total
SELECT first_name, email 
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id
	HAVING sum(amount) > 30);
	
--challenge 5
-- all customers first_name, last_name who spent more than $100 in total who lives in califonia
SELECT first_name, last_name 
FROM customer c LEFT OUTER JOIN address a
ON c.address_id = a.address_id
WHERE 
	a.district = 'California'
	AND customer_id IN (
		SELECT customer_id 
		FROM payment
		GROUP BY customer_id
		HAVING sum(amount) > 100);


--challenge 5
-- average total amount spent per day

SELECT AVG(daily_tot)
FROM (
	SELECT DATE(payment_date), SUM(amount) as daily_tot
	FROM payment 
	GROUP BY DATE(payment_date)) as subquery;


--challenge 7
-- show only movie titles, 









-- show all payments and difference with the max payment amount
SELECT *, (SELECT MAX(amount) FROM payment)-amount
FROM payment;

--challenge 7
-- show only movie titles, film id, replacement cost, rating
-- with the lowest replacement costs for each rating category

SELECT title, film_id, replacement_cost, rating  
FROM film f1
WHERE replacement_cost = (
	SELECT MIN(replacement_cost) 
	FROM film f2 
	WHERE f1.rating = f2.rating)

--challenge 8
-- show only movie titles, film id, length, rating
-- with the highest length for each rating category
SELECT title, film_id, length, rating  
FROM film f1
WHERE length = (
	SELECT MAX(length) 
	FROM film f2 
	WHERE f1.rating = f2.rating)

--challenge 9
-- show all payments, total amount for every cus, number of payments
SELECT payment_id, customer_id, staff_id, amount, (
	SELECT SUM(amount) as total_amount 
	FROM payment p2 
	WHERE p1.customer_id = p2.customer_id
	GROUP BY p2.customer_id), 
	(SELECT COUNT(amount)  as no_payments
	FROM payment p3 
	WHERE p1.customer_id = p3.customer_id
	GROUP BY p3.customer_id)
FROM payment p1
ORDER BY p1.customer_id;

--challenge 10
-- show only films with the highest replacement cost in the rating catogery,
-- show the avg replacement cost in the rating catogery

SELECT title, replacement_cost, rating,(
	SELECT AVG(replacement_cost) 
	FROM film f2
	WHERE f1.rating = f2.rating) 
FROM film f1
WHERE replacement_cost = (
	SELECT MAX(replacement_cost) 
	FROM film f3 
	WHERE f1.rating = f3.rating);
	
--challenge 11
-- show top payments with each customer including thier first name, payment id

SELECT c.first_name, p.payment_id
FROM payment p left outer join customer c
ON p.customer_id = c.customer_id
WHERE p.amount = (
	SELECT MAX(amount)
	FROM payment p2 
	WHERE p.customer_id = p2.customer_id)