-- FIFA World Cup Analysis(Mideum-hard)

-- Q-1: Scenario: Identify teams that have won all their matches and show the total number of goals scored by these teams in those matches.

SELECT team_name, COUNT(*) AS total_won, SUM(total_goals) AS total_goals
FROM
(SELECT home_team AS team_name, home_score AS total_goals
FROM matches
WHERE home_score > away_score
UNION ALL
SELECT away_team AS team_name, away_score AS total_goals
FROM matches
WHERE home_score < away_score) AS combined
GROUP BY team_name
HAVING COUNT(*) = (SELECT COUNT(*) FROM matches WHERE home_team = team_name OR away_team = team_name);



-- Q-2: Scenario: Find all pairs of teams that have played against each other at least twice, where one team has won all the matches.

select 
    least(home_team, away_team) as team1, 
    greatest(home_team, away_team) AS team2, 
    count(*) as num_matches,
    GROUP_CONCAT(winner separator ',') as winner_list
from(
   select home_team, away_team,
   case
      when home_score > away_score then home_team
      when away_score > home_score then away_team
      else 'draw'
   end as winner
   from matches) as c
group by LEAST(home_team, away_team), GREATEST(home_team, away_team)
having count(*) >= 2 and winner_list not like '%draw%' and count(distinct winner) = 1;
