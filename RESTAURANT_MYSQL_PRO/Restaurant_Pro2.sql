-- COUNT FUNCTION
SELECT * FROM bookings;
SELECT COUNT(*) FROM bookings;
SELECT COUNT(booking_date) FROM bookings;
SELECT COUNT(DISTINCT booking_date) FROM bookings;
SELECT COUNT(amount_tipped) FROM bookings;

-- MAX MIN FUNC
SELECT MAX(num_seats) FROM tables;
SELECT MIN(num_seats) FROM tables;
SELECT MAX(amount_billed) AS max_bill ,MAX(amount_tipped) AS max_tipped FROM bookings;
-- MAX AND MIN FUNCTION FOR BOOKING DATE IS LAST BOOKING DATE AND FIRST BOOKING DATE
SELECT booking_date FROM bookings;
SELECT MAX(booking_date) AS LATEST_BOOKING_DATE ,MIN(booking_date) AS FIRST_BOOKING_DATE FROM bookings;

-- SUM AVG
SELECT SUM(amount_billed) FROM bookings;
SELECT AVG(num_guests) FROM bookings;
SELECT ROUND(AVG(num_guests)) FROM bookings;
SELECT ROUND(AVG(num_guests),2) FROM bookings;
SELECT AVG(amount_tipped) FROM bookings;
-- NOTE AVERAGE IGNORES NULL AMOUNT

-- FILTERS
SELECT * FROM BOOKINGS;
SELECT ROUND(AVG(IFNULL(amount_tipped,NULL)),2) FROM bookings;
SELECT ROUND(AVG(amount_tipped),2) FROM bookings WHERE amount_tipped IS NOT NULL;

-- GROUP BY
-- WRONG ATTEMPT
SELECT booking_date AS date, SUM(num_guests) AS nr_guests FROM bookings;
-- RIGHT ATTEMPT
SELECT booking_date AS date, SUM(num_guests) AS nr_guests FROM bookings GROUP BY booking_date;

-- SELECT DISTINCT booking_date AS date, SUM(num_guests) AS nr_guests FROM bookings GROUP BY booking_date;

-- NO OF GUESTS USED PAYMENT METHODS
SELECT p.name ,SUM(b.num_guests)
FROM payment_methods AS p
INNER JOIN bookings AS B ON p.id = b.payment_id
GROUP BY p.name;

SELECT p.name,b.booking_date ,SUM(b.num_guests)
FROM payment_methods AS p
INNER JOIN bookings AS B ON p.id = b.payment_id
GROUP BY p.name,b.booking_date;

-- HAVING EXERCISE
SELECT booking_date,COUNT(booking_date)
FROM bookings
WHERE amount_billed > 30
GROUP BY booking_date;

SELECT booking_date,COUNT(booking_date)
FROM bookings
GROUP BY booking_date
HAVING SUM(amount_billed) > 30;

-- WINDOW FUNCTION
SELECT booking_date,amount_tipped,SUM(amount_tipped) OVER()
FROM bookings;

SELECT booking_date,amount_tipped,SUM(amount_tipped) OVER(PARTITION BY booking_date)
FROM bookings;

SELECT booking_date,amount_tipped,SUM(amount_tipped) 
OVER(PARTITION BY booking_date ORDER BY amount_billed)
FROM bookings;

SELECT booking_date,amount_tipped,RANK()
OVER(PARTITION BY booking_date ORDER BY amount_tipped DESC)
FROM bookings;

