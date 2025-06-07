-- 2. ¿Cuántos clientes poseen más de una cuenta?

SELECT COUNT(*)
FROM (
    SELECT username
    FROM customer_account
    GROUP BY username
    HAVING COUNT(account_id) > 1
) AS sub;