
-- Total Population vs DEATHS

Select *
From Project..COVIDDEATHS
Where continent is not null
order by 3,4

--Select *
--From Project..COVIDVACCINATIONS
--order by 3

SElect Location, date, total_cases, new_cases, total_deaths, population
From Project..COVIDDEATHS
Where continent is not null
order by 1,2


--Looking at the total cases vs Total Deaths

SElect Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From Project..COVIDDEATHS
where location like '%india%'
and Where continent is not null
order by 1,2


--looking at total cases Vs Population
--show what population got covid

SElect Location, date, total_cases, Population, (total_cases/population)*100 as Death_Percentage
From Project..COVIDDEATHS
where location like '%india%'
and Where continent is not null
order by 1,2




--looking at countries with highest infection rate compared to population


Select Location, population, Max(total_cases) as Highest_Infection_Count, Max(total_cases/population)*100 as Percent_Population_Infected
From Project..COVIDDEATHS
--where location like '%india%'
Where continent is not null
group by location, population
order by Percent_Population_Infected desc

--showing countries with highest death count per population

Select Location, MAX(cast(Total_deaths as int)) as Total_Death_Count
From Project..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by Location
order by Total_Death_Count desc


-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as Total_Death_Count
From Project..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by continent
order by Total_Death_Count desc


-- GLOBAL NUMBERS

Select date,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as Death_Percentage
From Project..CovidDeaths
--Where location like '%states%'
where continent is not null 
Group By date
order by 1,2



-- Total Population vs Vaccinations

Select*
From Project..COVIDDEATHS dea
Join Project..COVIDVACCINATIONS vac
   on dea.location = vac.location
   and dea.date = vac.date


-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as Rolling_People_Vaccinated
--, (RollingPeopleVaccinated/population)*100
From Project..CovidDeaths dea
Join Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3










