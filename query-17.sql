WITH grp_cte AS (SELECT *,
SUM(result!='Win') OVER(PARTITION BY player_id ORDER BY match_day) AS grp_num
FROM matches),

window_cte AS (SELECT player_id, grp_num,
COUNT(1) AS streak,
ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY COUNT(1) DESC) AS rnum 
FROM grp_cte WHERE result = 'Win'
GROUP BY player_id, grp_num)

SELECT m.player_id,
CASE WHEN w.player_id IS NULL
THEN 0
ELSE w.streak
END AS longes_streak
FROM (SELECT DISTINCT player_id FROM matches) AS m
LEFT JOIN (SELECT * FROM window_cte WHERE rnum = 1) AS w
ON m.player_id = w.player_id;