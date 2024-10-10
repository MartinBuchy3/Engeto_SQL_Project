-- Úkol 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT *
FROM t_martin_buchal_project_sql_primary_final AS prim 


SELECT
    food_category AS Food_category,
    payroll_year AS Period,
    round(avg(average_price), 2) AS Average_price_per_unit,
    round(avg(average_wages), 2) AS Average_wage,
    CONCAT(round(avg(average_wages) / avg(average_price)), ' ',
        CASE 
            WHEN food_category = 'Mléko polotučné pasterované' THEN 'l'
            WHEN food_category = 'Chléb konzumní kmínový' THEN 'kg'
            ELSE ''
        END
    ) AS Quantity_for_average_wage
FROM t_martin_buchal_project_sql_primary_final AS prim 
WHERE payroll_year IN (2006, 2018)
  AND food_category IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
GROUP BY food_category, payroll_year;