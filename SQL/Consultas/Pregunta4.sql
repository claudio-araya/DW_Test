-- 4. ¿Cuál es el id de cuenta con la mayor diferencia entre su transacción más alta y más baja?

SELECT account_id, 
       MAX(amount) - MIN(amount) AS diferencia
FROM transactions
GROUP BY account_id
ORDER BY diferencia DESC
LIMIT 1;