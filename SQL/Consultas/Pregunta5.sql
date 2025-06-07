-- 5. ¿Cuántas cuentas tienen exactamente 3 productos y, además, uno de esos productos es "Commodity"?

SELECT COUNT(*)
FROM (
    SELECT account_id
    FROM account_product
    GROUP BY account_id
    HAVING COUNT(product_name) = 3
       AND SUM(CASE WHEN product_name = 'Commodity' THEN 1 ELSE 0 END) >= 1
);