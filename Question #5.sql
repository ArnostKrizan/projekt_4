 -- SQL Skript pro otázku č.5

WITH AvgValues AS (
    SELECT 
        e.year AS Year,
        AVG(e.GDP) AS Average_GDP,
        AVG(f.Price) AS Average_Food_Price,
        AVG(f.Payroll) AS Average_Payroll
    FROM 
        t_arnost_krizan_project_sql_secondary_final e
    JOIN 
        t_arnost_krizan_project_sql_primary_final f 
    ON 
        e.year = f.Year
    WHERE 
        e.country = 'Czech Republic'
    GROUP BY 
        e.year
)
SELECT 
    Year,
    CASE 
        WHEN LAG(Average_GDP) OVER (ORDER BY Year) IS NOT NULL 
        THEN ROUND(((Average_GDP * 100.0) / LAG(Average_GDP) OVER (ORDER BY Year)) - 100, 1) 
        ELSE NULL 
    END AS "GDP_1-y(%)",
    CASE 
        WHEN LAG(Average_Food_Price) OVER (ORDER BY Year) IS NOT NULL 
        THEN ROUND(((Average_Food_Price * 100.0) / LAG(Average_Food_Price) OVER (ORDER BY Year)) - 100, 1) 
        ELSE NULL 
    END AS "Food_1-y(%)",
    CASE 
        WHEN LAG(Average_Food_Price, 2) OVER (ORDER BY Year) IS NOT NULL 
        THEN ROUND(((Average_Food_Price * 100.0) / LAG(Average_Food_Price, 2) OVER (ORDER BY Year)) - 100, 1) 
        ELSE NULL 
    END AS "Food_2-y(%)",
    CASE 
        WHEN LAG(Average_Payroll) OVER (ORDER BY Year) IS NOT NULL 
        THEN ROUND(((Average_Payroll * 100.0) / LAG(Average_Payroll) OVER (ORDER BY Year)) - 100, 1) 
        ELSE NULL 
    END AS "Payroll_1-y(%)",
    CASE 
        WHEN LAG(Average_Payroll, 2) OVER (ORDER BY Year) IS NOT NULL 
        THEN ROUND(((Average_Payroll * 100.0) / LAG(Average_Payroll, 2) OVER (ORDER BY Year)) - 100, 1) 
        ELSE NULL 
    END AS "Payroll_2-y(%)"
FROM 
    AvgValues
ORDER BY 
    Year;
