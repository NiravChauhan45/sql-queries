SELECT 
  s.user_id,
  COALESCE(c.confirmation_rate,0) AS confirmation_rate
FROM `signups` AS s
LEFT JOIN(
   SELECT user_id, AVG(ACTION='confirmed') AS confirmation_rate
   FROM `confirmations`
   GROUP BY user_id
) AS c
ON s.user_id = c.user_id;


SELECT s.user_id, COALESCE(AVG(c.action = 'confirmed'),0) AS confirmation_rate
FROM signups AS s
LEFT JOIN confirmations AS c
ON s.user_id = c.`user_id`
GROUP BY s.`user_id`;