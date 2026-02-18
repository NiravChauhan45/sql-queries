-- second higest salary

SELECT MAX(salary) AS second_higest_salary 
FROM `employees` 
WHERE salary < (SELECT MAX(salary) FROM employees)


-- Restaurant Growth | Subquery, date function, aggregations (Hard) (POINT 72, UBER, AMAZON, APPLE)
/*
create table Customer(
    customer_id int,
    name varchar(50),
    visited_on date,
    amount int
); 

INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES
(1, 'Jhon', '2019-01-01', 100),
(2, 'Daniel', '2019-01-02', 110),
(3, 'Jade', '2019-01-03', 120),
(4, 'Khaled', '2019-01-04', 130),
(5, 'Winston', '2019-01-05', 110),
(6, 'Elvis', '2019-01-06', 140),
(7, 'Anna', '2019-01-07', 150),
(8, 'Maria', '2019-01-08', 80),
(9, 'Jaze', '2019-01-09', 110),
(1, 'Jhon', '2019-01-10', 130),
(3, 'Jade', '2019-01-10', 150); */

select visited_on, 
(select sum(amount) from customer where visited_on between date_sub(c.visited_on, interval 6 day) and c.visited_on) as amount, 
round((SELECT SUM(amount)/7 FROM customer WHERE visited_on BETWEEN DATE_SUB(c.visited_on, INTERVAL 6 DAY) AND c.visited_on),2) as average_amount 
from customer c
where visited_on >= (select date_add(min(visited_on),interval 6 day) from customer)
group by visited_on 

