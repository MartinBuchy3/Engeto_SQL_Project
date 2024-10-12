-- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

WITH average_prices AS (
    SELECT 
        payroll_year,
        food_category,
        AVG(average_price) AS avg_price
    FROM t_martin_buchal_project_sql_primary_final AS prim
    GROUP BY payroll_year, food_category
),
price_changes AS (
    SELECT 
        payroll_year,
        food_category,
        avg_price,
        LAG(avg_price) OVER (PARTITION BY food_category ORDER BY payroll_year) AS prev_avg_price
    FROM average_prices
),
percent_increase AS (
    SELECT
        food_category,
        ROUND((avg_price - prev_avg_price) / prev_avg_price * 100, 2) AS pct_increase
    FROM price_changes
    WHERE prev_avg_price IS NOT NULL
)
SELECT 
    food_category,
    CONCAT(ROUND(AVG(pct_increase), 2), ' %') AS avg_pct_increase
FROM percent_increase
GROUP BY food_category
ORDER BY AVG(pct_increase) ASC
LIMIT 10;
