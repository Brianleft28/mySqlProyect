### CODE PARTE 1: REPASO
## PARTE 1:A PROBLEMA 1 
# PROBLEMA
SELECT a.id_game,name,description,id_level,id_class
FROM game a
LEFT JOIN (
Select
SUM(completed) as completados
From play b
group by b.id_game
HAVING completados>=1) ON b.id_game=a.id_game;


# RESULTADO

SELECT a.id_game,
name,
description,
id_level,id_class
FROM game a
LEFT JOIN (
	Select
	id_game, ##### agregamos la columna id_game, para poder hacer el group by y el join
	SUM(completed) as completados
	From play ##### aca tenemos que eliminar la b, por que no necesitamos nombrar a la tabla play
	group by id_game ##### eliminamos la b por la misma razon que el error anterior
	HAVING completados>=1) b ###### Aca hay que agregar b para nombrar la subconsulta
ON b.id_game=a.id_game;

## PARTE 1:B PROBLEMA 2

#TABLAS EJEMPLO 1
SELECT * FROM system_user;
SELECT * FROM comment;
SELECT id_game,name,id_level,id_class FROM game;
#### CODE PARTE 1: STACKOVERFLOW

# TABLAS TIPO 2
SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user
HAVING jugados>2
ORDER BY completados/jugados DESC;

SELECT * FROM play;

### VER TABLAS DEL ALUMNO

#### CODE PARTE 2: EJEMPLO DE STACKOVERFLOW


CREATE TABLE clients (
client_id INT NOT NULL,
mail VARCHAR(30) NOT NULL,
phone INT NOT NULL,
PRIMARY KEY (client_id)
);

INSERT INTO clients VALUES 
(1,'player_1@gmail.com',23234123),
(2,'player_2@outlook.com',23235543),
(3,'player_3@hotmail.com',343435523);

CREATE VIEW clients_partial as (
SELECT client_id,
mail as mail_partial, #### PROBLEM TO SOLVE  
phone as phone_partial ### PROBLEM TO SOLVE
FROM clients);

SELECT * FROM clients_partial;

#### CODE PARTE 3: Operador IN

# EJECUCION SIN IN
SELECT * 
FROM game
WHERE id_game=1 OR 
id_game=20 OR 
id_game=4;

# EJECUCION CON IN
SELECT * 
FROM game
WHERE id_game IN (1,20,4);

# EJECUCION NOT IN
SELECT * 
FROM game
WHERE id_game NOT IN (SELECT id_game FROM play);


#### CODE PARTE 4: Insert con subconsultas

CREATE TABLE NEW_CLASS (
    id_level int NOT NULL,
    id_class int NOT NULL,
    description varchar(200) NOT NULL,
    CONSTRAINT PK_CLASS PRIMARY KEY (id_class,id_level)
);


CREATE TABLE NEW_LEVEL_GAME (
    id_level int NOT NULL,
    description varchar(200) NOT NULL,
    CONSTRAINT PK_LEVEL_GAME PRIMARY KEY (id_level)
);

INSERT INTO new_class (id_level, id_class, description) VALUES 
(17, 1, 'Adventure Other'),
(15, 1, 'Spy Other'),
(17, 2, 'British Comedy'),
(17, 2, 'Adventure '),
(14, 1, ''),
(18, 1, '');

INSERT INTO new_level_game 
SELECT distinct id_level, 'New level' AS description
FROM new_class 
WHERE id_level NOT IN (
	Select id_level 
    from level_game);

SELECT * FROM new_class;
SELECT * FROM new_level_game;

#### CODE PARTE 5: Update con subconsultas

SET SQL_SAFE_UPDATES=0;

SELECT * FROM NEW_CLASS;

SELECT * FROM NEW_LEVEL_GAME;

UPDATE NEW_CLASS
SET id_level=20
WHERE id_level IN (SELECT id_level FROM NEW_LEVEL_GAME WHERE id_level=17);

#### CODE PARTE 6: Delete con subconsultas

## CREAMOS BACKUP

CREATE TABLE NEW_CLASS_BACKUP LIKE NEW_CLASS;
# BORRAMOS FILAS Y VERIFICAMOS QUE TODO ESTE BIEN
DELETE FROM NEW_CLASS
WHERE id_level NOT IN (SELECT id_level 
  FROM NEW_LEVEL_GAME);

# ELIMINAMOS BACKUP  
DROP TABLE NEW_CLASS_BACKUP;
  