------------------------------------------------------------------------ 1.1

SELECT category.name AS category_name, COUNT(film.film_id) AS film_count
FROM sakila.film_category
INNER JOIN sakila.film ON film_category.film_id = film.film_id
INNER JOIN sakila.category ON film_category.category_id = category.category_id
GROUP BY category.name;

------------------------------------------------------------------------ 1.2

select store_id,city,country from sakila.store INNER join sakila.address on sakila.store.address_id = sakila.address.address_id
							INNER join sakila.city on sakila.city.city_id = sakila.address.city_id
                            inner join sakila.country on sakila.city.country_id = sakila.country.country_id;
                            
----------------------------------------------------------------------- 1.3

SELECT payment.staff_id, SUM(payment.amount) AS total_revenue
FROM sakila.payment
INNER JOIN sakila.staff ON staff.staff_id = payment.staff_id
GROUP BY payment.staff_id;
------ Version 2

SELECT staff_id, SUM(amount) AS total_revenue
FROM sakila.payment
GROUP BY staff_id;

------------------------------------------------------------------------ 1.4

select name, avg(length) as avg_duration From sakila.film_category 
		inner join sakila.film on film.film_id = film_category.film_id
		inner join sakila.category on category.category_id = film_category.category_id
		group by name;
                                    
------------------------------------------------------------------------ 1.5

select name, avg(length) as avg_duration From sakila.film_category 
		inner join sakila.film on film.film_id = film_category.film_id
		inner join sakila.category on category.category_id = film_category.category_id
		group by name order by avg_duration desc limit 1;
                                    
------------------------------------------------------------------------- 1.6

SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
INNER JOIN inventory ON inventory.film_id = film.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 10;
    
------------------------------------------------------------------------ 1.7

SELECT film.title, COUNT(inventory.store_id) AS copies_available_in_store2
FROM film
INNER JOIN inventory ON inventory.film_id = film.film_id
WHERE film.title LIKE '%Academy Dinosaur%'
  AND inventory.store_id = 2
GROUP BY film.title
ORDER BY copies_available_in_store2 DESC;

select*from inventory;