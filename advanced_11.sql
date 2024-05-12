-- OVER
SELECT *, 
SUM(amount) OVER(PARTITION BY customer_id)
FROM payment;

SELECT *, 
COUNT(*) OVER(PARTITION BY customer_id)
FROM payment;

SELECT *, 
COUNT(*) OVER(PARTITION BY customer_id, staff_id)
FROM payment;

SELECT *, 
COUNT(*) OVER()
FROM payment;

SELECT *, 
ROUND(AVG(amount) OVER(),2)
FROM payment;

-- OVER() ORDER BY()
SELECT *, SUM(amount) OVER(ORDER BY payment_date) 
FROM payment;

SELECT *, 
SUM(amount) OVER(PARTITION BY customer_id ORDER BY payment_date) 
FROM payment;

--RANK()
SELECT f.title, f.length, c.name,
RANK() OVER(ORDER BY length DESC)
FROM film f 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id;

SELECT f.title, f.length, c.name,
DENSE_RANK() OVER(ORDER BY length DESC)
FROM film f 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id;

SELECT f.title, f.length, c.name,
DENSE_RANK() OVER(PARTITION BY c.name ORDER BY length DESC)
FROM film f 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id;

SELECT * FROM 
(SELECT f.title, f.length, c.name,
DENSE_RANK() OVER(PARTITION BY c.name ORDER BY length DESC) as rank
FROM film f 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id) subquery
WHERE rank = 1;

-- FIRST_VALUE()
SELECT 
	name, country, COUNT(*),
	FIRST_VALUE(name) OVER(PARTITION BY country ORDER BY COUNT(*) DESC) as rank
FROM customer_list
LEFT OUTER JOIN payment ON id = customer_id
GROUP BY name, country;

SELECT 
	name, country, COUNT(*),
	FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*) DESC) as rank
FROM customer_list
LEFT OUTER JOIN payment ON id = customer_id
GROUP BY name, country;

SELECT 
	name, country, COUNT(*),
	FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*) ASC) as rank,
	COUNT(*) - FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*) ASC) as rank
FROM customer_list
LEFT OUTER JOIN payment ON id = customer_id
GROUP BY name, country;

-- LEAD()
SELECT 
	name, country, COUNT(*),
	LEAD(name) OVER(PARTITION BY country ORDER BY COUNT(*) ASC) as lead_val
FROM customer_list
LEFT OUTER JOIN payment ON id = customer_id
GROUP BY name, country;

SELECT 
	name, country, COUNT(*),
	LEAD(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*) ASC) as lead_val
FROM customer_list
LEFT OUTER JOIN payment ON id = customer_id
GROUP BY name, country;

-- LAG()
SELECT 
	name, country, COUNT(*),
	LAG(name) OVER(PARTITION BY country ORDER BY COUNT(*) ASC) as lead_val
FROM customer_list
LEFT OUTER JOIN payment ON id = customer_id
GROUP BY name, country;

SELECT 
	name, country, COUNT(*),
	LEAD(COUNT(*)) OVER(PARTITION BY country ORDER BY COUNT(*) ASC) as lead_val
FROM customer_list
LEFT OUTER JOIN payment ON id = customer_id
GROUP BY name, country;