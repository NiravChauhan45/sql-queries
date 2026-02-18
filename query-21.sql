SELECT date_id,
make_name,
COUNT(DISTINCT lead_id) AS unique_leads,
COUNT(DISTINCT partner_id) AS unique_partners
FROM `dailysales`
GROUP BY date_id, make_name;



SELECT *,
SUM(units_sold) OVER (PARTITION BY product_id ORDER BY sale_date) AS running_total
FROM sales;

SELECT *,
SUM(units_sold) OVER (ORDER BY sale_date, product_id) AS running_total
FROM sales;



SELECT *,
       SUM(units_sold) OVER (
           PARTITION BY product_id
           ORDER BY sale_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS rolling_units_sold
FROM sales;


SELECT *,
       SUM(units_sold) OVER (
           PARTITION BY product_id
           ORDER BY sale_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS rolling_units_sold
FROM sales;


select *,
sum(units_sold) over(partition by product_id order by sale_date desc
rows between CURRENT row AND 2 FOLLOWING) AS 3_day_sales
from sales;