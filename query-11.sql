WITH temp AS (
	SELECT id, country, state, amount, DATE_FORMAT(trans_date, '%Y-%m') AS MONTH
	FROM Transactions
	WHERE state = 'approved'
	UNION ALL
	SELECT trans_id AS id, country, 'chargeback' AS state, amount, DATE_FORMAT(c.trans_date, '%Y-%m') AS MONTH
	FROM Chargebacks AS c
	JOIN Transactions AS t
	ON c.trans_id = t.id
)
SELECT 
    MONTH, country,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount,
    SUM(CASE WHEN state = 'chargeback' THEN 1 ELSE 0 END) AS chargeback_count,
    SUM(CASE WHEN state = 'chargeback' THEN amount ELSE 0 END) AS chargeback_amount
FROM temp
GROUP BY MONTH, country;