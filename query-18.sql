-- Approch 1

WITH cte AS(
SELECT 
   match_id,
   first_player AS player,
   first_score AS score
FROM `matches`
UNION ALL
SELECT 
   match_id,
   second_player AS player,
   second_score AS score
FROM `matches`),
cte_joined AS (
SELECT c.*, p.group_id
FROM cte AS c
JOIN `players` AS p
ON c.player = p.player_id),
cte_grouped as(
select group_id, player, sum(score) as total_score
from cte_joined
group by group_id, player
), cte_windowed as(
select group_id, player,
rank() over(partition by group_id order by total_score desc, player) as rnk
from cte_grouped
)

select group_id, player as player_id 
from cte_windowed where rnk = 1;



-- Approch - 2 
select group_id, player_id from( 
select group_id, player_id, total_score,
RANK() OVER(PARTITION BY group_id ORDER BY total_score DESC, player_id) AS rnk
from (
select p.group_id, p.player_id,
sum(case when p.`player_id` = m.`first_player` then m.`first_score` else m.`second_score` end) as total_score
from Players as p
join matches as m
on p.`player_id` in (m.`first_player`,m.`second_player`)
group by p.`group_id`, p.`player_id`) temp ) final where rnk = 1;