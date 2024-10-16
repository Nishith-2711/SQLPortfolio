CREATE TABLE covidvaccinations (
    iso_code TEXT,
    continent TEXT,
    location TEXT,
    date TEXT,
    new_tests TEXT,
    total_tests TEXT,
    total_tests_per_thousand TEXT,
    new_tests_per_thousand TEXT,
    new_tests_smoothed TEXT,
    new_tests_smoothed_per_thousand TEXT,
    positive_rate TEXT,
    tests_per_case TEXT,
    tests_units TEXT,
    total_vaccinations TEXT,
    people_vaccinated TEXT,
    people_fully_vaccinated TEXT,
    new_vaccinations TEXT,
    new_vaccinations_smoothed TEXT,
    total_vaccinations_per_hundred TEXT,
    people_vaccinated_per_hundred TEXT,
    people_fully_vaccinated_per_hundred TEXT,
    new_vaccinations_smoothed_per_million TEXT,
    stringency_index TEXT,
    population_density TEXT,
    median_age TEXT,
    aged_65_older TEXT,
    aged_70_older TEXT,
    gdp_per_capita TEXT,
    extreme_poverty TEXT,
    cardiovasc_death_rate TEXT,
    diabetes_prevalence TEXT,
    female_smokers TEXT,
    male_smokers TEXT,
    handwashing_facilities TEXT,
    hospital_beds_per_thousand TEXT,
    life_expectancy TEXT,
    human_development_index TEXT
);

select * from covidvaccinations;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVaccinations.csv'
INTO TABLE covidvaccinations
FIELDS TERMINATED BY ','        
LINES TERMINATED BY '\n'        
IGNORE 1 LINES;

-- CREATE TABLE coviddeaths (
--     iso_code TEXT,
--     continent TEXT,
--     location TEXT,
--     date TEXT,
--     total_cases TEXT,
--     new_cases TEXT,
--     new_cases_smoothed TEXT,
--     total_deaths TEXT,
--     new_deaths TEXT,
--     new_deaths_smoothed TEXT,
--     total_cases_per_million TEXT,
--     new_cases_per_million TEXT,
--     new_cases_smoothed_per_million TEXT,
--     total_deaths_per_million TEXT,
--     new_deaths_per_million TEXT,
--     new_deaths_smoothed_per_million TEXT,
--     reproduction_rate TEXT,
--     icu_patients TEXT,
--     icu_patients_per_million TEXT,
--     hosp_patients TEXT,
--     hosp_patients_per_million TEXT,
--     weekly_icu_admissions TEXT,
--     weekly_icu_admissions_per_million TEXT,
--     weekly_hosp_admissions TEXT,
--     weekly_hosp_admissions_per_million TEXT,
--     new_tests TEXT,
--     total_tests TEXT,
--     total_tests_per_thousand TEXT,
--     new_tests_per_thousand TEXT,
--     new_tests_smoothed TEXT,
--     new_tests_smoothed_per_thousand TEXT,
--     positive_rate TEXT,
--     tests_per_case TEXT,
--     tests_units TEXT,
--     total_vaccinations TEXT,
--     people_vaccinated TEXT,
--     people_fully_vaccinated TEXT,
--     new_vaccinations TEXT,
--     new_vaccinations_smoothed TEXT,
--     total_vaccinations_per_hundred TEXT,
--     people_vaccinated_per_hundred TEXT,
--     people_fully_vaccinated_per_hundred TEXT,
--     new_vaccinations_smoothed_per_million TEXT,
--     stringency_index TEXT,
--     population TEXT,
--     population_density TEXT,
--     median_age TEXT,
--     aged_65_older TEXT,
--     aged_70_older TEXT,
--     gdp_per_capita TEXT,
--     extreme_poverty TEXT,
--     cardiovasc_death_rate TEXT,
--     diabetes_prevalence TEXT,
--     female_smokers TEXT,
--     male_smokers TEXT,
--     handwashing_facilities TEXT,
--     hospital_beds_per_thousand TEXT,
--     life_expectancy TEXT,
--     human_development_index TEXT
-- );


CREATE TABLE coviddeaths (
    iso_code TEXT,
    continent TEXT,
    location TEXT,
    date TEXT,
    total_cases FLOAT UNSIGNED NULL,
    new_cases FLOAT SIGNED NULL,
    new_cases_smoothed TEXT,
    total_deaths FLOAT UNSIGNED NULL,
    new_deaths TEXT,
    new_deaths_smoothed TEXT,
    total_cases_per_million TEXT,
    new_cases_per_million TEXT,
    new_cases_smoothed_per_million TEXT,
    total_deaths_per_million TEXT,
    new_deaths_per_million TEXT,
    new_deaths_smoothed_per_million TEXT,
    reproduction_rate TEXT,
    icu_patients TEXT,
    icu_patients_per_million TEXT,
    hosp_patients TEXT,
    hosp_patients_per_million TEXT,
    weekly_icu_admissions TEXT,
    weekly_icu_admissions_per_million TEXT,
    weekly_hosp_admissions TEXT,
    weekly_hosp_admissions_per_million TEXT,
    new_tests TEXT,
    total_tests TEXT,
    total_tests_per_thousand TEXT,
    new_tests_per_thousand TEXT,
    new_tests_smoothed TEXT,
    new_tests_smoothed_per_thousand TEXT,
    positive_rate TEXT,
    tests_per_case TEXT,
    tests_units TEXT,
    total_vaccinations TEXT,
    people_vaccinated TEXT,
    people_fully_vaccinated TEXT,
    new_vaccinations TEXT,
    new_vaccinations_smoothed TEXT,
    total_vaccinations_per_hundred TEXT,
    people_vaccinated_per_hundred TEXT,
    people_fully_vaccinated_per_hundred TEXT,
    new_vaccinations_smoothed_per_million TEXT,
    stringency_index TEXT,
    population FLOAT UNSIGNED NULL,
    population_density TEXT,
    median_age TEXT,
    aged_65_older TEXT,
    aged_70_older TEXT,
    gdp_per_capita TEXT,
    extreme_poverty TEXT,
    cardiovasc_death_rate TEXT,
    diabetes_prevalence TEXT,
    female_smokers TEXT,
    male_smokers TEXT,
    handwashing_facilities TEXT,
    hospital_beds_per_thousand TEXT,
    life_expectancy TEXT,
    human_development_index TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidDeaths.csv'
INTO TABLE coviddeaths
FIELDS TERMINATED BY ','        
LINES TERMINATED BY '\n'        
IGNORE 1 LINES;

---------------------------------------------------------------------------------------------------------------

select * from coviddeaths
where continent is not null
order by 3,4;

-- select * from covidvaccinations
-- order by 3,4;


-- selecting important data
select location, date, total_cases, new_cases, total_deaths, population from coviddeaths
where continent is not null
order by 1,2;

-- total percent of death per case
select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercent 
from coviddeaths
where location like "%states%"
and continent is not null
order by 1,2;


-- total cases vs population
select location, date, population, total_cases,  (total_cases/population) * 100 as InfectedPercent 
from coviddeaths
where location like "%states%"
order by 1,2;

-- countries with highest infection rate vs population
select location, population, Max(total_cases) as Highest_infection, max((total_cases/population)) * 100 as Percent_infected 
from coviddeaths
group by location, population
order by Percent_infected desc;

-- highest death per population
select location, Max(total_deaths) as Total_death
from coviddeaths
where continent is not null and continent != ''
group by location
order by Total_death desc;


-- based on continent

-- highest death count per continent 
select continent, Max(total_deaths) as Total_death
from coviddeaths
where continent != ''
group by continent
order by Total_death desc;

-- global numbers
select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases) * 100 as death_percent
from coviddeaths
where continent !=''
group by date
order by 1,2;


-- Join both the tables based on location and date
with pop_vs_vac (continent, location, date, population, new_vaccinations, sum_of_vaccines) as
(
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location, cd.date) as additive_sum_of_vaccines
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location and cd.date = cv.date
where cd.continent != ''
-- order by 2,3;
)
Select *, (sum_of_vaccines/population) * 100 as percent_vaccines
from pop_vs_vac;


-- create temp table

drop table if exists population_vaccinated;
create table population_vaccinated
(
continent TEXT,
location TEXT,
date date,
population numeric,
new_vaccinations TEXT,
people_vaccinated numeric
);

insert into population_vaccinated
(
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location, cd.date) as additive_sum_of_vaccines
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location and cd.date = cv.date
where cd.continent != ''
-- order by 2,3;
);
select *, (people_vaccinated/population) * 100 as percent_vaccines
from population_vaccinated;


-- Create View

create view population_vaccinated_view as
(
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location, cd.date) as additive_sum_of_vaccines
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location and cd.date = cv.date
where cd.continent != ''
-- order by 2,3;
);

select * from population_vaccinated_view;
