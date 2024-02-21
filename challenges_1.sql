-- Challenge 1
-- a list of all of the customers with the first name of the customer, the last name and customer's email address.
SELECT * 
FROM customer;

SELECT first_name, last_name, email  
FROM customer;

-- Challenge 2
-- order the customer list that you have already given by the last name.
-- And they want to start working from Z towards a indebt list.
-- And also in case there is the same last name multiple times in the list, you should as a second criterion
-- also order by the first name and the first name in this case, as a second criterion should also be from Z to A.

SELECT first_name, last_name, email  
FROM customer
ORDER BY last_name DESC, first_name DESC;

SELECT first_name, last_name, email  
FROM customer
ORDER BY 2 DESC, 1 DESC;

-- Challenge 3
-- different prices in the business that have been paid in the past 
-- also order those prices from high to low.
SELECT DISTINCT amount
FROM payment
ORDER BY amount DESC
LIMIT 10;

-- challenge 4
-- create a list of all of the distinct districts
SELECT DISTINCT(district)
FROM address;

-- what is the latest rental date in the database?
SELECT rental_date 
FROM rental 
ORDER By rental_date DESC
LIMIT 1;

-- how many films does the company have?
SELECT COUNT(*)
FROM film;

-- how many distinct last names of the customers are there in our database?
SELECT COUNT(DISTINCT last_name) 
FROM customer;
