-- UPDATE 
UPDATE customer
SET last_name ='BROWN'
WHERE customer_id = 1;

-- DELETE
DELETE FROM songs
WHERE song_id = 2;

DELETE FROM songs
WHERE song_id IN (3,4)
RETURNING song_name;

DELETE FROM songs
WHERE song_id =5
RETURNING *;

-- CREATE TABLE AS
CREATE TABLE customer_address
AS
SELECT first_name, last_name, email, address, city
FROM customer c
LEFT JOIN address a ON c.address_id = a.address_id
LEFT JOIN city cy ON a.city_id = cy.city_id;

SELECT * FROM customer_address;

-- CREATE VIEW AS
DROP TABLE customer_spending;

CREATE VIEW customer_spending
AS
SELECT first_name ||' '|| last_name as customer_name, SUM(p.amount) FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

SELECT * FROM customer_spending

-- Materialized view
CREATE MATERIALIZED VIEW mv_films_category
AS
SELECT title, length, c.name FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
WHERE c.name IN ('Action', 'Comedy')
ORDER BY length DESC;

SELECT * FROM mv_films_category;

UPDATE film 
SET length = 192
WHERE title = 'SATURN NAME';

REFRESH MATERIALIZED VIEW mv_films_category;