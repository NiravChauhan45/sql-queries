SELECT e.employee_id, 'Missing Salary' AS COMMENT
FROM employeess AS e
LEFT JOIN SALARIES AS s
ON e.employee_id = s.`Employee_ID`
WHERE s.`Employee_ID` IS NULL

UNION ALL

SELECT s.employee_id, 'Missing Employee' AS COMMENT
FROM employeess AS e
RIGHT JOIN SALARIES AS s
ON e.employee_id = s.Employee_ID
WHERE e.Employee_ID IS NULL

UNION ALL

SELECT e.`Employee_ID`,
CASE 
   WHEN s.`Salary` < d.min_salary THEN 'Unperpaid'
   WHEN s.`Salary` > d.max_salary THEN 'Overpaid'
END
FROM employeess e
INNER JOIN SALARIES s ON e.`Employee_ID` = s.`Employee_ID`
inner join departments d on e.`Department_ID` = d.Department_ID
where s.`Salary` < d.min_salary or s.`Salary` > d.max_salary
