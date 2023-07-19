SELECT concat(address,'. ',city,'. ',country) from sakila.address inner join sakila.city on sakila.address.city_id = sakila.city.city_id inner join sakila.country on sakila.country.country_id=sakila.city.country_id;
select*from sakila.film_actor;
select title, GROUP_CONCAT(first_name,' ',last_name,'   ')as Actor_repart from sakila.film_actor inner join sakila.actor on sakila.film_actor.actor_id=sakila.actor.actor_id inner join sakila.film on sakila.film_actor.film_id=sakila.film.film_id GROUP BY title;

select  concat(first_name,' ',last_name)as actor_in_movie, count(title) as movies from sakila.film_actor inner join sakila.actor on sakila.film_actor.actor_id=sakila.actor.actor_id inner join sakila.film on sakila.film_actor.film_id=sakila.film.film_id GROUP BY actor_in_movie;