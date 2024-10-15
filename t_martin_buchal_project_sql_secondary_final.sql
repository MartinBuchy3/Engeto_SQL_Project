CREATE OR REPLACE TABLE t_martin_buchal_project_sql_secondary_final AS 
	SELECT
		e.year AS Period,
		e.country AS Country,
		c.continent AS Continent,
		e.GDP,
		e.gini AS Ginis_coef,
		c.population AS Population
	FROM countries AS c 
	JOIN economies AS e 
		ON e.country = c.country
	WHERE c.continent = 'Europe' AND e.year BETWEEN 2006 AND 2018
	ORDER BY e.country, e.year;

SELECT *	
FROM t_martin_buchal_project_sql_secondary_final;