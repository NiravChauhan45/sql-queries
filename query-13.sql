TABLE 1 - `orders`
TABLE 2 - `customers`

-- natural JOIN

`orders``customers`

-- select * from c.customers where natural join select * from `customers`

SELECT * 
FROM `customers` AS c
FULL OUTER JOIN `orders` AS o
ON c.`customer_id` = o.`customer_id`;

TRUE
-- select * from `employees` order by salary desc LIMIT 1 OFFSET 2


-- wrong
with cte as (
	select count(*), department, max(salary) as highest_salary 
	from `employees` 
	group by department 
)
select * from cte




-- select count(*),department, salary from employees group by department, salary order by salary desc 
with t AS (
select *,
	row_number() over(partition by department order by salary desc) as rnk
from employees)
select * from t where rnk = 2

select * from( 
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS rnk
FROM employees
) t where rnk = 2

