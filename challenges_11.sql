-- challenge 1
-- return list of movies (filmid,title, length, category, avg length in category
-- order by film id)

SELECT f.film_id, f.title, f.length, c.name, 
ROUND(AVG(f.length) OVER(PARTITION BY c.name),2)
FROM film f 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
ORDER BY f.film_id;

-- return all payment details
-- include no of payments and the amount by the customer
-- order by payment id

SELECT *, COUNT(*) OVER(PARTITION BY customer_id, amount) as no_of_payments
FROM payment
ORDER BY payment_id;

--challenge
-- return cus name , country and how many payments they have 
-- use customer_list view
select * from customer_list

SELECT * 
FROM (
	SELECT name, country, COUNT(*),
	RANK() OVER(PARTITION BY country ORDER BY COUNT(*) DESC) as rank
	FROM customer_list
	LEFT OUTER JOIN payment ON id = customer_id
	GROUP BY name, country) as subq
WHERE rank BETWEEN 1 AND 3;

-- challenge
-- return revenue of the day and prv day
SELECT 
	DATE(payment_date) as today, SUM(amount) as today_rev,
	LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) as prv_rev,
	(SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date))) as diff,
	((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)))/((LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)))))*100 as growth
FROM payment
GROUP BY DATE(payment_date)
