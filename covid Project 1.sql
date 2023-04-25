Select *
from [PortfolioProject][dbo][CovidDeath]
order by 3,4
--Select *
--from CovidVac
--order by 3,4

--Select the data I will be using

Select location, date, total_cases, new_cases, total_deaths, population
from CovidDeath
order by 1,2

--Looking at the death ratio - number of cases vs number of death (total_deaths/total_cases)*100

SELECT location, date, total_cases, total_deaths, CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT)*100 AS death_rate
FROM CovidDeath
ORDER BY 1, 2

--I had to use the case as I unfortunately loaded the data as varchar and can't seem to be be able to change the data type

ALTER TABLE CovidDeath
ALTER COLUMN total_deaths FLOAT,
ALTER COLUMN total_cases FLOAT;

SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 AS death_rate
FROM [dbo].[CovidDeath]
ORDER BY 1,2

SELECT 
    d.continent, 
    d.location, 
    d.date, 
    d.population, 
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS BIGINT)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS RollingVaccinated
FROM [PortfolioProject].[dbo].[CovidDeath] d
JOIN [PortfolioProject].[dbo].[CovidVac] v
ON d.location = v.location 
AND d.date = v.date
WHERE d.continent is not null;


select *
from [dbo].[percentPopulationVaccinated]