-- 1) Mostra el nom del país més gran de cada continent.
-- 1) Покажите название самой большой страны на каждом континенте.

-- filter

select max(world.country.SurfaceArea)
    from world.country
    group by world.country.continent;

select world.country.continent, world.country.name 'the biggest country', world.country.SurfaceArea
from world.country
where world.country.SurfaceArea in (
	select max(world.country.SurfaceArea)
    from world.country
    group by world.country.continent
);

-- from

select world.country.continent, max(world.country.surfacearea) as ms from world.country group by 1;

select world.country.name, aux.continent, aux.ms
from  (select world.country.continent, max(world.country.surfacearea) as ms from world.country group by 1) as aux
join world.country
on aux.continent = world.country.continent
where world.country.surfacearea like aux.ms
group by 1,2,3;

-- correlacionada

select T1.name Paises from world.country T1
where T1.surfacearea = (
	select max(T2.surfacearea)
	from world.country T2
    where T1.continent = T2.continent
);

-- 2) Mostra el nom del pais i el nom de la ciutat que te menys habitants de cada país.
-- 2) Покажите название страны и название города с наименьшим количеством жителей в каждой стране.

select min(world.city.population)
from world.city
group by world.city.countrycode;

select world.country.name , world.city.name, world.city.population
from world.country
inner join world.city
on world.country.code = world.city.countrycode
where world.city.population in (
	select min(world.city.population)
    from world.city
    group by world.city.countrycode
);

-- filter

SELECT p.name AS 'Pais', c.name AS 'Ciudad', c.population AS 'Poblacion Minima'
FROM world.city c
JOIN world.country p on c.CountryCode = p.Code
WHERE (c.CountryCode, c.population) IN (
	SELECT CountryCode, min(Population)
	FROM city
		GROUP BY CountryCode
		ORDER BY CountryCode
)
ORDER BY c.CountryCode;
                              
-- 

/* select aux.co_n, city.Name as ci_n, aux.m_c_p                                    #falten 4 files, 235 resultats 
from (select country.code, country.Name as co_n, min(city.population) as m_c_p  #  continent Antarctica:  1 antartica, 2 French Southern territories, 3 Bouvet Island, 4 Heard Island and McDonald Islands, 6 South Georgia and the South Sandwich Islands 
      from country                                                               #  continent Africa: 5 British Indian Ocean Territory
		left join city                                                                  #  continent Oceania: 7 United States Minor Outlying Islands         
      on country.Code = city.CountryCode                                         #   les que no surten es perque tenen 0 population que son 7, nomes en queden 4 files de diferencia perque hi ha ciutats d'un mateix pais que tenen el mateix num d'habitans  
      group by 1,2 order by 2) as aux                                            #   co_n Ukraine amb 2 ciutats amb el mateix nombre d' habitans, Brovary i  Mukatševe
left join city                                                                        #   co_n Indonesia amb 2 ciutats amb el mateix nombre d' habitans, Banyuwangi i Tanjung Pinang
on  aux.Code = city.CountryCode                                                  #   co_n Somalia amb 2 ciutats amb el mateix nombre d' habitans Hargeysa i Kismaayo
where city.population like  aux.m_c_p 
group by 1,2,3 order by 1; */

-- 3) Mostra els països que estàn per sobre de la mitja de "lifeExpectancy" de cada continent
-- 3) Покажите страны, в которых средняя продолжительность жизни выше среднего для каждого континента.

/*select world.country.continent, avg(world.country.LifeExpectancy)
from world.country
group by world.country.continent;*/

/*select avg(world.country.LifeExpectancy)
from world.country;*/

select world.country.continent, world.country.name, world.country.LifeExpectancy
from world.country
where world.country.LifeExpectancy > (
	select avg(world.country.LifeExpectancy)
	from world.country)
order by world.country.continent;

/*select b.continent, b.name , b.LifeExpectancy
from world.country b
where b.LifeExpectancy > all (
	select avg(a.LifeExpectancy)
	from world.country a
	group by a.continent
);

select world.country.continent, world.country.name, world.country.LifeExpectancy
from world.country
where world.country.LifeExpectancy > some (
	select avg(world.country.LifeExpectancy)
	from world.country
	group by world.country.continent
)
order by world.country.continent;

select world.country.continent, world.country.name, world.country.LifeExpectancy
from world.country
inner join (
	select avg(world.country.LifeExpectancy) as a
	from world.country
	group by world.country.continent
) as b
on world.country.continent = world.country.continent
where world.country.LifeExpectancy > b.a
order by world.country.continent;*/

SELECT a.Continent, a.Name, a.LifeExpectancy, b.AVG_Continent
FROM Country AS a
INNER JOIN (SELECT Continent, AVG(LifeExpectancy) AS AVG_Continent FROM Country GROUP BY Continent) AS b
ON a.Continent=b.Continent
WHERE a.LifeExpectancy > b.AVG_Continent;

