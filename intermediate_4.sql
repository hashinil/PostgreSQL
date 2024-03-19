-- UPPER, LOWER, LENGTH
SELECT 
UPPER(email) as email_upper,
LOWER(email) as email_lower, 
LENGTH(email)
email
FROM customer
WHERE LENGTH(email)<30;

--challenge
SELECT review_id, review_text, LENGTH(review_text) as review_length
FROM customer_reviews
WHERE product_id = 101 AND LOWER(review_text) like '%great%'
ORDER BY review_length;

-- LEFT/ RIGHT
SELECT LEFT(first_name, 2), first_name, RIGHT(first_name, 2)
FROM customer;

--challenge
SELECT first_name, RIGHT(LEFT(first_name, 2),1)
FROM customer;

-- Concatenate
SELECT LEFT(first_name,1)||'.'||LEFT(last_name,1)||'.' as initials,
first_name, last_name
FROM customer;

--challenge
SELECT name ||' - '||category||': $'||price as product_summary
FROM products 
ORDER BY name ASC;

--Position
SELECT POSITION('@' IN email)
FROM customer;

SELECT LEFT(email, POSITION('@' IN email)-1)
FROM customer;

SELECT LEFT(email, POSITION(last_name IN email)-2)
FROM customer;

-- SUBSTRING
SELECT email, SUBSTRING(email FROM 3 FOR 5)
FROM customer;

SELECT email, SUBSTRING(email FROM POSITION('.' IN email)+1 FOR LENGTH(last_name))
FROM customer;

SELECT email, 
SUBSTRING(email FROM POSITION('.' IN email)+1 FOR (POSITION('@' IN email)-POSITION('.' IN email)-1))
FROM customer;

-- EXTRACT
SELECT 
EXTRACT(day from rental_date)
FROM rental;

SELECT 
EXTRACT(month from rental_date), COUNT(*)
FROM rental
GROUP BY EXTRACT(month from rental_date)
ORDER BY COUNT(*) DESC;

-- TO_CHAR
SELECT 
SUM(amount),TO_CHAR(payment_date, 'Dy, Month YYYY') as date_text
FROM payment
GROUP BY date_text
ORDER BY date_text;

--Timestamps
SELECT 
CURRENT_TIMESTAMP, rental_date
FROM rental;

SELECT 
CURRENT_DATE, rental_date
FROM rental;

-- Intervals
SELECT 
return_date - rental_date
FROM rental;

-- numeric
SELECT 
EXTRACT(day from return_date - rental_date)*24 +
EXTRACT(hour from return_date - rental_date)
FROM rental;

-- once concat with text - become text
SELECT 
EXTRACT(day from return_date - rental_date)*24 +
EXTRACT(hour from return_date - rental_date) ||' Hours'
FROM rental;

