SELECT * FROM tablea INNER JOIN tableb ON tablea.id = tableb.id;


SELECT * FROM tablea LEFT JOIN tableb ON tablea.id = tableb.id;


SELECT * FROM a INNER JOIN b  ON a.`val`=b.`val`

SELECT * FROM new_table
	
WITH temp_table AS (
SELECT id, num, LEAD(num) OVER(ORDER BY id) AS next_num, LAG(num) OVER(ORDER BY id) AS prev_num
FROM new_table
)
SELECT * FROM temp_table
WHERE num = next_num AND num=prev_num