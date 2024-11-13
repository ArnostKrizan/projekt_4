 -- SQL Skript pro otázku č.4

WITH YearlyAverages AS (
    SELECT
        Year,
        AVG(Price) AS Avg_Price,
        AVG(Payroll) AS Avg_Payroll
    FROM
        t_arnost_krizan_project_SQL_primary_final
    GROUP BY
        Year
),
YearlyChanges AS (
    SELECT
        Year,
        Avg_Price,
        Avg_Payroll,
        LAG(Avg_Price) OVER (ORDER BY Year) AS Prev_Avg_Price,
        LAG(Avg_Payroll) OVER (ORDER BY Year) AS Prev_Avg_Payroll
    FROM
        YearlyAverages
)
SELECT
    Year,
    ROUND(((Avg_Price - Prev_Avg_Price) / Prev_Avg_Price) * 100 - ((Avg_Payroll - Prev_Avg_Payroll) / Prev_Avg_Payroll) * 100, 2) AS Value
FROM
    YearlyChanges
ORDER BY
    Value DESC, Year DESC;