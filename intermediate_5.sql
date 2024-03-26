--Mathematical functions and operations
SELECT film_id, rental_rate as old, rental_rate+1 as new
FROM film;

SELECT film_id, rental_rate as old, rental_rate*1.1 as new
FROM film;

SELECT film_id, rental_rate as old, ROUND(rental_rate*1.4, 2) as new
FROM film;

SELECT film_id, rental_rate as old, CEILING(rental_rate*1.4)-0.1 as new
FROM film;

-- CASE WHEN
SELECT amount,
CASE 
	WHEN amount<2 THEN 'Low'
	WHEN amount <5 THEN 'Medium'
	ELSE 'High'
END
FROM payment;





