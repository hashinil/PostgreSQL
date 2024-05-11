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


-- challenge 3
Create a table called songs with the following columns:

--1. During creation add the DEFAULT 'Not defined' to the genre.
--2. Add the not null constraint to the song_name column
--3. Add the constraint with default name to ensure the price is at least 1.99.
--4. Add the constraint date_check to ensure the release date is between today and
--01-01-1950.
--5. Try to insert a row like this:
--6. Modify the constraint to be able to have 0.99 allowed as the lowest possible price.
--7. Try agin to insert the row
CREATE TABLE songs (
	song_id SERIAL PRIMARY KEY,
	song_name VARCHAR(30) NOT NULL,
	genre VARCHAR(30) DEFAULT 'Not defined',
	price NUMERIC(4,2) CHECK(price>=1.99),
	release_date DATE CONSTRAINT date_check CHECK(release_date BETWEEN '01-01-1950' AND CURRENT_DATE)
);

INSERT INTO songs (song_name, price, release_date) 
VALUES ('SQL Song', 0.99, '01-07-2022');

ALTER TABLE songs
DROP CONSTRAINT songs_price_check;

ALTER TABLE songs
ADD CONSTRAINT songs_price_check CHECK(price>=0.99);

INSERT INTO songs (song_name, price, release_date) 
VALUES ('SQL Song', 0.99, '01-07-2022');
