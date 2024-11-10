 -- SQL Skript pro otázku č.4

WITH YearlyAverage AS (
    SELECT
        Year,
       	Price AS AveragePrice,
        Payroll AS AveragePayroll
    FROM
        t_arnost_krizan_project_sql_primary_final
    GROUP BY
        Year
),
YearlyChange AS (
    SELECT
        Year,
        AveragePrice,
        AveragePayroll,
        LEAD(AveragePrice) OVER (ORDER BY Year) AS NextYearAveragePrice,
        LEAD(AveragePayroll) OVER (ORDER BY Year) AS NextYearAveragePayroll
    FROM
        YearlyAverage
),
PercentageChange AS (
    SELECT
        Year,
        ROUND((NextYearAveragePrice / AveragePrice) * 100, 2) AS YearlyChangePercentagePrice,
        ROUND((NextYearAveragePayroll / AveragePayroll) * 100, 2) AS YearlyChangePercentagePayroll
    FROM
        YearlyChange
    WHERE
        NextYearAveragePrice IS NOT NULL AND
        NextYearAveragePayroll IS NOT NULL
)
SELECT
    Year,
    YearlyChangePercentagePrice,
    YearlyChangePercentagePayroll
FROM
    PercentageChange
WHERE
    YearlyChangePercentagePrice >= YearlyChangePercentagePayroll + 10
ORDER BY
    Year;