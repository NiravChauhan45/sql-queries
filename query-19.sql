WITH visits_with_next AS (
    SELECT
        *,
        LEAD(visit_date, 1, '2021-01-01') 
            OVER (PARTITION BY user_id ORDER BY visit_date) AS next_visit_date
    FROM `uservisits`
),
date_diff_table AS (
    SELECT
        user_id,
        DATEDIFF(next_visit_date, visit_date) AS biggest_window
    FROM visits_with_next
)

SELECT user_id, MAX(biggest_window) AS biggest_window
FROM date_diff_table
GROUP BY user_id;
