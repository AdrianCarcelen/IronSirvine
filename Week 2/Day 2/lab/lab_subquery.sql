-------------------------------------------------------------------- 1.

SELECT 
    title, 
    (SELECT COUNT(inventory_id) FROM sakila.inventory WHERE inventory.film_id = film.film_id) AS number_copies
FROM 
    sakila.film
WHERE 
    title = 'Hunchback Impossible';
    
------------------------------------------------------------------- 2.

SELECT f.title, AVG(f.length) as avg_duration
FROM sakila.film f
INNER JOIN sakila.film_category fc ON f.film_id = fc.film_id
INNER JOIN sakila.category c ON c.category_id = fc.category_id
GROUP BY f.title
HAVING AVG(f.length) > (
    SELECT AVG(length)
    FROM sakila.film
)order by avg(length) desc;

------------------------------------------------------------------------------ 3.

SELECT actor_id, concat(first_name,'  ', last_name) as actor_work_on
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

-------------------------------------------------------------------------------- 4.

select film_id,title
from film
where film_id IN (
	select film_id
    from film_category
    where category_id = (
		select category_id 
		from category 
		where name = 'Family'
	)
);

-------------------------------------------------------------------------------- 5.

SELECT CONCAT(c.first_name, '  ', c.last_name) AS customer_name, c.email
FROM customer c
INNER JOIN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id IN (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
) a ON c.address_id = a.address_id;

--------------------------------------------------------------------- 6. 

SELECT CONCAT(a.first_name, '  ', a.last_name) AS actor_name, f.title
FROM film_actor fa
JOIN film f ON fa.film_id = f.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
)
ORDER BY a.actor_id DESC;
---------------------------------------------------------------------------------------------------------- version 2 with count
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor_name, f.title, 
       ROW_NUMBER() OVER (PARTITION BY fa.actor_id ORDER BY f.film_id DESC) AS film_counter
FROM film_actor fa
JOIN film f ON fa.film_id = f.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
)
ORDER BY a.actor_id DESC;

---------------------------------------------------------------------------- 7. #chek

SELECT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
JOIN (
    SELECT p.customer_id, SUM(p.amount) AS total_paid
    FROM payment p
    GROUP BY p.customer_id
    ORDER BY total_paid DESC
    LIMIT 1
) AS top_customer ON c.customer_id = top_customer.customer_id;

---------------------------------------------------------------------------- 8. 

SELECT customer_id, total_amount_spent
FROM (
  SELECT customer_id, SUM(amount) AS total_amount_spent
  FROM payment
  GROUP BY customer_id
) AS client_payments
WHERE total_amount_spent > (
  SELECT AVG(total_amount_spent)
  FROM (
    SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
  ) avg_payments
);
