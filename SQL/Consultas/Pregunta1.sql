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
