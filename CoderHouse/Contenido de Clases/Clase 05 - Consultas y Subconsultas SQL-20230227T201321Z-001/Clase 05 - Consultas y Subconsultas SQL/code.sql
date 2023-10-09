### PARTE 1: JOINS
## PARTE A : LEFT JOIN

SELECT COUNT(*) FROM game; #100
SELECT COUNT(*) FROM play; #977
SELECT g.id_game as game,
g.name, p.id_system_user as user
FROM game g 
LEFT JOIN play p ON p.id_game = g.id_game;
#Por que si nuestro from esta en la tabla game, el resultado de la tabla es 977 como en play?
SELECT g.id_game as game,
g.name, p.id_system_user as user
FROM game g 
LEFT JOIN play p ON p.id_game = g.id_game
WHERE name='FIFA 22';
#Que significa que haya 15 resultados para FIFA?

## PARTE B: INNER JOIN

#977 RESULTADOS
SELECT g.id_game as game,
g.name, p.id_system_user as user
FROM game g 
INNER JOIN play p ON p.id_game = g.id_game;

## LA DIFERENCIA DE DOS RESULTADOS DE DONDE VIENE? 

SELECT g.id_game as game,
g.name, p.id_system_user as user
FROM game g 
LEFT JOIN play p ON p.id_game = g.id_game
WHERE id_system_user IS NULL;

#HAY DOS JUEGOS QUE NUNCA SE JUGARON, POR LO TANTO NO ESTAN EN LA TABLA PLAY. COMO NO ESTAN EN LAS DOS TABLAS, EL INNER JOIN LOS ELIMINA, PERO NO EL LEFT JOIN

## PARTE C: RIGHT JOIN

SELECT g.id_game as game,
g.name, p.id_system_user as user
FROM game g 
RIGHT JOIN play p ON p.id_game = g.id_game;

#977 ROWS DEVUELTAS, COMO EL INNER JOIN: NO HAY JUEGOS JUGADOS QUE NO ESTEN EN LA BASE DE DATOS


### PARTE 2: UNION
## QUE PASA SI EN UNA UNION TENEMOS MAL LA QUERY?

#6 ROWS
SELECT id_game, name, description, id_level#, id_class 
FROM game
WHERE id_level = 1
UNION 
# 9 ROWS
SELECT id_game, name, description, id_level, id_class 
FROM game
WHERE id_level = 2;

#6 + 9 = 15

### PARTE 3: LIKE
#'the' en el inicio, medio o final de el nombre de juegos
SELECT name
FROM game
WHERE name LIKE '%the%';

#'the' en el inicio del nombre de juegos
SELECT name
FROM game
WHERE name LIKE 'the%';

#'the' en el final del nombre de juegos
SELECT name
FROM game
WHERE name LIKE '%the';

# Juegos que tengan un 20 seguido de dos valores cualquiera
SELECT name
FROM game
WHERE name LIKE '%20__%';
#Viendo los resultados. Que pasa si saco el primer porcentaje?

### PARTE 4: SUBCONSULTAS

SELECT id_system_user, last_name
FROM system_user
WHERE id_user_type = (SELECT max(id_user_type) FROM user_type);


#LOS USUARIOS QUE VOTARON CON UN PUNTAJE SUPERIOR AL PROMEDIO REDONDEADO
#La funcion FLOOR nos da el 'piso' de un numero, su entero mas cercano hacia el cero
SELECT id_system_user
FROM vote WHERE value >= (SELECT FLOOR(AVG(value)) FROM vote);

#VALORES TOTALES DEL JUEGO CON MENOR ID
SELECT SUM(value) 
FROM vote
WHERE id_game = (SELECT min(id_game) FROM game);


#Los usuarios que votaron por encima del promedio total de votos.
SELECT id_system_user 
FROM vote
WHERE value > (SELECT avg(value) FROM vote);

### PARTE 5: ORDER BY, GROUP BY Y HAVING EN SUBCONSUTLAS
#ORDER BY BY EN SUBCONSUTLAS
SELECT id_system_user, last_name
FROM system_user
WHERE id_user_type = (SELECT max(id_user_type) FROM user_type)
ORDER BY last_name ASC;

#GROUP BY EN SUBCONSULTAS
SELECT id_game, SUM(value) AS votos
FROM vote 
WHERE id_game IN (SELECT id_game 
					FROM game WHERE id_level = 1)
GROUP BY id_game;

#HAVING EN SUBCONSULTAS

SELECT id_game, name
FROM game
WHERE id_level = 1 AND
     id_game IN 
 (SELECT id_game
         FROM vote
         GROUP BY id_game
         HAVING count(*) > 1)
ORDER BY name DESC;
