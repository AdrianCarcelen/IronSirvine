---------------------------------------------------- 1. 

select age, count(*) as people_count from people  group by age;

---------------------------------------------------- 2. 

select age,count(age) as total_people from people  group by age having count(*) >= 10; 

---------------------------------------------------- 3. 

select people.*,count(toys.id) as toy_count 
from people
inner join toys on people.id = toys.people_id
group by people.id;

---------------------------------------------------- 4. 

select payment.customer_id, customer.email, count(payment_id) as payments_count, cast(sum(payment.amount) as float) as total_amount
from payment 
inner join customer on payment.customer_id = customer.customer_id
group by payment.customer_id, customer.email
order by total_amount desc 
limit 10;

---------------------------------------------------- 5. 

SELECT id, name
from departments
where id in (
     select department_id
     from sales
     where price > 98.00
);

---------------------------------------------------- 6. 

CREATE VIEW members_approved_for_voucher AS
SELECT members.id, members.name, members.email, SUM(products.price) AS total_spending 
FROM members
INNER JOIN sales ON sales.member_id = members.id
INNER JOIN products ON sales.product_id = products.id
INNER JOIN (
   SELECT department_id, SUM(products.price) as total_sales
   FROM sales
   INNER JOIN products ON sales.product_id = products.id
   GROUP BY department_id
   HAVING SUM(products.price) > 10000
) filtered_departments ON sales.department_id = filtered_departments.department_id
GROUP BY members.id, members.name, members.email
HAVING SUM(products.price) > 1000;

-- Utilizar la vista para seleccionar los resultados esperados
SELECT id, name, email, total_spending
FROM members_approved_for_voucher
ORDER BY id;