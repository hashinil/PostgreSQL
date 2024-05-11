--Question 1:
--Level: Simple
--Topic: DISTINCT
--Task: Create a list of all the different (distinct) replacement costs of the films.
--Question: What's the lowest replacement cost?
--Answer: 9.99

SELECT DISTINCT(replacement_cost)
FROM film
ORDER BY replacement_cost;

--Question 2:
--Level: Moderate
--Topic: CASE + GROUP BY
--Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges
--low: 9.99 - 19.99
--medium: 20.00 - 24.99
--high: 25.00 - 29.99
--Question: How many films have a replacement cost in the "low" group?
--Answer: 514

SELECT COUNT(*),
CASE
	WHEN replacement_cost >= 9.99 AND replacement_cost < 20.00 THEN 'low'
	WHEN replacement_cost >= 20.00 AND replacement_cost < 25.00 THEN 'medium'
	WHEN replacement_cost >= 25.00 AND replacement_cost < 30.00 THEN 'high'
END as replacement_cost_group
FROM film
GROUP BY replacement_cost_group;

--Question 3:
--Level: Moderate
--Topic: JOIN
--Task: Create a list of the film titles including their title, length, 
--and category name ordered descendingly by length. Filter the results 
--to only the movies in the category 'Drama' or 'Sports'.
--Question: In which category is the longest film and how long is it?
--Answer: Sports and 184

SELECT f.title, f.length, c.name
FROM film f LEFT OUTER JOIN film_category fc
ON f.film_id = fc.film_id
LEFT OUTER JOIN category c
ON fc.category_id = c.category_id
WHERE c.name in ('Drama','Sports')
ORDER BY f.length DESC;

--Question 4:
--Level: Moderate
--Topic: JOIN & GROUP BY
--Task: Create an overview of how many movies (titles) 
--there are in each category (name).
--Question: Which category (name) is the most common among the films?
--Answer: Sports with 74 titles
SELECT  c.name, COUNT(f.title)
FROM film f LEFT OUTER JOIN film_category fc
ON f.film_id = fc.film_id
LEFT OUTER JOIN category c
ON fc.category_id = c.category_id
WHERE c.name in ('Drama','Sports')
GROUP BY  c.name;

--Question 5:
--Level: Moderate
--Topic: JOIN & GROUP BY
--Task: Create an overview of the actors' first and last names and in 
--how many movies they appear in.
--Question: Which actor is part of most movies??
--Answer: Susan Davis with 54 movies

SELECT a. first_name, a. last_name, count(a. actor_id)
FROM film_actor fa  JOIN actor a 
on fa.actor_id = a. actor_id
GROUP BY a. first_name, a. last_name
ORDER BY count(a. actor_id) DESC; 

--Question 6:
--Level: Moderate
--Topic: LEFT JOIN & FILTERING
--Task: Create an overview of the addresses that are not associated to any customer.
--Question: How many addresses are that?
--Answer: 4
SELECT * 
FROM address a LEFT OUTER JOIN customer c
ON a.address_id = c.address_id
WHERE c.customer_id is NULL;

SELECT count(*) 
FROM address a LEFT OUTER JOIN customer c
ON a.address_id = c.address_id
WHERE c.customer_id is NULL;

--Question 7:
--Level: Moderate
--Topic: JOIN & GROUP BY
--Task: Create the overview of the sales  to determine the from which city 
-- (we are interested in the city in which the customer lives, not where the store is) 
-- most sales occur.
--Question: What city is that and how much is the amount?
--Answer: Cape Coral with a total amount of 221.55
SELECT cy.city, SUM(p.amount) 
FROM payment p JOIN customer c ON p.customer_id = c.customer_id
	JOIN address a ON c.address_id = a.address_id
	JOIN city cy ON a.city_id =cy.city_id
GROUP BY cy.city
ORDER BY SUM(p.amount) DESC;

--Question 8:
--Level: Moderate to difficult
--Topic: JOIN & GROUP BY
--Task: Create an overview of the revenue (sum of amount) grouped by a 
--column in the format "country, city".
--Question: Which country, city has the least sales?
--Answer: United States, Tallahassee with a total amount of 50.85.
SELECT cou.country, cy.city, SUM(p.amount) 
FROM payment p JOIN customer c ON p.customer_id = c.customer_id
	JOIN address a ON c.address_id = a.address_id
	JOIN city cy ON a.city_id =cy.city_id
	JOIN country cou ON cou.country_id =cy.country_id
GROUP BY cou.country,cy.city
ORDER BY SUM(p.amount) ASC;

--Question 9:
--Level: Difficult
--Topic: Uncorrelated subquery
--Task: Create a list with the average of the sales amount each 
-- staff_id has per customer.
--Question: Which staff_id makes on average more revenue per customer?
--Answer: staff_id 2 with an average revenue of 56.64 per customer.

SELECT staff_id, AVG(revenue) 
FROM (
	SELECT staff_id, customer_id, SUM(amount) as revenue
	FROM payment
	GROUP BY staff_id, customer_id 
	ORDER BY staff_id, customer_id) as subquery
GROUP BY staff_id;

--Question 10:
--Level: Difficult to very difficult
--Topic: EXTRACT + Uncorrelated subquery
--Task: Create a query that shows average daily revenue of all Sundays.
--Question: What is the daily average revenue of all Sundays?
--Answer: 1410.65

SELECT AVG(total_amount) 
FROM (
	SELECT SUM(amount) as total_amount, 
	DATE(payment_date),
	EXTRACT(dow from payment_date) as weekday
	FROM payment
	WHERE EXTRACT(dow from payment_date) = 0
	GROUP BY DATE(payment_date),weekday) as subquery

--Question 11:
--Level: Difficult to very difficult
--Topic: Correlated subquery
--Task: Create a list of movies - with their length and their replacement cost 
-- that are longer than the average length in each replacement cost group.
--Question: Which two movies are the shortest on that list and how long are they?
--Answer: CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes.

SELECT title, length, replacement_cost, (SELECT AVG(length) 
	FROM film f3 
	WHERE f1.replacement_cost = f3.replacement_cost)
FROM film f1
WHERE length > (
	SELECT AVG(length) 
	FROM film f2 
	WHERE f1.replacement_cost = f2.replacement_cost)
ORDER BY length;

--Question 12:
--Level: Very difficult
--Topic: Uncorrelated subquery
--Task: Create a list that shows the "average customer lifetime value" 
--grouped by the different districts.
--Example:
--If there are two customers in "District 1" where one customer has a total (lifetime) spent of $1000 and the second customer has a total spent of $2000 then the "average customer lifetime spent" in this district is $1500.
--So, first, you need to calculate the total per customer and then the average of these totals per district.
--Question: Which district has the highest average customer lifetime value?
--Answer: Saint-Denis with an average customer lifetime value of 216.54.

SELECT subquery.district, AVG(total_amount) FROM (
	SELECT a.district, p.customer_id, SUM(amount) as total_amount from payment p 
	JOIN customer c ON p.customer_id = c.customer_id
	JOIN address a ON c.address_id = a.address_id
	GROUP BY a.district,p.customer_id
	ORDER BY a.district ASC ,SUM(amount) DESC) as subquery
GROUP BY subquery.district
ORDER BY AVG(total_amount) DESC;

--Question 13:
--Level: Very difficult
--Topic: Correlated query
--Task: Create a list that shows all payments including the payment_id, amount, 
--and the film category (name) plus the total amount that was made in this category. 
--Order the results ascendingly by the category (name) and as second order criterion 
--by the payment_id ascendingly.
--Question: What is the total revenue of the category 'Action' and what is the lowest payment_id in that category 'Action'?
--Answer: Total revenue in the category 'Action' is 4375.85 and the 
-- lowest payment_id in that category is 16055.
SELECT p.payment_id, p.amount, c.name, (SELECT SUM(p1.amount)
FROM payment p1 
	LEFT OUTER JOIN rental r1 ON p1.rental_id = r1.rental_id
	LEFT OUTER JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	LEFT OUTER JOIN film_category fc1 ON i1.film_id = fc1.film_id
	WHERE c.category_id = fc1.category_id
GROUP BY fc1.category_id)
FROM payment p 
	LEFT OUTER JOIN rental r ON p.rental_id = r.rental_id
	LEFT OUTER JOIN inventory i ON r.inventory_id = i.inventory_id
	LEFT OUTER JOIN film_category fc ON i.film_id = fc.film_id
	LEFT OUTER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
ORDER BY p.payment_id ASC ;
	
--Bonus question 14:
--Level: Extremely difficult
--Topic: Correlated and uncorrelated subqueries (nested)
--Task: Create a list with the top overall revenue of a film title 
--(sum of amount per title) for each category (name).
--Question: Which is the top-performing film in the animation category?
--Answer: DOGMA FAMILY with 178.70.
SELECT f.title, (SELECT SUM(p1.amount)
	FROM payment p1 
		LEFT OUTER JOIN rental r1 ON p1.rental_id = r1.rental_id
		LEFT OUTER JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
		LEFT OUTER JOIN film_category fc1 ON i1.film_id = fc1.film_id
		WHERE f.film_id = fc1.film_id
	GROUP BY fc1.film_id) as sub
FROM film f
	LEFT OUTER JOIN film_category fc ON f.film_id = fc.film_id
	LEFT OUTER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Animation'
ORDER BY sub DESC


