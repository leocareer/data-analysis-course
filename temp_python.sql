select count(c.medal_id) medals, d.age
from olympics.competitor_event c
inner join olympics.games_competitor d
on c.competitor_id = d.id
where c.medal_id in (1, 2, 3)
group by d.age;

select world.country.SurfaceArea area, world.country.population 
from world.country;