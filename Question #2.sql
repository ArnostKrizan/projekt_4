 -- SQL Skript pro otázku č.2

SELECT
    t.Name,
    ROUND(t.Payroll / t.Price, 1) AS Amount,
    t.Year
FROM
    t_arnost_krizan_project_SQL_primary_final as t
WHERE
    t.Name = 'Mléko polotučné pasterované' 
    AND t.Year IN (
        SELECT MIN(Year) FROM t_arnost_krizan_project_SQL_primary_final WHERE Name = 'Mléko polotučné pasterované'
        UNION
        SELECT MAX(Year) FROM t_arnost_krizan_project_SQL_primary_final WHERE Name = 'Mléko polotučné pasterované'
    )
ORDER BY
    t.Year;

SELECT
    t.Name,
    ROUND(t.Payroll / t.Price, 1) AS Amount,
    t.Year
FROM
    t_arnost_krizan_project_SQL_primary_final as t
WHERE
    t.Name = 'Chléb konzumní kmínový' 
    AND t.Year IN (
        SELECT MIN(Year) FROM t_arnost_krizan_project_SQL_primary_final WHERE Name = 'Chléb konzumní kmínový'
        UNION
        SELECT MAX(Year) FROM t_arnost_krizan_project_SQL_primary_final WHERE Name = 'Chléb konzumní kmínový'
    )
ORDER BY
    t.Year;