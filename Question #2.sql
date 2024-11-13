 -- SQL Skript pro otázku č.2

WITH Food AS (
    SELECT
        t.Name,
        t.Payroll,
        t.Price,
        t.Year
    FROM
        t_arnost_krizan_project_SQL_primary_final as t
    WHERE
        t.Name = 'Mléko polotučné pasterované'
)
SELECT
    m.Name,
    ROUND(AVG(m.Payroll / m.Price), 1) AS Amount,
    m.Year
FROM
    Food m
WHERE
    m.Year IN (
        SELECT MIN(Year) FROM Food
        UNION
        SELECT MAX(Year) FROM Food
    )
GROUP BY
    m.Name, m.Year
ORDER BY
    m.Year;


WITH Food AS (
    SELECT
        t.Name,
        t.Payroll,
        t.Price,
        t.Year
    FROM
        t_arnost_krizan_project_SQL_primary_final as t
    WHERE
        t.Name = 'Chléb konzumní kmínový'
)
SELECT
    m.Name,
    ROUND(AVG(m.Payroll / m.Price), 1) AS Amount,
    m.Year
FROM
    Food m
WHERE
    m.Year IN (
        SELECT MIN(Year) FROM Food
        UNION
        SELECT MAX(Year) FROM Food
    )
GROUP BY
    m.Name, m.Year
ORDER BY
    m.Year; 