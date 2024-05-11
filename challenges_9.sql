-- challenge 1
CREATE TABLE online_sales (
	transaction_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customer(customer_id), 
	film_id INT REFERENCES film(film_id),
	amount NUMERIC(5,2) NOT NULL,
	promotion_code VARCHAR(10) DEFAULT 'None'
);

-- challenge 2
INSERT INTO online_sales 
	(customer_id, film_id, amount, promotion_code)
VALUES
	(124, 65, 14.99, 'PROMO2022'),
	(225, 231, 12.99, 'JULYPROMO'),
	(119, 53, 15.99, 'SUMMERDEAL');

