SELECT 
     DISTINCT p.customer_id,
     DATE_FORMAT(DATE_SUB('2023-12-01',INTERVAL (n.n-1) MONTH ), '%Y-%m') AS missing_month
FROM(
  SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
  UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
  UNION ALL SELECT 11 UNION ALL SELECT 12
) n
CROSS JOIN(SELECT DISTINCT customer_id FROM Purchases) p
LEFT JOIN Purchases pur
on p.customer_id = pur.customer_id
and DATE_FORMAT(pur.`purchase_date`, '%Y-%m') = DATE_FORMAT(DATE_SUB('2023-12-01',INTERVAL (n.n-1) MONTH ), '%Y-%m')
where pur.`purchase_date` is null
order by p.customer_id, missing_month;
