------------------------------------------------------------------- 1.show all tables

show tables from sakila;

-------------------------------------------------------------------- 2.Retrieve all the data from the tables actor, film and customer.

SELECT * from sakila.actor, sakila.film, sakila.customer; -- Option 1
SELECT * from sakila.actor;
SELECT * from sakila.film;
SELECT * from sakila.customer; -- Option 2

----------------------------------------------------------------------- 3.

SELECT title FROM sakila.film;
SELECT name AS language FROM sakila.language;
SELECT first_name FROM sakila.staff;

-------------------------------------------------------------------------- 4

select DISTINCT release_year from sakila.film;

-------------------------------------------------------------------------- 5

select count(store_id) from sakila.store;
SELECT count(staff_id) FROM sakila.staff;
SELECT film.film_id, film.title FROM sakila.film INNER JOIN sakila.inventory ON sakila.film.film_id = sakila.inventory.film_id INNER JOIN sakila.rental ON sakila.inventory.inventory_id = sakila.rental.inventory_id WHERE sakila.rental.return_date IS NULL;
-- with this one u chek the films actually are rented
SELECT film.film_id, film.title FROM sakila.film INNER JOIN sakila.inventory ON sakila.film.film_id = sakila.inventory.film_id LEFT JOIN sakila.rental ON sakila.inventory.inventory_id = sakila.rental.inventory_id WHERE sakila.rental.rental_id IS NULL;
-- with this one u chek the films actually are disposed to be rented
select count(distinct actor.last_name) as distinct_last_names from sakila.actor;

SELECT 
  COUNT(DISTINCT CASE WHEN rental.rental_id IS NOT NULL THEN inventory.inventory_id END) AS rented_copies,
  COUNT(DISTINCT CASE WHEN rental.rental_id IS NULL THEN inventory.inventory_id END) AS non_rented_copies
FROM sakila.inventory
LEFT JOIN sakila.rental ON inventory.inventory_id = rental.inventory_id;



select count(*) from inventory;

--------------------------------------------------------- 6.

select film.title,film.length from sakila.film order by film.length desc limit 10;

----------------------------------------------------------- 7.
select * from sakila.actor where actor.first_name = 'SCARLEtt';
select * from sakila.film where title LIKE '%ARMAGEDDON%' and film.length > 100;

