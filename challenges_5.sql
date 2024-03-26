-- Challenge 1
-- List of films where the rental rate is less than 4% from replacement cost

SELECT 
film_id, rental_rate, replacement_cost, 
ROUND((rental_rate/replacement_cost)*100,2) 
FROM film
WHERE ROUND((rental_rate/replacement_cost)*100, 2)<4
ORDER BY ROUND((rental_rate/replacement_cost)*100, 2);