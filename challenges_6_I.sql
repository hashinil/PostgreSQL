-- Challenge3 
-- customers live in Texas
select * from customer;
select * from address;

SELECT C.first_name
FROM customer C
LEFT JOIN address A
ON C.address_id =  A.address_id
WHERE A.district = 'Texas';

-- Addresses not related to customers
SELECT A.address
FROM customer C
RIGHT JOIN address A
ON C.address_id =  A.address_id
WHERE  C.address_id IS NULL;

-- customers from brazil
SELECT first_name, last_name, email, CO.country from customer C
LEFT JOIN address A
ON C.address_id = A.address_id
LEFT JOIN city CI
ON A.city_id = CI.city_id
LEFT JOIN country CO
ON CI.country_id = CO.country_id
WHERE country = 'Brazil';


-- WHICH title GEORGE LINTON rented most often
SELECT * FROM film;
SELECT * FROM rental;
SELECT * FROM customer;
SELECT * FROM payment;
select * from inventory;

SELECT F.title, COUNT(*)
FROM customer C
INNER JOIN rental R
ON C.customer_id = R.customer_id
AND C.first_name||' '||C.last_name ='GEORGE LINTON'
INNER JOIN inventory I
ON I.inventory_id = R.inventory_id
INNER JOIN FILM F
ON F.film_id = I.film_id
GROUP BY F.title
ORDER BY COUNT(*) DESC
