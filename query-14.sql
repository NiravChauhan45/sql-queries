SELECT * FROM `users_emails`;

SELECT SUBSTR(email,LOCATE('@',email)+1) AS domain, COUNT(*) AS COUNT
FROM users_emails
GROUP BY SUBSTR(email,LOCATE('@',email)+1)
ORDER BY COUNT DESC LIMIT 3;


SELECT user_id, GROUP_CONCAT(DISTINCT domain SEPARATOR ',') AS different_domains
FROM
(SELECT user_id, SUBSTR(email,LOCATE('@',email)+1) AS domain
FROM users_emails) AS user_domains
GROUP BY user_id
HAVING COUNT(DISTINCT domain) > 1; 

SELECT SUBSTR(email,LOCATE('@',email)+1) AS domain
FROM users_emails