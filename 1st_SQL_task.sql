-- Úkol 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

CREATE TABLE Trend_table
SELECT 
	payroll_year AS 'Period',
	industry_branch AS 'Branch',
	AVG(average_wages) AS 'Average_wage',
	ROUND((LAG(AVG(average_wages)) OVER (PARTITION BY industry_branch ORDER BY payroll_year) - AVG(average_wages)), 1) * -1 AS 'YoY_diff',
	ROUND((LAG(AVG(average_wages)) OVER (PARTITION BY industry_branch ORDER BY payroll_year) * 100 / AVG(average_wages)) - 100, 1) * -1 AS 'YoY_%_diff',
	CASE
        WHEN LAG(AVG(average_wages)) OVER (PARTITION BY industry_branch ORDER BY payroll_year) > average_wages THEN 'Decrease'
        WHEN LAG(AVG(average_wages)) OVER (PARTITION BY industry_branch ORDER BY payroll_year) < average_wages THEN 'Increase'
        WHEN payroll_year = 2006 THEN 'Base year'
        ELSE 'Without major change'
    END AS 'Trend'
FROM t_martin_buchal_project_sql_primary_final AS prim
GROUP BY payroll_year, industry_branch, average_wages 
ORDER BY Branch, Period;

-- Úprava NULL hodnot
UPDATE Trend_table
SET 
    `YoY_%_diff` = COALESCE(`YoY_%_diff`, 0),
    `YoY_diff` = COALESCE(`YoY_diff`, 0)
WHERE `YoY_%_diff` IS NULL OR `YoY_diff` IS NULL;

-- Výsledná tabulka porovnání růstů/poklesů mezd v letech.

SELECT *
FROM Trend_table AS tt;

-- Ve kterých odvětvích mzdy klesají a v jakých letech?

SELECT 
	Branch,
	Period,
	Trend,
	SUM(YoY_diff) AS YoY_decrease,
	SUM(`YoY_%_diff`) AS YoY_perc_decrease
FROM Trend_table
WHERE Trend = 'Decrease'
GROUP BY Branch, Period
ORDER BY YoY_decrease;

