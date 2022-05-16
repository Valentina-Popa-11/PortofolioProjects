-- Print first 5 rows of both datasets
-- CovidDeaths
SELECT TOP 5 *
FROM CovidDeaths
-- CovidVaccinations
SELECT TOP 5 *
FROM CovidVaccinations

-- Looking at the Likehood of dying over time in 2 countries
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortofolioProject..CovidDeaths
WHERE location LIKE '%Romania%' OR location LIKE '%United Kingdom%'
ORDER BY 5 DESC, 2 ASC

-- Create views for later visualisations
CREATE VIEW UKvsRomaniaCovidDeaths AS SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortofolioProject..CovidDeaths
WHERE location LIKE '%Romania%' OR location LIKE '%United Kingdom%'


-- Looking at Total Cases vs Population over time in 2 countries
SELECT location, date, total_cases, population, (total_cases/population)*100 AS InfectionPercentage
FROM PortofolioProject..CovidDeaths
WHERE location like '%Romania%' OR location LIKE '%United Kingdom%'
ORDER BY 2,1

-- Create views for later visualisations
CREATE VIEW UKvsRomaniaCovidCases AS SELECT location, date, total_cases, population, (total_cases/population)*100 AS InfectionPercentage
FROM PortofolioProject..CovidDeaths
WHERE location like '%Romania%' OR location LIKE '%United Kingdom%'

-- Looking at Europe Counties with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionRate, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortofolioProject..CovidDeaths
WHERE continent IS NOT NULL AND continent = 'Europe'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

-- Create views for later visualisations
CREATE VIEW EuropeInfectionRates AS SELECT location, population, MAX(total_cases) AS HighestInfectionRate, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortofolioProject..CovidDeaths
WHERE continent IS NOT NULL AND continent = 'Europe'
GROUP BY location, population

-- Showing Europe Counties with the highest deathcount per population
SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortofolioProject..CovidDeaths
WHERE continent IS NOT NULL AND continent = 'Europe'
GROUP BY location
ORDER BY TotalDeathCount DESC

-- Create views for later visualisations
CREATE VIEW EuropeDeathRates AS SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortofolioProject..CovidDeaths
WHERE continent IS NOT NULL AND continent = 'Europe'
GROUP BY location

-- Showing Covid global summary
SELECT continent, SUM(new_cases) AS reported_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS death_percentage
FROM PortofolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY death_percentage DESC

-- Create views for later visualisations
CREATE VIEW CovidContinentsSummary AS SELECT continent, SUM(new_cases) AS reported_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS death_percentage
FROM PortofolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent

-- Creating a temp table
DROP TABLE IF EXISTS #PercentEuropeanPopulationVaccinated
CREATE TABLE #PercentEuropeanPopulationVaccinated
(
Country NVARCHAR(255),
Date DATETIME,
Population NUMERIC,
New_vaccination NUMERIC,
Rolling_people_vaccinated NUMERIC
)
-- Looking at total population vs total vaccination in Europe
INSERT INTO #PercentEuropeanPopulationVaccinated
SELECT cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CAST(cv.new_vaccinations AS BIGINT)) --BIGINT is used as result of calculation is outside the range of int data type
	OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS RollingPeopleVaccinated
FROM PortofolioProject..CovidDeaths cd
JOIN PortofolioProject..CovidVaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent = 'Europe'

SELECT *, (Rolling_people_vaccinated/Population)*100 AS PercentVaccinated
FROM #PercentEuropeanPopulationVaccinated
ORDER BY PercentVaccinated DESC, Date ASC

-- Create views for later visualisations
CREATE VIEW PercentEuropeanPopulationVaccinated AS SELECT cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CAST(cv.new_vaccinations AS BIGINT)) --BIGINT is used as result of calculation is outside the range of int data type
	OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS RollingPeopleVaccinated
FROM PortofolioProject..CovidDeaths cd
JOIN PortofolioProject..CovidVaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent = 'Europe'

