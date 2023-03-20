UPDATE country_vaccination_stats -- After upload data from csv to database I used update command to update values
SET daily_vaccinations = subquery.median
FROM (
  SELECT country, ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY daily_vaccinations)) AS median
  FROM country_vaccination_stats
  WHERE daily_vaccinations IS NOT NULL -- It calculated median values which daily_vaccations is not null
  GROUP BY country
) AS subquery
WHERE country_vaccination_stats.country = subquery.country AND country_vaccination_stats.daily_vaccinations IS NULL;

-- I used nested query to get median values and fiil the missing values.After I calculate median values which grouped by country column
-- I fiiled the missing data. This code only run on POSTRESQL database
