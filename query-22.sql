SELECT employee_id, 
employee_name,
department,
salary,
hire_date,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_num
FROM `employees`;



-- using joins
WITH total_salary AS(
	SELECT department, SUM(salary) AS total_salary
	FROM employees
	GROUP BY department
)
SELECT e.*,d.total_salary FROM employees e
JOIN total_salary d
ON e.department = d.department;


-- Without using join	

SELECT employee_id, 
employee_name,
department,
salary,
hire_date,
sum(salary) OVER(PARTITION BY department) AS row_num
FROM `employees` order by employee_id;

-- running total
select *,
sum(salary) over(order by hire_date) as total_sal
from employees;


-- Without using join diffrent senario
SELECT *,
SUM(salary) OVER(PARTITION BY department, city) AS row_num
FROM `employees_data_new` ORDER BY department;

-- running total for each product
select *,
sum(units_sold) over(partition by product_id order by sale_date)
as running_total
from sales;


-- what if i remove partition by
-- In case of duplicats it consider it as one group
SELECT *,
SUM(units_sold) OVER(ORDER BY sale_date)
AS running_total
FROM sales;


-- you can always give a second column in order to remove the ties.
SELECT *,
SUM(units_sold) OVER(ORDER BY sale_date, product_id)
AS running_total
FROM sales;


-- what if I need to have a moving window of 3 days
select *,
sum(units_sold) over (partition by product_id order by sale_date
rows between 2 PRECEDING AND CURRENT ROW) as 3_day_window
from sales;

SELECT *,
SUM(units_sold) OVER (PARTITION BY product_id ORDER BY sale_date
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS 3_day_sales
FROM sales;

select *,
sum(units_sold) over(partition by product_id order by sale_date
rows between 2 PRECEDING and 2 FOLLOWING) AS 5_day_sales
FROM sales;


select *,
sum(units_sold) over(partition by product_id order by sale_date
rows between UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM sales;

SELECT *,
SUM(units_sold) OVER(PARTITION BY product_id ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total1,
SUM(units_sold) OVER(PARTITION BY product_id ORDER BY sale_date) AS running_total2
FROM sales;

SELECT *,
SUM(units_sold) OVER(PARTITION BY product_id ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS running_total
FROM sales;

SELECT *,
SUM(units_sold) OVER(PARTITION BY product_id ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS running_total1,
SUM(units_sold) OVER(PARTITION BY product_id) AS running_total2
FROM sales;


