-- 10. Obtener la cantidad de clientes por rangos etarios ([10–19], [20–29], etc.), 
--     que hayan realizado al menos una compra de acciones de “amzn”. La edad debe calcularse 
--     como la diferencia entre la fecha de corte 2025-05-16 y el campo “birthdate”

WITH clientes_compra_amzn AS (
    SELECT DISTINCT c.username, c.birthdate
    FROM customer c
    JOIN customer_account ca ON c.username = ca.username
    JOIN transactions ft ON ca.account_id = ft.account_id
    WHERE ft.transaction_code = 'buy' AND ft.symbol = 'amzn'
)
SELECT
    CASE 
      WHEN age BETWEEN 10 AND 19 THEN '10-19'
      WHEN age BETWEEN 20 AND 29 THEN '20-29'
      WHEN age BETWEEN 30 AND 39 THEN '30-39'
      WHEN age BETWEEN 40 AND 49 THEN '40-49'
      WHEN age BETWEEN 50 AND 59 THEN '50-59'
      ELSE '60+' 
    END AS rango_etario,
    COUNT(*) AS cantidad_clientes
FROM (
    SELECT username,
           CAST((julianday('2025-05-16') - julianday(birthdate))/365 AS INTEGER) AS age
    FROM clientes_compra_amzn
) AS sub
GROUP BY rango_etario
ORDER BY rango_etario;