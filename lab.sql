-- Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental
SELECT rental_id, rental_date,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

-- Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week
SELECT rental_id, rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- Retrieve the film titles and their rental duration, replacing NULL values with 'Not Available', and sorting by title in ascending order
SELECT title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 1.1 Total number of films that have been released
SELECT COUNT(*) AS total_films_released
FROM film;

-- 1.2 Number of films for each rating
SELECT rating,
    COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted in descending order of the number of films
SELECT rating,
    COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2.1 Mean film duration for each rating, sorted in descending order of the mean duration
SELECT rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify ratings with a mean duration of over two hours
SELECT rating,
    ROUND(AVG(length)) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;