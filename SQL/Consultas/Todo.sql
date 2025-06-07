-- 1. Promedio, mínimo, máximo y desviación estándar del límite de las cuentas

SELECT 
    ROUND(AVG(limit_amount), 2) AS promedio_limite,
    ROUND(MIN(limit_amount), 2) AS minimo_limite,
    ROUND(MAX(limit_amount), 2) AS maximo_limite,
    ROUND(
        CASE 
          WHEN COUNT(*) > 1 THEN 
            sqrt(AVG((limit_amount - avg_limit)*(limit_amount - avg_limit)))
          ELSE 0
        END, 2
    ) AS desviacion_estandar
FROM (
    SELECT limit_amount, (SELECT AVG(limit_amount) FROM account) AS avg_limit
    FROM account
);

-- 2. ¿Cuántos clientes poseen más de una cuenta?

SELECT COUNT(*)
FROM (
    SELECT username
    FROM customer_account
    GROUP BY username
    HAVING COUNT(account_id) > 1
) AS sub;

-- 3. ¿Cuál es el monto promedio y el número de transacciones del mes de junio?
SELECT 
    ROUND(AVG(amount), 2) AS monto_promedio,
    COUNT(*) AS num_transacciones
FROM transactions
WHERE substr(transaction_date, 6, 2) = '06';

-- 4. ¿Cuál es el id de cuenta con la mayor diferencia entre su transacción más alta y más baja?

SELECT account_id, 
       MAX(amount) - MIN(amount) AS diferencia
FROM transactions
GROUP BY account_id
ORDER BY diferencia DESC
LIMIT 1;

-- 5. ¿Cuántas cuentas tienen exactamente 3 productos y, además, uno de esos productos es "Commodity"?

SELECT COUNT(*)
FROM (
    SELECT account_id
    FROM account_product
    GROUP BY account_id
    HAVING COUNT(product_name) = 3
       AND SUM(CASE WHEN product_name = 'Commodity' THEN 1 ELSE 0 END) >= 1
);

-- 6. ¿Cuál es el nombre del cliente que, en total entre todas sus cuentas, ha realizado la mayor cantidad de transacciones de tipo sell?

SELECT c.name
FROM customer c
JOIN customer_account ca ON c.username = ca.username
JOIN transactions ft ON ca.account_id = ft.account_id
WHERE ft.transaction_code = 'sell'
GROUP BY c.username
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 7. ¿Cuál es el usuario del cliente cuya cuenta tiene entre 10 y 20 transacciones de tipo “buy”, y que presenta el promedio de inversión más alto por operación de este tipo?

SELECT ca.username, 
       ROUND(AVG(ft.amount), 2) AS promedio_inversion
FROM transactions ft
JOIN customer_account ca ON ft.account_id = ca.account_id
WHERE ft.transaction_code = 'buy'
GROUP BY ca.username, ft.account_id
HAVING COUNT(*) BETWEEN 10 AND 20
ORDER BY promedio_inversion DESC
LIMIT 1;

-- 8. ¿Cuál es el promedio de transacciones de compra y de venta por acción (campo “symbol”)?

SELECT
    ROUND(AVG(buy_count), 2) AS promedio_buy,
    ROUND(AVG(sell_count), 2) AS promedio_sell
FROM (
    SELECT
        symbol,
        COUNT(CASE WHEN transaction_code = 'buy' THEN 1 END) AS buy_count,
        COUNT(CASE WHEN transaction_code = 'sell' THEN 1 END) AS sell_count
    FROM transactions
    GROUP BY symbol
)

-- 9. ¿Cuáles son los diferentes beneficios que tienen los clientes del tier “Gold”?

SELECT DISTINCT b.benefit_name
FROM tier t
JOIN tier_benefit tb ON t.tier_id = tb.tier_id
JOIN benefit b ON tb.benefit_name = b.benefit_name
WHERE t.tier_name = 'Gold' AND t.active = 1
ORDER BY b.benefit_name ASC;

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
           CAST((julianday('2025-05-16') - julianday(birthdate))/365.25 AS INTEGER) AS age
    FROM clientes_compra_amzn
) AS sub
GROUP BY rango_etario
ORDER BY rango_etario;
