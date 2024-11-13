 -- Vytvoření sekundární tabulky

CREATE TABLE t_arnost_krizan_project_sql_secondary_final AS
SELECT 
    c.country,
    e.GDP,
    e.year
FROM 
    countries c
JOIN 
    economies e 
ON 
    c.country = e.country
ORDER BY 
    c.country, e.year; 

 -- Tabulka obsahuje jednotlivé světové země a jejich hodnotu HDP v letech
