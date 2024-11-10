 -- SQL Skript pro otázku č.1

SELECT 
    czechia_payroll_industry_branch.name AS Název_odvětví,
    czechia_payroll.payroll_year AS Rok,
    ROUND(AVG(czechia_payroll.value)) AS Průměrná_mzda
FROM 
    czechia_payroll
JOIN 
    czechia_payroll_industry_branch 
ON 
    czechia_payroll.industry_branch_code = czechia_payroll_industry_branch.code
WHERE 
    czechia_payroll.value IS NOT NULL 
    AND czechia_payroll.value_type_code = 5958 
    AND czechia_payroll.calculation_code = 100
GROUP BY 
    czechia_payroll_industry_branch.name, czechia_payroll.payroll_year
ORDER BY 
    czechia_payroll_industry_branch.name ASC,
    czechia_payroll.payroll_year ASC;