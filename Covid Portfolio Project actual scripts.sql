
Select * 
From PortfolioProject..CovidData
where continent is not null
order by 1,2

--Select * 
--From PortfolioProject..CovidVaccines
--order by 3,4

--Select data we are going to be using 
Select Location, date, population, total_cases, (CAST(total_cases AS float)/population)*100 AS CasesPercentage
from PortfolioProject..CovidData
where location like '%states%'
order by 1,2

--Looking at countries with highest infection arte compared to poipulation
Select Location, Population, MAX(CAST(total_cases as Float))as HighestInfectionCount, MAX(CAST(total_cases AS Float)/Population)*100 as HighestInfectionPercentage
from PortfolioProject..CovidData
where continent is not null
Group by Location, population
order by HighestInfectionPercentage desc

--Showing countries with highest death count per population
Select Location, Population, MAX(CAST(total_deaths as Float))as HighestDeathCount, MAX(CAST(total_deaths AS Float)/Population)*100 as HighestDeathPercentage
from PortfolioProject..CovidData
where continent is not null
Group by Location, population
order by HighestDeathCount desc

SELECT continent, MAX(CAST(total_deaths as Float)) as TotalDeathCount
From PortfolioProject..CovidData
Where continent is not null
Group by continent
order by TotalDeathCount desc

Select date, SUM(CAST(new_cases as int))
From PortfolioProject..CovidData
where continent is not null
Group by date
order by 1,2

Select date, SUM(CAST(new_cases as int)) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths,
SUM(CAST(new_cases as int))/SUM(CAST(new_deaths as int))*100 as deathPercentage
From PortfolioProject..CovidData
where continent is not null
Group by date
order by 1,2

Select * 
From PortfolioProject..CovidData dea
Join PortfolioProject..CovidVaccines vac
    On dea.location = vac.location 
	and dea.date = vac.date

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidData dea
Join PortfolioProject..CovidVaccines vac
    On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
order by 1,2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidData dea
Join PortfolioProject..CovidVaccines vac
    On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100 as PercentageOfRollingPeopleVaccinated
From PortfolioProject..CovidData dea
Join PortfolioProject..CovidVaccines vac
    On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

--Use CTE
With PopvsVac (Continent, Location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100 as PercentageOfRollingPeopleVaccinated
From PortfolioProject..CovidData dea
Join PortfolioProject..CovidVaccines vac
    On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select * ,(RollingPeopleVaccinated/population)*100 as Percentage--same results as before but can use the CTE to do future calculations
From PopvsVac

--TEMP Table
DROP TABLE if exists  #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent varchar(255),
Location varchar(255),
Date datetime, 
Population numeric,
New_Vaccinations varchar(255),
RollingPeopleVaccinated numeric
)

INSERT INTO  #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100 as PercentageOfRollingPeopleVaccinated
From PortfolioProject..CovidData dea
Join PortfolioProject..CovidVaccines vac
    On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

--Let's break things down by continent
--Showing continents with the highest death count per population
SELECT continent, MAX(CAST(total_deaths as Float)) as TotalDeathCount
From PortfolioProject..CovidData
Where continent is not null
Group by continent
order by TotalDeathCount desc

--Create view to store data for later visualizations

CREATE View PPercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100 as PercentageOfRollingPeopleVaccinated
From PortfolioProject..CovidData dea
Join PortfolioProject..CovidVaccines vac
    On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3