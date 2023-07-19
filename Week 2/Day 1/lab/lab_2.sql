--------------------------------------------------------------------------------------------------------------------------------- 1

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

SELECT film.title, case when rental_duration is NULL then 'Not Available' else rental_duration end as rental_duration2 FROM sakila.film;

---------------------------------------------------------------------------------------------------------------------------------- 4

select substr(email,1,3) from sakila.customer;

----------------------------------------------------------------------------------------------------------------------------------- 2.1

select COUNT(title) from film;
select rating,count(rating) as quenta from film group by rating order by quenta DESC;

------------------------------------------------------------------------------------------------------------------------------------- 2.2

select concat(stf.first_name,' ', stf.last_name) as staff_name, rtl.staff_id, count(rtl.staff_id) from sakila.rental rtl inner join sakila.staff stf on stf.staff_id=rtl.staff_id group by staff_id order by staff_id desc;

------------------------------------------------------------------------------------------------------------------------------------ 2.3

select rating, round(avg(length),2) as avg_length from sakila.film group by rating having avg_length > 112 order by avg(length) desc;

----------------------------------------------------------------------------------------------------------------------------------- 2.4

select last_name, count(last_name) as x from sakila.actor group by last_name having x<2;
