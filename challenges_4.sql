-- challenge 1
-- list firstname and last name in lower case 
-- where either firstname or last name having more than 10 letters
SELECT LOWER(first_name), LOWER(last_name) 
FROM customer
WHERE LENGTH(first_name)>10 OR LENGTH(last_name) > 10;

-- challenge 2
--Last 5 chars of email address EX: 'a.org'
-- extract '.' from the email address
SELECT email, RIGHT(email,5), LEFT(RIGHT(email,4),1)
FROM customer;

-- challenge 3
--  create list of email address 
-- "MARY.SMITH@sakilacustomer.org" > "M***@sakilacustomer.org"

SELECT LEFT(email,1)||'***'||RIGHT(email,19) as anonymized, email 
FROM customer;

-- challenge 4
-- extract first name from email address
-- and concatenate with lastname
SELECT email, 
last_name||', '||LEFT(email,POSITION('.' IN email)-1)
FROM customer;

-- challenge 5
-- create list of email address 
-- "MARY.SMITH@sakilacustomer.org" > "M***.S***@sakilacustomer.org"
SELECT email,
LEFT(email, 1)||'***'||SUBSTRING(email FROM POSITION('.' IN email) FOR 2)||'***'||
SUBSTRING(email FROM POSITION('@' IN email))
FROM customer;

-- create list of email address 
-- "MARY.SMITH@sakilacustomer.org" > "***Y.S***@sakilacustomer.org"
SELECT email,
'***'||SUBSTRING(email FROM POSITION('.' IN email)-1 FOR 3)||'***'||
SUBSTRING(email FROM POSITION('@' IN email))
FROM customer;

-- challenge 6
-- month with highest total payment amount
-- APRIL
SELECT 
EXTRACT(month from payment_date) as result_month, SUM(amount) as tot_amount
FROM payment
GROUP BY result_month
ORDER BY tot_amount DESC;

-- day of week with the highest total payment amount(0 is sunday)
-- Thursday
SELECT 
EXTRACT(dow from payment_date) as day_of_week, 
SUM(amount) as tot_amount
FROM payment
GROUP BY day_of_week
ORDER BY tot_amount DESC;

-- highest amount one customer has spent in a week
-- 73.98
SELECT 
customer_id,
EXTRACT(week from payment_date) as res_week, 
SUM(amount) as tot_amount
FROM payment
GROUP BY res_week, customer_id
ORDER BY tot_amount DESC;

-- challenge 7
-- group the sum of payment in Fri, 24/01/2020
SELECT 
SUM(amount) as tot,
TO_CHAR(payment_date, 'Dy, DD/MM/YYYY')as date_text
FROM payment
GROUP BY date_text
ORDER BY tot ASC;

-- group the sum of payment in May, 2020
SELECT 
SUM(amount) as tot,
TO_CHAR(payment_date, 'Mon, YYYY')as date_text
FROM payment
GROUP BY date_text
ORDER BY tot ASC;

-- group the sum of payment in Thu, 02:44
SELECT 
SUM(amount) as tot,
TO_CHAR(payment_date, 'Dy, HH:MI')as date_text
FROM payment
GROUP BY date_text
ORDER BY tot DESC;

-- challenge 8
-- list of rental durations of customer 35
SELECT customer_id, return_date-rental_date
FROM rental
WHERE customer_id = 35;

-- longest stay customer
SELECT customer_id, AVG(return_date-rental_date) as avg_stay
FROM rental
GROUP BY customer_id
ORDER BY avg_stay DESC;
