 -- SQL Skript pro otázku č.1

WITH AnnualPayroll AS (
    SELECT 
        Industry_Name AS Název_odvětví,
        Year AS Rok,
        AVG(Payroll) AS Průměrná_mzda
    FROM 
        t_arnost_krizan_project_SQL_primary_final
    WHERE 
        Payroll IS NOT NULL
    GROUP BY 
        Industry_Name, Year
),
PayrollChange AS (
    SELECT 
        Název_odvětví,
        Rok,
        Průměrná_mzda,
        LAG(Průměrná_mzda) OVER (PARTITION BY Název_odvětví ORDER BY Rok) AS Předchozí_mzda
    FROM 
        AnnualPayroll
),
PercentageChange AS (
    SELECT 
        Název_odvětví,
        ROUND(
            CASE 
                WHEN Předchozí_mzda IS NOT NULL THEN ((Průměrná_mzda - Předchozí_mzda) / Předchozí_mzda) * 100
                ELSE NULL
            END, 
            2
        ) AS Procentuální_změna
    FROM 
        PayrollChange
    WHERE 
        Předchozí_mzda IS NOT NULL
)
SELECT 
    Název_odvětví,
    ROUND(AVG(Procentuální_změna), 2) AS Průměrná_procentuální_změna
FROM 
    PercentageChange
GROUP BY 
    Název_odvětví
ORDER BY 
    Průměrná_procentuální_změna ASC;
