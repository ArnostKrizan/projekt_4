 -- SQL Skript pro otázku č.3

WITH PriceComparison AS (
    SELECT
        Name,
        Price,
        Year,
        LEAD(Price) OVER (PARTITION BY Name ORDER BY Year) AS NextYearPrice
    FROM
        (SELECT DISTINCT Name, Price, Year
         FROM t_arnost_krizan_project_sql_primary_final) AS UniquePrices
),
PriceChange AS (
    SELECT
        Name,
        (CAST(NextYearPrice AS DECIMAL(10,2)) / CAST(Price AS DECIMAL(10,2)) - 1) * 100 AS YearlyChange
    FROM
        PriceComparison
    WHERE
        NextYearPrice IS NOT NULL
)
SELECT
    Name,
    ROUND(AVG(YearlyChange), 2) AS AveragePercentageChange
FROM
    PriceChange
GROUP BY
    Name
ORDER BY
    AveragePercentageChange DESC;
