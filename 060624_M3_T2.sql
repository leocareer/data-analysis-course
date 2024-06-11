-- 1) Mostra totes les dades de les ciutats que comencen per "al-", de la taula city.
-- 1) Показать все данные по городам, начинающимся на "ал-", из таблицы городов.

select * from world.city
where name like 'al-%'
order by name;

-- 2) De la consulta anterior, mostra els "countryCode" únics.
-- 2) Из приведенного выше запроса покажите уникальный «countryCode».

select distinct CountryCode from world.city
where name like 'al-%'
order by CountryCode;

-- 3) Mostra el "name" de les ciutats que tenen menys de 10.000 persones de "population".
-- 3) Показать «название» городов с населением менее 10 000 человек.

select name from world.city 
where population<10000
order by name;

select name, population from world.city -- можно так, но я проверяю в отдельной вкладке и показываю только то что надо в итоговом
where population<10000
order by population asc;

-- 4) Mostra les ciutats dels "countryCode" AUS, DOM, GMB i SLV.
-- 4) Показать города с кодом страны: AUS, DOM, GMB и SLV.

select name from world.city
where CountryCode='AUS' or CountryCode='DOM' or CountryCode='GMB' or CountryCode='SLV'
order by name;

select name from world.city
where CountryCode IN ('AUS', 'DOM', 'GMB', 'SLV')
order by name;

-- 5) Mostra totes les dades dels països que tenen entre 70 i 80 anys de "lifeExpentancy".
-- 5) Показать все данные по странам, в которых продолжительность жизни составляет от 70 до 80 лет.

select * from world.country
where LifeExpectancy>70 and LifeExpectancy<80
order by LifeExpectancy;

select * from world.country
where LifeExpectancy between 70 and 80 -- бивин включает границы
order by LifeExpectancy; 

select * from world.country
where LifeExpectancy>=70 and LifeExpectancy<=80 -- то есть вот так писать нет смысла
order by LifeExpectancy;

-- 6) Mostra els noms dels països que estan al continent europeu i a la regió nòrdica.
-- 6) Покажите названия стран, находящихся на европейском континенте и в Северном регионе.

select name from world.country
where Continent='Europe' and Region='Nordic Countries'
order by name;

select name from world.country
where Continent='Europe' and Region like 'Nord%'
order by name;

-- 7) Mostra els 3 països amb més "lifeExpentancy" del grup de països d'europa bàltica i nord amèrica carib.
-- 7) Покажите 3 страны с наибольшей «продолжительностью жизни» из группы стран Балтии, Европы и Северной Америки, Карибского бассейна.

select * from world.country
where (Continent='Europe' and Region='Baltic Countries') or (Continent='North America' and Region='Caribbean')
order by LifeExpectancy desc limit 3;

-- 8) Mostra els països que comencen per lletra "i" o comencen per lletra "o".
-- 8) Покажите страны, которые начинаются на букву «и» или начинаются на букву «о».

select name from world.country
where name like 'i%' or name like 'o%'
order by name;

-- 9) Mostra tots els llenguatges que es parlen al món (que són llenguatge oficial al seu país).
-- 9) Показать все языки, на которых говорят в мире (которые являются официальными языками в вашей стране).

select distinct Language from world.countrylanguage
where IsOfficial=1
order by Language;

select distinct Language, isofficial from world.countrylanguage
where IsOfficial='T'
order by Language;
