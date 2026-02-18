SELECT customer_id, SUM(total_spent) AS total_spent 
FROM(SELECT customer_id,
   DATE_FORMAT(purchase_date,'%Y-%m') AS MONTH,
   SUM(amount) AS total_spent
FROM Purchases
GROUP BY customer_id, DATE_FORMAT(purchase_date,'%Y-%m')
HAVING SUM(amount) > 10000
) c
GROUP BY customer_id
HAVING COUNT(*) = 12 