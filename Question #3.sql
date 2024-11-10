 -- SQL Skript pro otázku č.3

WITH PriceComparison AS (
    SELECT
        Name,
        Price,
        Year,
        LEAD(Price) OVER (PARTITION BY Name ORDER BY Year) AS NextYearPrice
    FROM
        t_arnost_krizan_project_sql_primary_final
),
PriceChange AS (
    SELECT
        Name,
        (CAST(NextYearPrice AS DECIMAL(10,2)) / CAST(Price AS DECIMAL(10,2))-1) AS ChangeRatio
    FROM
        PriceComparison
    WHERE
        NextYearPrice IS NOT NULL
)
SELECT
    Name,
    ROUND(AVG(ChangeRatio) * 100, 2) AS AveragePercentageChange
FROM
    PriceChange
GROUP BY
    Name
ORDER BY
    AveragePercentageChange ASC;