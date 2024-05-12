--challenge 1
-- result > sum for each cutomer, each staff id and overall revenue per customer
SELECT c.first_name, c.last_name , p.staff_id, SUM(p.amount) as tot_rev
FROM payment p 
	LEFT JOIN customer c ON p.customer_id = c.customer_id
GROUP BY
	GROUPING SETS(
		(c.first_name, c.last_name) , 
		(c.first_name, c.last_name, p.staff_id)
	)
ORDER BY 1,2,3;

-- Add aditional column, rev precentage
SELECT c.first_name, c.last_name , p.staff_id, SUM(p.amount) as tot_rev,
	ROUND(100*SUM(p.amount)/FIRST_VALUE(SUM(p.amount)) 
		OVER(PARTITION BY c.first_name, c.last_name ORDER BY SUM(p.amount) DESC),2)
FROM payment p 
	LEFT JOIN customer c ON p.customer_id = c.customer_id
GROUP BY
	GROUPING SETS(
		(c.first_name, c.last_name) , 
		(c.first_name, c.last_name, p.staff_id)
	)
ORDER BY 1,2,3;

-- 
SELECT 
	p.customer_id,
	DATE(payment_date),
	title,
	SUM(amount) as total
FROM payment p
LEFT JOIN rental r ON r.rental_id=p.rental_id
LEFT JOIN inventory i ON i.inventory_id=r.inventory_id
LEFT JOIN film f ON f.film_id=i.film_id
GROUP BY 
	CUBE(
		p.customer_id,
		DATE(payment_date),
		title
	)
ORDER BY 1,2,3

-- find film pairs with same length
SELECT f1.title, f2.title, f1.length FROM
film f1
	LEFT JOIN film f2 ON f1.length = f2.length AND f1.title <> f2.title
ORDER BY f1.title, f2.title
