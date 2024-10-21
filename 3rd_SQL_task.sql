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
        payroll_year,
        food_category,
        ROUND((avg_price - prev_avg_price) / prev_avg_price * 100, 2) AS pct_increase
    FROM price_changes
    WHERE prev_avg_price IS NOT NULL
)
-- Výběr kategorií, které rostly nejvíce a nejméně meziročně + průměrný nárůst
SELECT
    pi.food_category,
    -- Rok, kdy došlo k maximálnímu nárůstu
    (SELECT pi2.payroll_year 
     FROM percent_increase pi2 
     WHERE pi2.food_category = pi.food_category 
     ORDER BY pi2.pct_increase DESC 
     LIMIT 1) AS Year_of_max_increase,
    -- Rok, kdy došlo k minimálnímu nárůstu
    (SELECT pi3.payroll_year 
     FROM percent_increase AS pi3 
     WHERE pi3.food_category = pi.food_category 
     ORDER BY pi3.pct_increase ASC 
     LIMIT 1) AS Year_of_min_increase,
    ROUND(MAX(pi.pct_increase), 2) AS max_increase,  -- Největší meziroční nárůst
    ROUND(MIN(pi.pct_increase), 2) AS min_increase,  -- Nejmenší meziroční nárůst
    ROUND(AVG(pi.pct_increase), 2) AS avg_pct_increase  -- Průměrný meziroční nárůst
FROM percent_increase AS pi
GROUP BY pi.food_category
ORDER BY min_increase;