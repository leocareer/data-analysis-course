SELECT * FROM world.city;

SELECT ID, District FROM world.city;

SELECT District FROM world.city;

SELECT DISTINCT District FROM world.city; -- уникальные строки, проверить

SELECT * FROM world.city ORDER BY District;

SELECT * FROM world.city ORDER BY District DESC; -- обратный порядок по алфавиту

SELECT * FROM world.city ORDER BY District, Population;

SELECT top 10 * FROM city; -- ???

SELECT * FROM world.city ORDER BY ID limit 3; -- ???

SELECT * FROM world.countrylanguage limit 3; -- а так работает



