-- 1) Mostra la quantitat de ciutats que hi ha a la taula city.
-- 1) Показать количество городов в таблице городов.

SELECT count(distinct name) FROM world.city; -- но могут быть города с одинаковыми названиями, в идеале провериветь по другим полям

select count(name) num_registros
from world.city;

select count(distinct id) num_registros
from world.city;

-- 2) Mostra la quantitat de ciutats que té cada "countryCode" de la taula city.
-- 2) Покажите количество городов, которые имеет каждый «countryCode» в таблице городов.

SELECT countrycode, count(distinct name)
FROM world.city
GROUP BY countrycode
order by countrycode;

SELECT countrycode, count(id)
FROM world.city
GROUP BY countrycode
order by countrycode;

-- 3) Mostra la "population" màxima de cada "countryCode" de la taula city.
-- 3) Покажите максимальное «население» каждого «кода страны» в таблице городов.

SELECT countrycode, max(population) 'test'
FROM world.city
GROUP BY countrycode
order by countrycode;

SELECT countrycode, max(population)
FROM world.city
GROUP BY countrycode
order by countrycode;

-- 4) Mostra la "lifeExpentacy" mitja de cada continent i regió de la taula country.
-- 4) Покажите среднюю «продолжительность жизни» каждого континента и региона в таблице стран.

SELECT continent, region, avg(LifeExpectancy)
FROM world.country
GROUP BY continent, region
order by continent, region;

-- 5) Mostra la "population" total de cada continent.
-- 5) Покажите общую численность населения каждого континента.

select continent, sum(population)
FROM world.country
group by continent
order by continent;

-- 6) Mostra la "surfaceArea" més petita de cada regió de cada continent.
-- 6) Покажите наименьшую «площадь поверхности» каждого региона на каждом континенте.

SELECT continent, region, min(SurfaceArea)
FROM world.country
GROUP BY continent, region
order by continent, region;

-- 7) Mostra quants països té cada continent.
-- 7) Покажите, сколько стран на каждом континенте.

select continent, count(distinct name)
FROM world.country
group by continent
order by continent;

-- 8) Mostra els continents que tenen més de 50 països.
-- 8) Покажите континенты, на которых расположено более 50 стран.

select continent, count(distinct name)
FROM world.country
group by continent
having count(distinct name) > 50
order by continent;

select continent, count(name)
FROM world.country
group by continent
having count(name) > 50
order by continent;

-- 9) Mostra la quantitat de països per "language" i per "IsOfficial". És a dir, quants països parlen una llengua en funció de si és oficial o no.
-- 9) Показать количество стран по "языку" и по "Официально". То есть сколько стран говорят на том или ином языке в зависимости от того, является он официальным или нет.

select Language, IsOfficial, count(distinct CountryCode)
from world.countrylanguage
group by Language, IsOfficial
order by Language, IsOfficial;

select Language, IsOfficial, count(*)
from world.countrylanguage
group by Language, IsOfficial
order by Language, IsOfficial;

select Language, IsOfficial, count(Language)
from world.countrylanguage
group by Language, IsOfficial
order by Language, IsOfficial;

-- 10) Mostra el nom del país més gran de cada continent **(aquesta no s'ha explicat). Si no ho saps fer, aproximat el que més puguis a la resposta amb les eines que tens.
-- 10) Покажите название самой большой страны на каждом континенте** (это не поясняется). Если вы не знаете, как это сделать, постарайтесь максимально приблизить ответ с помощью имеющихся у вас инструментов.

SELECT continent, max(SurfaceArea)
FROM world.country
GROUP BY continent;

SELECT continent, name, SurfaceArea
FROM world.country 
WHERE (continent, SurfaceArea) IN (
	 SELECT continent, MAX(SurfaceArea) 
     FROM world.country  
     GROUP BY continent
);

SELECT continent, name, SurfaceArea
FROM world.country AS a
WHERE SurfaceArea = (
    SELECT MAX(SurfaceArea)
    FROM world.country AS b
    WHERE a.continent = b.continent
);

SELECT continent, name, SurfaceArea
FROM world.country 
WHERE SurfaceArea IN (
	 SELECT MAX(SurfaceArea) 
     FROM world.country  
     GROUP BY continent
);