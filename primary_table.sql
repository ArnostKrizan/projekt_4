 -- Vytvoření primární tabulky

CREATE TABLE t_arnost_krizan_project_SQL_primary_final AS
SELECT
    czechia_price_category.name AS Name,
    czechia_price.value AS Price,
    czechia_price_category.price_value AS Amount,
    czechia_price_category.price_unit AS Unit,
    AVG(czechia_payroll.value) AS Payroll,
    EXTRACT(YEAR FROM czechia_price.date_from) AS Year
FROM
    czechia_price
JOIN
    czechia_price_category ON czechia_price.category_code = czechia_price_category.code
LEFT JOIN
    czechia_payroll ON EXTRACT(YEAR FROM czechia_price.date_from) = czechia_payroll.payroll_year
WHERE
    czechia_price.region_code IS NOT NULL
    AND czechia_payroll.value_type_code = 5958
    AND czechia_payroll.calculation_code = 100
GROUP BY
    czechia_price_category.name, Year, czechia_price_category.price_value, czechia_price_category.price_unit
ORDER BY
    czechia_price_category.name ASC,
    Year ASC;

 -- Tabulka obsahuje názvy potravin, jejich ceny, množství a jednotku a průměrnou mzdu v letech