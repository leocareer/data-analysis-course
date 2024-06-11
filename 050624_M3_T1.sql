-- 1) Показать все данные из таблицы городов.
-- 1) Mostra totes les dades de la taula city.

select * from world.city;

-- 2) Показать «имя», «континент» и «регион» таблицы стран.
-- 2) Mostra el "name", "continent" i "region" de la taula country.

select name, continent, region from world.country;

-- 3) Показать названия стран и их «население» в порядке их «Продолжительность жизни» от самого высокого к самому низкому.
-- 3) Mostra els noms dels països i la seva "population" ordenats per la seva "LifeExpectancy" de major a menor.

select name, LifeExpectancy from world.country order by LifeExpectancy desc;

-- 4) Показать 10 лучших стран из предыдущего запроса.
-- 4) Mostra el top10 dels paisos de la consulta anterior.

select name, LifeExpectancy from world.country order by LifeExpectancy desc limit 10;

-- 5) Покажите, какие «правительственные формы» являются уникальными в таблице стран.
-- 5) Mostra quines són les "GovernmentForm" úniques que hi ha a la taula country.

select distinct GovernmentForm from world.country;

-- 6) Показать все языки, на которых говорят в мире.
-- 6) Mostra tots els llenguatges que es parlen al món.

select distinct language from world.countrylanguage;
