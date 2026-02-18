SELECT * FROM `users_emails`

SELECT domain, COUNT(*) AS COUNT
FROM(SELECT SUBSTR(email, LOCATE('@',email)+1) AS domain FROM users_emails) AS d
GROUP BY domain
ORDER BY COUNT DESC
LIMIT 3;

SELECT user_id, GROUP_CONCAT(DISTINCT domain SEPARATOR ',') AS different_domains
FROM(SELECT user_id, SUBSTR(email, LOCATE('@',email)+1) AS domain FROM users_emails) AS user_domains
GROUP BY user_id
having count(distinct domain) > 1;




