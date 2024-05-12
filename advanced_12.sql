--GROUPING SETS

SELECT staff_id, TO_CHAR(payment_date, 'Month') as pay_month, SUM(amount) 
FROM payment
GROUP BY staff_id,TO_CHAR(payment_date, 'Month');

SELECT TO_CHAR(payment_date, 'Month') as pay_month, staff_id, SUM(amount) 
FROM payment
GROUP BY 
	GROUPING SETS(
		(staff_id),(pay_month),(staff_id,pay_month)
	)
ORDER BY 1,2;


-- ROLLUP
SELECT 'Q'||TO_CHAR(payment_date, 'Q'),
EXTRACT(month FROM payment_date),
DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY
	ROLLUP(
		'Q'||TO_CHAR(payment_date, 'Q'),
		EXTRACT(month FROM payment_date),
		DATE(payment_date)
	)
ORDER BY 1,2,3;

-- cube()
SELECT customer_id, staff_id,
DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY
	CUBE(
		customer_id, staff_id,DATE(payment_date)
	)
ORDER BY 1,2,3;

--selfjoin
CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);
	
SELECT emp.employee_id, emp.name, emp.manager_id, mng.employee_id, mng.name
FROM employee emp
LEFT JOIN employee mng ON emp.manager_id = mng.employee_id;

-- cross join
SELECT * FROM staff;
SELECT * FROM store;

SELECT staff_id, store.store_id
FROM staff CROSS JOIN store;

--natural join
SELECT * FROM payment 
NATURAL JOIN customer;