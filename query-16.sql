WITH points_agg AS (SELECT country, winery, SUM(points) AS total_points
FROM `wineries` GROUP BY country, winery),

cte_ranked AS (
SELECT country, CONCAT(winery," (",total_points,")") AS winery,
RANK() OVER(PARTITION BY country ORDER BY total_points DESC, winery) AS rnk
FROM points_agg)

SELECT 
     country,
     MAX(CASE WHEN rnk = 1 THEN winery END) AS top_winery,
     COALESCE(MAX(CASE WHEN rnk = 2 THEN winery ELSE NULL END),'No Second Winery') AS second_winery,
     COALESCE(MAX(CASE WHEN rnk = 3 THEN winery ELSE NULL END),'No Third Winery') AS third_winery 
FROM cte_ranked GROUP BY country;    
     
     
     
     