 SELECT * FROM `employees_data_new`


SELECT *,
LEAD(salary, 2) OVER(ORDER BY salary DESC) AS next_sal,
LAG(salary, 2) OVER(ORDER BY salary DESC) AS prev_sal
FROM employees_data_new;

pdp_links

CREATE DATABASE ajio_new;


SELECT u.user_id AS buyer_id,
u.join_date,
COUNT(o.order_id) AS orders_in_2019
FROM users u
LEFT JOIN orders o
ON u.user_id = o.buyer_id
AND YEAR(o.order_date) = 2019
GROUP BY u.user_id, u.join_date;


-- Write your PostgreSQL query statement below
SELECT u.user_id as buyer_id,
u.join_date,
count(o.order_id) as orders_in_2019
FROM users u
LEFT JOIN orders o
ON u.user_id = o.buyer_id
AND EXTRACT (YEAR FROM o.order_date) = 2019
-- BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY u.user_id, u.join_date;


update `pdp_links` set status='Pending'
