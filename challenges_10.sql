-- challenge 1
-- all rental price 0.99 to 1.99
UPDATE film 
SET rental_rate = 1.99
WHERE rental_rate =0.99;

-- add new column initials(varchar 10)
-- update initial column with data (frenak Smith > F.S.)
ALTER TABLE customer
ADD COLUMN initials VARCHAR(10);

SELECT LEFT(first_name,1) ||'.'|| LEFT(last_name,1) ||'.' as initials,
first_name, last_name
FROM customer;

UPDATE customer
SET initials = LEFT(first_name,1) ||'.'|| LEFT(last_name,1) ||'.';

SELECT * FROM customer;

-- challenge 2
-- delete rows with payment ID 17064, 17067

DELETE FROM payment
WHERE payment_id IN (17064, 17067)
RETURNING payment_id;

-- challenge 3
-- customer total spending 
CREATE TABLE customer_spending
AS
SELECT first_name ||' '|| last_name as customer_name, SUM(p.amount) FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

select * from customer_spending ORDER BY customer_name;

-- challenge 4
-- create view - film_category (title, length, category, ordered desc by length
-- filter only category  - action and comedy)

CREATE VIEW films_category
AS
SELECT title, length, c.name FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
WHERE c.name IN ('Action', 'Comedy')
ORDER BY length DESC;

-- challenge 5

CREATE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id;

ALTER VIEW v_customer_info
RENAME TO v_customer_information;

ALTER VIEW v_customer_information
RENAME COLUMN customer_id TO c_id;

CREATE OR REPLACE VIEW v_customer_information
AS
SELECT cu.customer_id as c_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country,
	LEFT(cu.first_name,1) || '.' || LEFT(cu.last_name,1) ||'.' AS initials
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id;