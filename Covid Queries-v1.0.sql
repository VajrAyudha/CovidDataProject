
-- ALL COVID QUERIES


SELECT DISTINCT CONTINENT
FROM [dbo].[CovidDeaths]
WHERE 1=1 ;

SELECT CONTINENT,  MAX(CAST(TOTAL_DEATHS AS INT)) TOTAL_DEATH_COUNT
FROM [dbo].[CovidDeaths]
WHERE 1=1
AND CONTINENT  IS NOT  NULL
--AND CONTINENT = 'North America'
GROUP BY CONTINENT
ORDER BY 1;



SELECT LOCATION,  MAX(CAST(TOTAL_DEATHS AS INT)) TOTAL_DEATH_COUNT
FROM [dbo].[CovidDeaths]
WHERE 1=1
AND CONTINENT  IS NOT  NULL
--AND CONTINENT = 'North America'
GROUP BY LOCATION
ORDER BY 1;




SELECT ISO_CODE,CONTINENT,LOCATION, DATE, TOTAL_CASES,NEW_CASES, TOTAL_DEATHS, POPULATION
FROM  CovidProject..CovidDeaths
WHERE 1=1
AND CONTINENT = 'North America'
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
ORDER BY 1,3 ASC;

-- Loking at Total Cases vs Total Deaths
--CONVERT(varchar, CAST(TOTAL_CASES AS int), 1) as TOTAL_CASES_MAX


SELECT DISTINCT ISO_CODE
,LOCATION
, DATE
, POPULATION 
,MAX(TOTAL_CASES) as "HIGHEST INFECTION COUNT"
--,SUM(CONVERT(DECIMAL(15, 3), total_cases ))  AS AGGERATE_CASES
,TOTAL_CASES
, TOTAL_DEATHS
, (CONVERT(DECIMAL(15, 1),total_deaths) / CONVERT(DECIMAL(15, 3), total_cases ))*100  AS "PERCENTAGE OF DEATHS"
FROM  CovidProject..CovidDeaths
WHERE 1=1
AND LOCATION = 'United States'
AND DATE = '2021-10-04'
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
GROUP BY ISO_CODE
,LOCATION
, DATE
, POPULATION 
,TOTAL_CASES
, TOTAL_DEATHS
ORDER BY 8 DESC;



SELECT ISO_CODE,LOCATION, DATE, TOTAL_CASES,NEW_CASES, TOTAL_DEATHS, POPULATION
FROM  CovidProject..CovidDeaths
WHERE 1=1
AND CONTINENT IS NOT NULL
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
ORDER BY 1,3 ASC;

-- Loking at HIGHEEST INFECTIONF COUNT vs Total Deaths


SELECT DISTINCT 
LOCATION
, POPULATION 
,TOTAL_CASES
,MAX(TOTAL_CASES) as HIGHEST_INFECTION_COUNT
,MAX(TOTAL_DEATHS) AS MAX_DEATHS
,MAX((CONVERT(DECIMAL(17, 3),TOTAL_CASES) / POPULATION))*100   "%AGE OF POPULATION INFECTED by TOTAL CASES"
, (CONVERT(DECIMAL(15, 1),total_deaths) / CONVERT(DECIMAL(15, 3), total_cases ))*100  AS "PERCENTAGE OF DEATHS BY CASES"
, ((CONVERT(DECIMAL(15, 1),total_deaths) / POPULATION ))*100  AS "PERCENTAGE OF DEATHS BY POPULATION"
--, CONVERT(DECIMAL(15, 1),total_deaths)*100 / CONVERT(DECIMAL(15, 3), total_cases )  AS "PERCENTAGE OF POPULATION INFECTED"
FROM  CovidProject..CovidDeaths
WHERE 1=1
/*
AND LOCATION in (
    'United States'
    ,'Germany'
    ,'India'
)
*/
AND DATE = '2021-10-04'
AND CONTINENT IS NOT NULL
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
GROUP BY 
LOCATION
,POPULATION 
, TOTAL_CASES
,TOTAL_DEATHS
ORDER BY 5 DESC;


-- SHOWING ALL COUNTRIES HIGHEST DEATH COUNT PER POPULATION

SELECT  SUM(CAST(A.TOTAL_DEATHS AS INT)) AS WORLD_DEATHS
FROM
(
SELECT DISTINCT 
LOCATION
, POPULATION 
,TOTAL_CASES
,TOTAL_DEATHS
,MAX(TOTAL_CASES) as HIGHEST_INFECTION_COUNT
,MAX(CAST(TOTAL_DEATHS AS INT)) AS TOTAL_DEATH_COUNT
,MAX((CAST(TOTAL_CASES AS INT) / POPULATION))*100   "%AGE OF POPULATION INFECTED by TOTAL CASES"
, MAX(CAST(total_deaths AS FLOAT) / CAST( total_cases AS FLOAT ))*100  AS "PERCENTAGE OF DEATHS BY CASES"
, MAX((CAST(total_deaths AS INT) / POPULATION ))*100  AS "PERCENTAGE OF DEATHS BY POPULATION"
--, CONVERT(DECIMAL(15, 1),total_deaths)*100 / CONVERT(DECIMAL(15, 3), total_cases )  AS "PERCENTAGE OF POPULATION INFECTED"
FROM  CovidProject..CovidDeaths
WHERE 1=1
/*
AND LOCATION in (
    'United States'
    ,'Germany'
    ,'India'
)
*/
AND DATE = '2021-10-04'
AND CONTINENT IS NOT NULL
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
GROUP BY
LOCATION
,POPULATION 
, TOTAL_CASES
,TOTAL_DEATHS
) A


-- ROLL UP BY CONTINENT

SELECT  DISTINCT
 A.CONTINENT
  ,SUM(CAST(TOTAL_DEATHS AS INT)) AS TOTAL_DEATHS
/* ,MAX(TOTAL_CASES) as HIGHEST_INFECTION_COUNT
,MAX((CAST(TOTAL_CASES AS INT) / POPULATION))*100   "%AGE OF POPULATION INFECTED by TOTAL CASES"
, MAX(CAST(total_deaths AS FLOAT) / CAST( total_cases AS FLOAT ))*100  AS "PERCENTAGE OF DEATHS BY CASES"
 , MAX((CAST(total_deaths AS INT) / POPULATION ))*100  AS "PERCENTAGE OF DEATHS BY POPULATION"
, CONVERT(DECIMAL(15, 1),total_deaths)*100 / CONVERT(DECIMAL(15, 3), total_cases )  AS "PERCENTAGE OF POPULATION INFECTED" */
FROM
(
SELECT DISTINCT 
CONTINENT
,POPULATION
,TOTAL_CASES
,TOTAL_DEATHS
FROM  CovidProject..CovidDeaths
WHERE 1=1
/* AND LOCATION in (
    'United States'
    ,'Germany'
    ,'India'
) */
--AND DATE = '2021-10-04'
AND CONTINENT IS  NOT NULL
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
GROUP BY
CONTINENT
,POPULATION
,TOTAL_CASES
,TOTAL_DEATHS
) A
WHERE 1=1 
--AND CONTINENT = 'North America'
GROUP BY
CONTINENT
ORDER BY 2 DESC;


-- ROLL UP BY CONTINENT

/* 
SELECT 
'Total World Casualty' WORLD_TOTAL
,SUM(CAST(TOTAL_DEATHS AS INT) ) AS WORLD_CASUALITIES
FROM 
( */
    
SELECT  DISTINCT
 A.CONTINENT
,MAX(CAST(TOTAL_DEATHS AS INT)) AS TOTAL_DEATH_COUNT
FROM
(
SELECT DISTINCT 
CONTINENT
,POPULATION
,TOTAL_CASES
,TOTAL_DEATHS
--,MAX(CAST(TOTAL_DEATHS AS INT)) AS TOTAL_DEATH_COUNT
/* ,MAX(TOTAL_CASES) as HIGHEST_INFECTION_COUNT
,MAX((CAST(TOTAL_CASES AS INT) / POPULATION))*100   "%AGE OF POPULATION INFECTED by TOTAL CASES"
, MAX(CAST(total_deaths AS FLOAT) / CAST( total_cases AS FLOAT ))*100  AS "PERCENTAGE OF DEATHS BY CASES"
, MAX((CAST(total_deaths AS INT) / POPULATION ))*100  AS "PERCENTAGE OF DEATHS BY POPULATION"
, CONVERT(DECIMAL(15, 1),total_deaths)*100 / CONVERT(DECIMAL(15, 3), total_cases )  AS "PERCENTAGE OF POPULATION INFECTED" */
FROM  CovidProject..CovidDeaths
WHERE 1=1
/* AND LOCATION in (
    'United States'
    ,'Germany'
    ,'India'
) */
--AND DATE = '2021-10-04'
AND CONTINENT IS  NOT NULL
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
/* 
GROUP BY
CONTINENT
,POPULATION
,TOTAL_CASES
,TOTAL_DEATHS */
) A
WHERE 1=1 
--AND CONTINENT = 'North America'
GROUP BY 
CONTINENT
ORDER BY 1 DESC;
/* ) WORLD
; */


-- TOTAL CASES, TOTAL DEATHS AND DEATH PERCENTAGE by DATE


SELECT 
--DATE 
LOCATION
,SUM(CONVERT(DECIMAL(9,0),TOTAL_CASES )) AS CUMULATIVE_CASES
--,SUM(NEW_DEATHS) AS NEW_DEATHS
,SUM(CAST(TOTAL_DEATHS AS INT)) TOTAL_DEATHS
,SUM(CAST(NEW_DEATHS AS INT)) NEW_DEATHS
,SUM(CAST(NEW_CASES AS INT)) NEW_CASES
, SUM(CAST(NEW_DEATHS AS INT)) / SUM(NEW_CASES)*100 AS Death_Percentage
FROM CovidProject..CovidDeaths
WHERE 1=1 
--AND DATE >= '2021-10-04'
AND CONTINENT IS  NOT NULL
AND date IS NOT NULL
AND total_cases IS NOT NULL 
AND new_cases is NOT NULL
AND total_deaths IS NOT NULL
GROUP BY 
LOCATION
--DATE
ORDER BY 1,3 DESC;




-- VACCINATIONS DETAILS


SELECT  
dea.continent
,dea.location
, dea.date
, dea.population
, vac.NEW_VACCINATIONS
,SUM(CONVERT(DECIMAL(10,0),vac.new_vaccinations )) OVER (PARTITION BY dea.Location order by dea.location,dea.date) as ROLLING_NEW_VACCINATIONS
--,(ROLLING_NEW_VACCINATION)/population*100 AS 
FROM [dbo].['Covid-Vaccination] dea
JOIN [dbo].['Covid-Vaccination] vac
on dea.location = vac.location
WHERE 1=1
AND dea.continent IS NOT NULL
and dea.date = '01-01-2021'
ORDER BY 2,3
;


-- USE CTE  and  GET DATA BY CONTINENT and LOCATION

WITH PopulationVSVaccination (continent,location,POPULATION,NEW_VACCINATIONS,ROLLING_NEW_VACCINATIONS)
AS
(
SELECT  
dea.continent
,dea.location
--, dea.date
, dea.population
, vac.NEW_VACCINATIONS
,SUM(CONVERT(DECIMAL(10,0),vac.new_vaccinations )) OVER (PARTITION BY dea.Location order by dea.location) as ROLLING_NEW_VACCINATIONS
--,(ROLLING_NEW_VACCINATION)/population*100 AS 
FROM [dbo].['Covid-Vaccination] dea
JOIN [dbo].['Covid-Vaccination] vac
on dea.location = vac.location
AND DEA.[date] = VAC.[date]
WHERE 1=1
AND dea.continent IS NOT NULL
--and dea.date = '01-01-2021'
--ORDER BY 2,3
)
SELECT*, (ROLLING_NEW_VACCINATIONS)/population*100 AS  VaccByPopulation
 FROM PopulationVSVaccination
 WHERE 1=1
 AND NEW_VACCINATIONS IS NOT NULL
 ORDER BY 2,3;





-- USE CTE  and DO A MAX to GET DATA BY CONTINENT and LOCATION IN FULL

WITH PopulationVSVaccinationMAX (continent,location,POPULATION,NEW_VACCINATIONS,Rolling_Population_Vaccinated)
AS
(
SELECT  
dea.continent
,dea.location
--, dea.date
, dea.population
, vac.NEW_VACCINATIONS
,SUM(CONVERT(DECIMAL(10,0),vac.new_vaccinations )) OVER (PARTITION BY dea.Location order by dea.location) as Rolling_Population_Vaccinated
--,(ROLLING_NEW_VACCINATION)/population*100 AS 
FROM [dbo].['Covid-Vaccination] dea
JOIN [dbo].['Covid-Vaccination] vac
on dea.location = vac.location
AND DEA.[date] = VAC.[date]
WHERE 1=1
AND dea.continent IS NOT NULL
--and dea.date = '01-01-2021'
--ORDER BY 2,3
)
SELECT  *, MAX(Rolling_Population_Vaccinated)/population*100 AS  VaccByPopulation
 FROM PopulationVSVaccinationMAX
 GROUP BY
continent
,location
--, dea.date
, population
, NEW_VACCINATIONS
,Rolling_Population_Vaccinated;



-- DO THE SAME USING TEMP TABLE.

DROP TABLE IF EXISTS #PercentPopulationVaccinated

CREATE TABLE #PercentPopulationVaccinated
(
CONTINENT NVARCHAR (255)
,LOCATION  NVARCHAR (255)
,DATE DATETIME
,POPULATION FLOAT  NULL
,NEW_VACCINATIONS NVARCHAR (255)
,Rolling_Population_Vaccinated NUMERIC
)

INSERT INTO #PercentPopulationVaccinated
SELECT  
dea.continent
,dea.location
, dea.date
, dea.population
, vac.NEW_VACCINATIONS
,SUM(CONVERT(DECIMAL(10,0),vac.new_vaccinations )) OVER (PARTITION BY dea.Location order by dea.location) as Rolling_Population_Vaccinated
--,(ROLLING_NEW_VACCINATION)/population*100 AS 
FROM [dbo].['Covid-Vaccination] dea
JOIN [dbo].['Covid-Vaccination] vac
on dea.location = vac.location
AND DEA.[date] = VAC.[date]
WHERE 1=1
AND dea.continent IS NOT NULL
--and dea.date = '01-01-2021'
--ORDER BY 2,3
;


SELECT  
continent
,location
--, date
, population
, NEW_VACCINATIONS
,MAX(Rolling_Population_Vaccinated)/population*100 AS  VaccByPopulation
 FROM #PercentPopulationVaccinated
 WHERE 1=1
 AND  date = '01-01-2021'
  GROUP BY
continent
,location
--, dea.date
, population
, NEW_VACCINATIONS
,Rolling_Population_Vaccinated;



-- CREATE VIEWS 

CREATE VIEW Rolling_Population_Vaccinated AS

(
    SELECT  
dea.continent
,dea.location
, dea.date
, dea.population
, vac.NEW_VACCINATIONS
,SUM(CONVERT(DECIMAL(10,0),vac.new_vaccinations )) OVER (PARTITION BY dea.Location order by dea.location) as Rolling_Population_Vaccinated
--,(ROLLING_NEW_VACCINATION)/population*100 AS 
FROM [dbo].['Covid-Vaccination] dea
JOIN [dbo].['Covid-Vaccination] vac
on dea.location = vac.location
AND DEA.[date] = VAC.[date]
WHERE 1=1
AND dea.continent IS NOT NULL
)
--and dea.date = '01-01-2021'
--ORDER BY 2,3

SELECT TOP (1000) [continent]
      ,[location]
      --,[date]
      ,[population]
      ,[NEW_VACCINATIONS]
      ,[Rolling_Population_Vaccinated]
      ,MAX(Rolling_Population_Vaccinated)/population*100 AS  VaccByPopulation
  FROM [CovidProject].[dbo].[Rolling_Population_Vaccinated]
  WHERE 1=1
  AND CONTINENT IS NOT NULL
  AND DATE = '01-15-2024'
  GROUP BY 
  [continent]
      ,[location]
      --,[date]
      ,[population]
      ,[NEW_VACCINATIONS]
      ,[Rolling_Population_Vaccinated]
  ORDER BY 1,2