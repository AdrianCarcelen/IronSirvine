---------------------------------------------------------------------------------------------------------------------------------1. 

SELECT sakila.film.title, sakila.film.length
FROM sakila.film
WHERE length = (SELECT MAX(length) FROM sakila.film)
   OR length = (SELECT MIN(length) FROM sakila.film) ORDER BY sakila.film.length;

SELECT concat(floor(avg(film.length)/60),' hours ', round(avg(film.length)%60),' minutes.') as average_duration from sakila.film;

---------------------------------------------------------------------------------------------------------------------------------- 2.

select datediff(max(rental.rental_date) , min(rental.rental_date)) as operating_days from sakila.rental;
select rental.rental_id, rental.rental_date, month(rental.rental_date) as rental_month, dayname(rental.rental_date) as rental_weekday from sakila.rental limit 20;
SELECT *, rental_date, CASE WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN 'weekend' ELSE 'workday' END AS day_type FROM sakila.rental;

---------------------------------------------------------------------------------------------------------------------------------- 3.

SELECT film.title, case when rental_duration = NULL then 'Not Available' else rental_duration end as rental_duration FROM sakila.film;



