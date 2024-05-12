-- challenge
-- booking amount breakdown of q, month, week in month, date
SELECT 'Q'||TO_CHAR(book_date, 'Q'),
EXTRACT(month FROM book_date) month_,
'W'||TO_CHAR(book_date, 'w'),
DATE(book_date),
SUM(total_amount)
FROM bookings
GROUP BY
	ROLLUP(
		'Q'||TO_CHAR(book_date, 'Q'),
		EXTRACT(month FROM book_date),
		'W'||TO_CHAR(book_date, 'w'),
		DATE(book_date)
	)
ORDER BY 1,2,3,4;