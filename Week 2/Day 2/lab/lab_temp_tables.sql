-------------------------------------------------------------------------------- 1.

CREATE OR REPLACE VIEW customer_rental_summary AS
SELECT c.customer_id, c.first_name, c.last_name, c.email, COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

SELECT *
FROM customer_rental_summary;

--------------------------------------------------------------------------------- 2.

drop table temp_total_paid;

create temporary table temp_total_paid as
select rs.customer_id, sum(p.amount) as total_paid
from customer_rental_summary rs
join payment p on rs.customer_id = p.customer_id
group by rs.customer_id;

SELECT *
FROM temp_total_paid;

-------------------------------------------------------------------------------- 3.

