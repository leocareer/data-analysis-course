-- 1) Mostra el nom del país més gran de cada continent.
-- 1) Покажите название самой большой страны на каждом континенте.

/*select max(world.country.SurfaceArea)
    from world.country
    group by world.country.continent;*/

select world.country.continent, world.country.name 'the biggest country', world.country.SurfaceArea
from world.country
where world.country.SurfaceArea in (
	select max(world.country.SurfaceArea)
    from world.country
    group by world.country.continent
);

-- 2) Mostra el nom del pais i el nom de la ciutat que te menys habitants de cada país.
-- 2) Покажите название страны и название города с наименьшим количеством жителей в каждой стране.

/*select min(world.city.population)
from world.city
group by world.city.countrycode;*/

select world.country.name , world.city.name, world.city.population
from world.country
inner join world.city
on world.country.code = world.city.countrycode
where world.city.population in (
	select min(world.city.population)
    from world.city
    group by world.city.countrycode
);

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



