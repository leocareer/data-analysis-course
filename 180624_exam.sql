-- 1. Dibuixa un esquema de les taules i les seves relacions (1,5p)
-- 1. Нарисуйте схему таблиц и их взаимосвязей (1,5п)

-- attach exam_db_model.pdf

-- 2. Escriu les consultes que responguin a les següents preguntes:
-- 2. Напишите запросы, которые отвечают на следующие вопросы:
-- 2.1. Mostra la quantitat d'esdeveniments que té cada esport (0,5p)
-- 2.1. Покажите, сколько событий проводится в каждом виде спорта (0,5p)

select olympics.sport.sport_name 'kind of sport', count(olympics.event.sport_id) 'how many events'
from olympics.sport
inner join olympics.event
on olympics.sport.id = olympics.event.sport_id
group by olympics.event.sport_id
order by olympics.sport.sport_name;

/* 2.2. Mostra el nom de la ciutat i la quantitat de joc olímpics que han 
organitzat, de les ciutats que han organitzat més d'un joc olímpic (1p)
   2.2. Укажите название города и количество проведенных в нем Олимпийских 
игр для городов, в которых проводилось более одной Олимпийской игры (1p)*/

select olympics.city.city_name 'city', count(olympics.games_city.city_id) 'how many games'
from olympics.city
inner join olympics.games_city
on olympics.city.id = olympics.games_city.city_id
group by olympics.games_city.city_id
having count(olympics.games_city.city_id) > 1
order by olympics.city.city_name;

/* 2.3. Mostra el nom de totes les esportistes (gènere femení)
espanyoles que van participar en els jocs de Barcelona 92 i que es
diuen Cristina (pots fer la consulta tenint en compte que l'id dels jocs
de Barcelona 92 és l'1) (1p)
   2.3. Показывает имена всех испанских спортсменов (женского пола), 
участвовавших в 92 играх «Барселоны» и которые называются Кристина (запрос 
можно сделать с учетом того, что id игр Барселоны 92 равен 1) (1p)*/

select olympics.person.full_name "'Cristina' female athletes BCN'92"
from olympics.person
inner join olympics.games_competitor
on olympics.person.id = olympics.games_competitor.person_id
where olympics.games_competitor.games_id = 1
and olympics.person.gender = 'F'
and olympics.person.full_name like '%Cristina%';

-- trabajar en los errores

select a.full_name "'Cristina' female athletes BCN'92"
from olympics.person a
where a.gender = 'F'
and a.full_name like '%Cristina%'
and a.id in (
	select b.person_id
    from olympics.games_competitor b
    where b.games_id = 1
)
and a.id in (
	select c.person_id
    from olympics.person_region c
    where c.region_id in (
		select d.id
        from olympics.noc_region d
        where d.region_name = 'Spain'
    )
);

/* 2.4. Mostra el nom de la persona esportista que va guanyar més
medalles a Rio de Janeiro (és preferible que no, però pots utilitzar el
fet que els jocs de Rio tenen l'id 21) (1,5p)
   2.4. Покажите имя спортсмена, выигравшего больше всего медали в 
Рио-де-Жанейро (желательно нет, но можно воспользоваться тем, что игры 
в Рио имеют id 21) (1,5р)*/

select olympics.person.full_name, count(olympics.competitor_event.medal_id) medals
from olympics.competitor_event
inner join olympics.games_competitor
on olympics.competitor_event.competitor_id = olympics.games_competitor.id
inner join olympics.person
on olympics.games_competitor.person_id = olympics.person.id
where olympics.competitor_event.medal_id in (1, 2, 3)
group by olympics.competitor_event.competitor_id
having olympics.competitor_event.competitor_id in (
	select olympics.games_competitor.id from olympics.games_competitor
	where games_id = (
		select olympics.games_city.games_id
        from olympics.games_city
        inner join olympics.city
        on olympics.games_city.city_id = olympics.city.id
        where olympics.city.city_name = 'Rio de Janeiro'
    )
)
order by medals desc
limit 1;

-- trabajar en los errores

-- 1) primera opción

select olympics.person.full_name, count(olympics.competitor_event.medal_id) medals
from olympics.competitor_event
inner join olympics.games_competitor on olympics.competitor_event.competitor_id = olympics.games_competitor.id
inner join olympics.person on olympics.games_competitor.person_id = olympics.person.id
where olympics.competitor_event.medal_id in (1, 2, 3)
and olympics.games_competitor.games_id = (
	select a.games_id
    from olympics.games_competitor a
    inner join olympics.games_city on a.games_id = olympics.games_city.games_id
	inner join olympics.city on olympics.games_city.city_id = olympics.city.id
	where olympics.city.city_name = 'Rio de Janeiro'
    group by a.games_id
)
group by olympics.person.full_name
order by medals desc
limit 1;

-- 2) segunda opción

select olympics.person.full_name, count(olympics.competitor_event.medal_id) medals
from olympics.competitor_event
inner join olympics.games_competitor on olympics.competitor_event.competitor_id = olympics.games_competitor.id
and olympics.games_competitor.games_id = (
	select a.games_id
    from olympics.games_competitor a
    inner join olympics.games_city on a.games_id = olympics.games_city.games_id
	inner join olympics.city on olympics.games_city.city_id = olympics.city.id
	where olympics.city.city_name = 'Rio de Janeiro'
    group by a.games_id
)
inner join olympics.person on olympics.games_competitor.person_id = olympics.person.id
where olympics.competitor_event.medal_id in (1, 2, 3)
group by olympics.person.full_name
order by medals desc
limit 1;

-- 3) tercera opción

select olympics.person.full_name, count(olympics.competitor_event.medal_id) medals
from olympics.competitor_event
inner join olympics.games_competitor on olympics.competitor_event.competitor_id = olympics.games_competitor.id
inner join olympics.person on olympics.games_competitor.person_id = olympics.person.id
inner join (
	select a.games_id
    from olympics.games_competitor a
    inner join olympics.games_city on a.games_id = olympics.games_city.games_id
	inner join olympics.city on olympics.games_city.city_id = olympics.city.id
	where olympics.city.city_name = 'Rio de Janeiro'
    group by a.games_id
) as b on olympics.games_competitor.games_id = b.games_id
where olympics.competitor_event.medal_id in (1, 2, 3)
and b.games_id is not null
group by olympics.person.full_name
order by medals desc
limit 1;

/* 2.5. Qui va guanyar més medalles d'or en atletisme masculí en els
jocs de Barcelona 92, Espanya o USA? (És preferible que no, però pots
utilitzar el fet que els jocs de Barcelona tenen l'id 1 i l'atletisme com a
esport té l'id 6) (1,5p)
   2.5. Кто выиграл больше золотых медалей в мужской лёгкой атлетике на 
играх «Барселона-92», Испания или США? (Предпочтительно нет, но вы можете 
использовать тот факт, что игры в Барселоне имеют идентификатор 1, а легкая 
атлетика как вид спорта имеет идентификатор 6) (1.5p)*/

select region_name, count(person_id) a
from (
	select b.region_name, c.person_id
	from olympics.noc_region b
	inner join olympics.person_region c
	on b.id = c.region_id
	where b.region_name in ('Spain','USA')
	and c.person_id in (
		select d.person_id
		from olympics.games_competitor d
		inner join olympics.competitor_event e
		on e.competitor_id = d.id
		where e.medal_id = 1
        and d.games_id = (
			select olympics.city.id
			from olympics.city
			where olympics.city.city_name = 'Barcelona'
            )
		and e.event_id in (
			select olympics.event.id
			from olympics.event
			where olympics.event.event_name like 'Athletics Men%'
			)
	)
) as sub
group by region_name
order by a desc
limit 1;

-- trabajar en los errores

select a.region_name, count(f.medal_id) b
from olympics.noc_region a
inner join olympics.person_region c on a.id = c.region_id
inner join olympics.person d on c.person_id = d.id
inner join olympics.games_competitor e on d.id = e.person_id 
and e.games_id = (
			select olympics.city.id
			from olympics.city
			where olympics.city.city_name = 'Barcelona'
            )
inner join olympics.competitor_event f on e.id = f.competitor_id and f.medal_id = 1
and f.event_id in (
			select olympics.event.id
			from olympics.event
			where olympics.event.event_name like 'Athletics Men%'
			)
group by a.region_name
order by b desc
limit 1;

/* 2.6 Mostra el nom de la persona esportista que té el major pes
d’entre tots i totes. No ports utilitzar ni ORDER BY ni LIMIT, és a dir la
consulta a de ser dinàmica i si haguessin dues o més persones amb
el pes màxim, hauries de mostrar-les totes. (1p)
   2.6 Указать имя спортсмена, у которого самый тяжелый вес из всех. 
Нельзя использовать ни ORDER BY, ни LIMIT, то есть запрос должен быть 
динамическим и если с максимальным весом было два и более человека, нужно 
показать их всех. (1р)*/

select olympics.person.full_name
from olympics.person
where olympics.person.weight = (
    select max(weight)
    from olympics.person
);

/* 2.7. Mostra els noms dels països que compleixin la següent situació:
l’alçada mínima de qualsevol dels seus esportistes masculins és
major a l’alçada mitja de tots els esportistes masculins. No has
d’incloure en aquests càlculs tots aquells esportistes dels quals no
tenim la seva alçada. (2p)
   2.7. Перечислите названия стран, которые удовлетворяют следующему 
условию: минимальный рост любого из ее спортсменов-мужчин превышает 
средний рост всех спортсменов-мужчин. Не обязательно включать в эти 
расчеты всех тех спортсменов, чей рост у нас отсутствует. (2р)*/

select distinct n.region_name, min(s.height) -- distinct no necesitas usar
from olympics.person_region p
inner join olympics.noc_region n on p.region_id = n.id
inner join olympics.person s on p.region_id = s.id
where s.gender = 'M'
and s.height > 0
group by p.region_id -- нужно ВСЕГДА группировать по тому полю что есть в селекте, здесь просто по сулчайности работает с _name и _id 
having min(s.height) > (
	select avg(olympics.person.height)
	from olympics.person
	where olympics.person.gender = 'M'
	and olympics.person.height > 0
    );
    
-- trabajar en los errores

select a.region_name, min(c.height) d
from olympics.noc_region a
inner join olympics.person_region b on a.id = b.region_id
inner join olympics.person c on b.person_id = c.id
where c.gender = 'M'
and c.height > 0
group by a.region_name
having d > (
	select avg(e.height)
	from olympics.person e
	where e.gender = 'M'
	and e.height > 0
    );
    
    
