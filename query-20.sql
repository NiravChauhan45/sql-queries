WITH next_date_table AS (SELECT *,
LEAD(visit_date,1,'2021-01-01') OVER (PARTITION BY user_id ORDER BY visit_date) AS next_visit_date
FROM UserVisits)
-- SELECT user_id,visit_date, abs(DATEDIFF(visit_date, next_visit_date)) AS biggest_window FROM next_date_table
SELECT user_id, MAX(biggest_window) AS biggest_window
FROM (SELECT user_id, ABS(DATEDIFF(visit_date, next_visit_date)) AS biggest_window FROM next_date_table) AS temp
GROUP BY user_id;


WITH new_user AS (SELECT *,
ROW_NUMBER() OVER(PARTITION BY email) AS email_new
FROM users)`pdp_links`

SELECT id, email, NAME, created_at FROM new_user WHERE email_new=1

SELECT * FROM (SELECT *,
ROW_NUMBER() OVER(PARTITION BY email) AS email_new
FROM users) AS temp WHERE email_new=1