SELECT count(ID) FROM world.city;

SELECT count(distinct population) FROM world.city;

SELECT count(name) FROM world.city;

SELECT count(code) FROM world.country;

SELECT count(IndepYear) FROM world.country;

SELECT * FROM world.country
where IndepYear is not null;

select count(*) as '' from world.city;

select ID as CityCode, Name as CityName
from world.city;

SELECT continent, region, count(*)
FROM world.country
GROUP BY continent, region
order by continent;

SELECT continent, count(*) numpaises
FROM world.country
GROUP BY continent
order by continent desc;

SELECT region, count(*) numpaises
FROM world.country
GROUP BY region
order by region desc;

select min(population) from world.city;

select * from world.city
order by population asc;
