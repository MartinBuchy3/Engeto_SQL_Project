-- Vytvoření primární tabulky s propojením mzdových a cenových dat
-- Základ pro další postup projektu

-- Tabulka průměrných mezd

CREATE TABLE table_average_wages
SELECT
    cp.payroll_year,
    round(avg(cp.value)) AS average_wages,
    cpib.name AS industry_branch
FROM czechia_payroll AS cp
JOIN czechia_payroll_industry_branch cpib
    ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = '5958'
AND cp.calculation_code = '200'
AND cp.industry_branch_code IS NOT NULL
AND cp.payroll_year BETWEEN '2006' AND '2018'
GROUP BY cp.payroll_year, cpib.code
ORDER BY cp.payroll_year, cpib.code;

SELECT *
FROM table_average_wages AS taw ;

-- Tabulka průměrných cen potravin

CREATE TABLE table_average_price
SELECT
    cpc.name AS food_categories,
    cpc.price_value,
    cpc.price_unit,
    round(AVG(cp.value), 2) AS average_price,
    YEAR(cp.date_from) AS `year`
FROM
    czechia_price AS cp
JOIN
    czechia_price_category cpc
    ON cp.category_code = cpc.code
GROUP BY
	`year`, food_categories, cpc.price_value, cpc.price_unit;

SELECT *
FROM table_average_price AS tap

--  Propojení tabulek průměrných mezd a průměrných cen

CREATE TABLE t_martin_buchal_project_sql_primary_final
SELECT
	tap.food_categories,
	tap.price_value,
	tap.price_unit,
	tap.average_price,
	taw.payroll_year,
	taw.average_wages,
	taw.industry_branch
FROM average_price tap
JOIN average_wages taw
     ON tap.`year` = taw.payroll_year
ORDER BY taw.payroll_year, taw.industry_branch;


SELECT *
FROM t_martin_buchal_project_sql_primary_final








