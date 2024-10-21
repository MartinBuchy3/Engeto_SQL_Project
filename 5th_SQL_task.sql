	-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
	-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin 
	-- či mzdách ve stejném nebo následujícím roce výraznějším růstem?
	
	-- HDP v České republice v letech 2006 - 2018
	CREATE OR REPLACE VIEW gdp_cz_2006_2018 AS 
	SELECT * 
	FROM t_martin_buchal_project_sql_secondary_final AS sec
	WHERE country = 'Czech Republic';
	
	SELECT * 
	FROM gdp_cr_2006_2018;
	
	-- HDP trend - meziroční vývoj
	
	CREATE OR REPLACE VIEW YoY_GDP_diff AS
	SELECT
	    gdp1.Period AS Base_Year,
	    gdp1.GDP AS Base_Year_GDP,
	    gdp2.Period AS Comparison_Year,
	    gdp2.GDP AS Comparison_Year_GDP,
	    ROUND(((gdp2.GDP - gdp1.GDP) / gdp1.GDP) * 100, 2) AS YoY_GDP_diff
	FROM gdp_cr_2006_2018 AS gdp1
	JOIN gdp_cr_2006_2018 AS gdp2
		ON gdp2.country = gdp1.country
	    AND gdp2.Period = gdp1.Period + 1
	ORDER BY gdp1.Period;
	
	SELECT *
	FROM YoY_GDP_diff;
	
	-- Mzdový trend - YoY změny
	CREATE OR REPLACE VIEW YoY_Wage_diff AS
	SELECT
	    aw.payroll_year AS Base_Year,
	    AVG(aw.average_wages) AS Base_Year_Wage,
	    aw2.payroll_year AS Comparison_Year,
	    AVG(aw2.average_wages) AS Comparison_Year_Wage,
	    ROUND(((AVG(aw2.average_wages) - AVG(aw.average_wages)) / AVG(aw.average_wages)) * 100, 2) AS YoY_Wages_diff
	FROM average_wages AS aw
	JOIN average_wages AS aw2
	    ON aw2.payroll_year = aw.payroll_year + 1
	GROUP BY aw.payroll_year, aw2.payroll_year
	ORDER BY aw.payroll_year;
	
	SELECT * FROM YoY_Wage_diff;
	
	-- Cenový trend - YoY změny
	CREATE OR REPLACE VIEW YoY_Price_diff AS
	SELECT
	    ap.year AS Base_Year,
	    AVG(ap.average_price) AS Base_Year_Price,
	    ap2.year AS Comparison_Year,
	    AVG(ap.average_price) AS Comparison_Year_Price,
	    ROUND(((AVG(ap2.average_price) - AVG(ap.average_price)) / AVG(ap.average_price)) * 100, 2) AS YoY_Price_diff
	FROM average_price AS ap
	JOIN average_price AS ap2
	    ON ap2.year = ap.year + 1
	GROUP BY ap.year, ap2.year
	ORDER BY ap.year;
	
	SELECT * FROM YoY_Price_diff;
	
	CREATE OR REPLACE VIEW YoY_Macro_Trend AS
		SELECT
			ygd.Base_Year,
			ygd.Comparison_Year,
			ygd.YoY_GDP_diff,
			ywd.YoY_Wages_diff,
			ypd.YoY_Price_diff
		FROM yoy_gdp_diff AS ygd 
		JOIN yoy_wage_diff AS ywd
			ON ywd.Base_Year = ygd.Base_Year
		JOIN YoY_Price_diff AS ypd 
			ON ypd.Base_Year = ygd.Base_Year;
		
	SELECT * 
	FROM YoY_Macro_Trend; -- výsledný dotaz pro meziroční porovnání růstu či poklesu GDP, mezd a cen
	
	
-- Výpočet korelace pro jednotlivé vztahy, dá nám lepší pohled na to, zda má výška HDP vliv na růst či pokles cen a mezd.
WITH avg_values AS (
    SELECT
        AVG(YoY_GDP_diff) AS avg_gdp,
        AVG(YoY_Wages_diff) AS avg_wages,
        AVG(YoY_Price_diff) AS avg_price
    FROM YoY_Macro_Trend
),
correlation AS (
    SELECT
        SUM((YoY_GDP_diff - avg_values.avg_gdp) * (YoY_Wages_diff - avg_values.avg_wages)) AS cor_gdp_wages,
        SUM((YoY_GDP_diff - avg_values.avg_gdp) * (YoY_Price_diff - avg_values.avg_price)) AS cor_gdp_price,
        SUM((YoY_Wages_diff - avg_values.avg_wages) * (YoY_Price_diff - avg_values.avg_price)) AS cor_wages_price,
        SQRT(SUM(POWER(YoY_GDP_diff - avg_values.avg_gdp, 2))) AS stddev_gdp,
        SQRT(SUM(POWER(YoY_Wages_diff - avg_values.avg_wages, 2))) AS stddev_wages,
        SQRT(SUM(POWER(YoY_Price_diff - avg_values.avg_price, 2))) AS stddev_price
    FROM YoY_Macro_Trend, avg_values
)
SELECT 
    ROUND(cov_gdp_wages / (stddev_gdp * stddev_wages), 2) AS Correlation_GDP_Wages,
    ROUND(cov_gdp_price / (stddev_gdp * stddev_price), 2) AS Correlation_GDP_Price,
    ROUND(cov_wages_price / (stddev_wages * stddev_price), 2) AS Correlation_Wages_Price
FROM correlation;