-- 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- vytvoření poddotazu pro průměrné ceny dle let
WITH yearly_avg_prices AS (
	SELECT 
		payroll_year AS Period,
		ROUND(AVG(average_price), 2) AS Average_price_per_year
	FROM t_martin_buchal_project_sql_primary_final AS prim
	GROUP BY payroll_year
	ORDER BY payroll_year
),
-- vytvoření poddotazu průměrné mzdy dle let
yearly_avg_wages AS (
	SELECT 
		payroll_year AS Period,
		ROUND(AVG(average_wages), 2) AS Average_wage_per_year
	FROM t_martin_buchal_project_sql_primary_final AS prim
	GROUP BY payroll_year
	ORDER BY payroll_year
),
-- vytvoření poddotazu pro nárůst cen v letech
price_increase AS (
	SELECT 
		pcur.Period AS Comparison_Year,
        pprev.Period AS Base_Year,
        pcur.Average_price_per_year AS current_price,
        pprev.Average_price_per_year AS previous_price,
        ((pcur.Average_price_per_year - pprev.Average_price_per_year) / pprev.Average_price_per_year) * 100 AS pct_increase_price
	FROM yearly_avg_prices AS pcur
	JOIN yearly_avg_prices AS pprev ON pcur.Period = pprev.Period + 1
),
-- vytvoření poddotazu pro nárůst mezd v letech
wage_increase AS (
    SELECT
        wcur.Period AS Comparison_Year,
        wprev.Period AS Base_Year,
        wcur.Average_wage_per_year AS current_wage,
        wprev.Average_wage_per_year AS previous_wage,
        ((wcur.Average_wage_per_year - wprev.Average_wage_per_year) / wprev.Average_wage_per_year) * 100 AS pct_increase_wage
    FROM yearly_avg_wages AS wcur
    JOIN yearly_avg_wages AS wprev ON wcur.Period = wprev.Period + 1
)
-- finální dotaz, ve kterém jsou k dispozici meziroční nárůsty mezd i cen a zároveň jejich vzájemný rozdíl, tedy odpověď na otázku 4. úkolu :).
SELECT
    pi.Base_Year,
    pi.Comparison_Year,
    ROUND(pi.pct_increase_price, 2) AS Price_increase_percentage,
    ROUND(wi.pct_increase_wage, 2) AS Wage_increase_percentage,
    ROUND(ABS(pi.pct_increase_price - wi.pct_increase_wage), 2) AS Absolute_Difference,
    CONCAT(ROUND(ABS(pi.pct_increase_price - wi.pct_increase_wage), 2), '%') AS Absolute_Difference_with_percent,
    -- Podmínka pro možné zvýraznění, pokud je absolutní rozdíl větší než 10 %, např. při přidání dalších dat.
    CASE 
        WHEN ABS(pi.pct_increase_price - wi.pct_increase_wage) > 10 THEN 'YES'
        ELSE 'NO'
    END AS '10%_Threshold'
FROM price_increase AS pi
JOIN wage_increase AS wi ON pi.Comparison_Year = wi.Comparison_Year AND pi.Base_Year = wi.Base_Year
ORDER BY Base_Year DESC;