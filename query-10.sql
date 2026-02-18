-- Method - 1
SELECT ROUND(AVG(order_date=customer_pref_delivery_date)*100,2) AS immediate_percentage 
FROM delivery
WHERE (customer_id, order_date) IN(
SELECT customer_id, MIN(order_date) AS order_date
FROM `delivery`
GROUP BY customer_id);


-- Method - 2
WITH cte AS(
SELECT customer_id, MIN(order_date) AS first_order_date
FROM `delivery`
GROUP BY customer_id)

SELECT ROUND(AVG(order_date = customer_pref_delivery_date)*100,2) 
AS immediate_percentage 
FROM delivery d
JOIN cte
ON d.customer_id = cte.customer_id
AND d.order_date = cte.first_order_date