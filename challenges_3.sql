-- Challenge 1
-- find out what is the minimum
-- the maximum
-- the average round it to two decimal
-- the sum of the replacement cost of the films.

SELECT 
	MIN(replacement_cost) AS min_cost, 
	MAX(replacement_cost) AS max_cost, 
	ROUND(AVG(replacement_cost), 2) AS avg_cost, 
	SUM(replacement_cost) as sum_cost
FROM film;

-- Challenge 2
-- find out which of the two employees, staff ID is responsible for more payments.
-- find out which of those two staff members higher overall payment amount.
SELECT staff_id, COUNT(*) AS no_of_payments, SUM(amount)
FROM payment
GROUP BY staff_id
ORDER BY no_of_payments DESC
LIMIT 2;

-- find out how would those numbers change if you would not consider the amounts that are equal to zero?
SELECT staff_id, COUNT(*) AS no_of_payments, SUM(amount)
FROM payment
WHERE amount != 0
GROUP BY staff_id
ORDER BY no_of_payments DESC
LIMIT 2;

-- challenge 3
-- there are now two competitions between the two employees.
-- The first competition is which of those employees had the highest sales amount in a single day.
-- And for this query, we want to not count the payments where the amount is equal to zero.
SELECT staff_id, DATE(payment_date), SUM(amount) as tot_sales_amt
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
ORDER BY tot_sales_amt DESC
LIMIT 1;

-- second competition is which of those employees had now the most number of sales in a single day?
-- And for this query, we want to not count the payments where the amount is equal to zero.
SELECT staff_id, DATE(payment_date), COUNT(*) as tot_no_of_sales
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
ORDER BY tot_no_of_sales DESC
LIMIT 1;

-- challenge 4
-- 2020, the day is April 28, 29 and 30
-- find out what is the average payment amount if we group by customer and date.
-- And on top of that we should limit our outputs to only those days and customers 
-- with more than one payment. So per customer and per day.
-- And now of course the results should be ordered by the average amount in a descending order 
-- so that we see the highest average payment amount for a given day customer combination.

SELECT 
customer_id, DATE(payment_date), COUNT(*), ROUND(AVG(amount),2)
FROM  payment
WHERE DATE(payment_date) IN ('2020-04-28', '2020-04-29', '2020-04-30')
GROUP BY customer_id, DATE(payment_date)
HAVING COUNT(*) > 1
ORDER BY ROUND(AVG(amount),2) DESC;




