-- 1) Mostra el nom del país i les ciutats que hi ha a Andorra i Belize.
-- 1) Показать название страны и городов, которые есть в Андорре и Белизе.

select world.country.name countries, world.city.name cities
from world.country
inner join world.city
on world.country.code = world.city.countrycode
where world.country.name in ('Andorra','Belize');

-- 2) Mostra el nom del país i la quantitat de llengües que es parlen en els dos mateixos països (de la consulta anterior).
-- 2) Показать название страны и количество языков, на которых говорят в тех же двух странах (из предыдущего запроса).

select world.country.name countries, count(world.countrylanguage.countrycode) languagies
from world.country
inner join world.countrylanguage
on world.country.code = world.countrylanguage.countrycode
where world.country.name in ('Andorra','Belize')
group by world.countrylanguage.countrycode;

-- 3) Mostra el nom del país i les llengües que es parlen a l'Antàrtica i a Xile.
-- 3) Показать название страны и языки, на которых говорят в Антарктиде и Чили.

select world.country.name countries, world.countrylanguage.language languagies
from world.country
inner join world.countrylanguage
on world.country.code = world.countrylanguage.countrycode
where world.country.name in ('Antarctica','Chile');

-- 4) Digues quants països tenen dades a la taula "country" però no tenen dades a la taula de "countryLanguage".
-- 4) Укажите, сколько стран имеют данные в таблице «country», но не имеют данных в таблице «countryLanguage».

select count(world.country.name) 'no language'
from world.country
where not exists (
	select world.countrylanguage.countrycode
    from world.countrylanguage
    where world.country.code = world.countrylanguage.countrycode
);

-- 5) Mostra el nom del país amb on es parlen més llengües.
-- 5) Покажите название страны, где говорят на большинстве языков. (12, подзапрос)

/* select world.countrylanguage.countrycode, count(*)
    from world.countrylanguage
    group by world.countrylanguage.countrycode; */

/* select world.country.name, world.countrylanguage.countrycode, count(world.countrylanguage.countrycode)
from world.country
inner join world.countrylanguage
on world.country.code = world.countrylanguage.countrycode
group by world.countrylanguage.countrycode
having count(world.countrylanguage.countrycode)>11; */

select world.country.name, world.countrylanguage.countrycode, count(world.countrylanguage.countrycode) as num_languages
from world.country
inner join world.countrylanguage
on world.country.code = world.countrylanguage.countrycode
group by world.countrylanguage.countrycode
having num_languages = (
    select max(num_languages1)
    from (
        select count(world.countrylanguage.countrycode) as num_languages1
        from world.country
        inner join world.countrylanguage
        on world.country.code = world.countrylanguage.countrycode
        group by world.countrylanguage.countrycode
	) as temp
);

-- 6) Mostra el nom del país amb més "population".
-- 6) Покажите название страны с наибольшим населением.

select world.country.name
from world.country
where world.country.population = (
	select max(world.country.population)
    from world.country
);

-- 7) Mostra la "population" del país "Guadeloupe" (però, en lloc d'agafar la dada de la taula country, suma les "population" de totes les seves ciutats).
-- 7) Покажите «население» страны «Гваделупа» (но вместо того, чтобы брать данные из таблицы стран, добавьте «население» всех ее городов).

select world.country.name, sum(world.city.population)
from world.country
inner join world.city
on world.country.code = world.city.countrycode
where world.country.name = 'Guadeloupe'
group by world.city.countrycode;

-- 8) Mostra en una mateixa taula, el nom del país, els noms de les seves ciutats, la seva "population" i els seus "language" (del país "Guadeloupe").
-- 8) Покажите в той же таблице название страны, названия ее городов, ее «население» и ее «язык» (из страны «Гваделупа»).

select world.country.name 'country name', sum(world.city.population) 'cities population', group_concat(world.city.name) 'cities names', world.country.population, world.countrylanguage.language
from world.country
inner join world.city
on world.country.code = world.city.countrycode
inner join world.countrylanguage
on world.city.countrycode = world.countrylanguage.countrycode
where world.country.name = 'Guadeloupe' and world.countrylanguage.isofficial=1
group by world.city.countrycode, world.countrylanguage.language;

-- 9) Suma la "population" de la consulta anterior (a mà) i compara-la amb la "population" de la consulta núm. 7. Són iguals? Què està passant?
-- 9) Добавьте «население» предыдущего запроса (вручную) и сравните его с «населением» запроса №. 7. Они одинаковые? Что происходит?

/*of course they are different because this is the sum of the population of cities and this is the population, these are different objects*/

select sum(world.city.population) 'cities population', world.country.population
from world.country
inner join world.city
on world.country.code = world.city.countrycode
where world.country.name = 'Guadeloupe'
group by world.city.countrycode;