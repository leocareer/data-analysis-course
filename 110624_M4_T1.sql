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
-- inner join world.countrylanguage
-- on world.country.code = world.countrylanguage.countrycode
where not exists (
	select world.countrylanguage.countrycode
    from world.countrylanguage
    where world.country.code = world.countrylanguage.countrycode
);

SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);



-- 5) Mostra el nom del país amb on es parlen més llengües.
-- 5) Покажите название страны, где говорят на большинстве языков.

-- 6) Mostra el nom del país amb més "population".
-- 6) Покажите название страны с наибольшим населением.

-- 7) Mostra la "population" del país "Guadeloupe" (però, en lloc d'agafar la dada de la taula country, suma les "population" de totes les seves ciutats).
-- 7) Покажите «население» страны «Гваделупа» (но вместо того, чтобы брать данные из таблицы стран, добавьте «население» всех ее городов).

-- 8) Mostra en una mateixa taula, el nom del país, els noms de les seves ciutats, la seva "population" i els seus "language" (del país "Guadeloupe").
-- 8) Покажите в той же таблице название страны, названия ее городов, ее «население» и ее «язык» (из страны «Гваделупа»).

-- 9) Suma la "population" de la consulta anterior (a mà) i compara-la amb la "population" de la consulta núm. 7. Són iguals? Què està passant?
-- 9) Добавьте «население» предыдущего запроса (вручную) и сравните его с «населением» запроса №. 7. Они одинаковые? Что происходит?

