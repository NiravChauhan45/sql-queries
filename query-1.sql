-- Question 1
WITH cte AS (
SELECT *,
  LAG(sales_amount) OVER(ORDER BY MONTH) AS prev_sales_amount
FROM sales_amount)

SELECT MONTH, (sales_amount-prev_sales_amount) AS diff FROM cte;


-- Question 2
WITH filtered_texts AS(
	SELECT text_id, email_id FROM texts WHERE signup_action = 'Confirmed'
), joined_table AS (
	SELECT e.user_id, e.email_id, t.text_id FROM emails AS e LEFT JOIN filtered_texts AS t ON e.email_id = t.email_id
)

SELECT ROUND(COUNT(text_id)/COUNT(DISTINCT email_id),2) AS confirm_rate FROM joined_table;


-- Question 3 - EMployee with max salary in the department
SELECT id, employee_name, salary, manager, deptid
FROM(
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY deptid ORDER BY salary DESC) AS rnk
FROM emp) AS sub WHERE rnk=1;


-- Question 4 - Employee who earns more than the manager?
SELECT e1.employee_name, e2.employee_name AS manager_name, e1.salary AS employee_salary, e2.salary AS manager_salary
FROM emp e1 INNER JOIN emp e2
ON e1.manager = e2.id
WHERE e1.manager IS NOT NULL



-- Question 5 - Calculate running total
SELECT *, SUM(profit) OVER(ORDER BY transaction_id) AS running_total
FROM transactions_new

-- Question 6 
SELECT id, NAME,
       GROUP_CONCAT(marks) AS marks
FROM candidate_information
GROUP BY id, NAME;

-- Question 7
SELECT e.employee_name
FROM emp e JOIN emp m
ON e.manager = m.id
WHERE e.salary > m.salary


-- Quetion 8 ( Find customer number who make most orders)
SELECT customer_number
FROM orders_new
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;


-- Question 9 SPLIT Values

SELECT
    SUBSTRING_INDEX(NAME,' ',1) AS FirstName,
    SUBSTRING_INDEX(NAME,' ',-1) AS LastName
FROM user_data


-- Question 10 Copy Table one to another
SELECT * INTO emp1 FROM emp2 WHERE 1 = 1;


-- Question 11 Find Duplicate Values
SELECT emp_n, salary, COUNT(*) AS cnt
FROM em
GROUP BY emp_n, salary
HAVING cnt > 1;

-- Apply row_number, rank and dense_rank
SELECT *,
    ROW_NUMBER() OVER(ORDER BY salary) AS row_rnk,
    RANK() OVER(ORDER BY salary) AS _rnk,
    DENSE_RANK() OVER(ORDER BY salary) AS dense_rnk
FROM em;


