### CODE PARTE 1: PREGUNTAS DEL EXAMEN

## 1 - Para agregar un primary Key a una tabla, tenemos que usar el comando ____

CREATE TABLE test (primera INT, segunda VARCHAR(10));

ALTER TABLE test
ADD PRIMARY KEY(primera) ;

DROP TABLE test;

## RESPUESTA: TENEMOS QUE USAR EL COMANDO ALTER

## 2 - Si no especificamos ASC o DESC despues de una clausula de ORDER BY, la configuracion por defecto que se utiliza es:
#SIN ORDEN
SELECT * 
FROM class;

#CON ORDEN 
SELECT * 
FROM class
ORDER BY id_level;

## RESPUESTA: EL VALOR POR DEFECTO ES ASC

## 6 - ¿Que comando es utilizado para cambiar la definicion de una tabla en SQL?

# CREO UNA TABLA
CREATE TABLE test (primera INT, segunda VARCHAR(10));
# MODIFICO LA TABLA
ALTER TABLE test
ADD COLUMN tercera INT;

ALTER TABLE test
DROP COLUMN segunda;
#VEO CAMBIOS
SELECT *
FROM test;

DROP TABLE test;

#RESPUESTA: ALTER

## 7.¿Como podemos usar los datos de mas de una tabla en una consulta?

SELECT id_system_user
FROM system_user
WHERE id_system_user IN 
		(
		SELECT DISTINCT id_system_user 
		FROM play WHERE id_system_user<5
		)
UNION 
SELECT DISTINCT id_system_user
FROM commentary c
LEFT JOIN game d ON c.id_game=d.id_game
WHERE name LIKE '%FIFA%';

## RESPUESTA: TODAS LAS ANTERIORES (UNION, JOIN Y SUBCONSULTA

## 9 - ¿Qué consulta usarían para obtener a todos los estudiantes que tienen un nombre que empieza con la letra "P"?

SELECT * FROM game
WHERE name LIKE 's%';

SELECT * FROM game
WHERE name LIKE '_s%';

## RESPUESTA: USANDO 'p%'

## 10 - Para mostrar solo los valores que estan tanto en la tabla a como en la b, puedo:

SELECT * 
FROM game a
INNER JOIN play b on a.id_game = b.id_game;

SELECT * 
FROM game a
LEFT JOIN play b on a.id_game = b.id_game
WHERE b.id_game IS NOT NULL;

## RESPUESTA: INNER JOIN Y LEFT JOIN SON CORRECTAS



### CODE PARTE 2:A INTRODUCIENDO INSERTS
# INSERTANDO VALORES EN LA TABLA CLASS
SELECT * FROM class;

INSERT INTO class (id_level, id_class, description) 
VALUES (1, 999, 'Spain comedy');

INSERT INTO class (id_class,id_level,description) 
VALUES (1, 2, 'test');

SELECT * FROM class WHERE description='test';


# POSIBLE ERROR
INSERT INTO class (id_class,id_level,description) 
VALUES (888, 999, 'test');

### CODE PARTE 2:B INSERTS MAS AVANZADOS

## AUTOINCREMENTS

CREATE TABLE pay (
id_pay 			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
amount 			REAL NOT NULL,
currency 		VARCHAR(20) NOT NULL,
date_pay 		DATE NOT NULL,
pay_type 		VARCHAR(50),
id_system_user INT NOT NULL,
id_game 		INT NOT NULL);

#MOSTRAR EJECUTANDO ESTO VARIAS VECES
# fijense que aca no decimos los nombres de las columnas
INSERT INTO pay VALUES (NULL, 250, 'U$S', '2021-07-22', 'Paypal', 850, 77);
SELECT * FROM pay;

## INSERT DATOS PARCIALES
# FALTA LA COLUMNA pay_type!
INSERT INTO pay (id_pay, amount, currency, date_pay, id_system_user, id_game) 
VALUES ( NULL, 300, 'U$S', '2021-07-22', 501, 13);

SELECT * FROM pay;

## INSERT CON VALORES NULL DONDE NO CORRESPONDE

INSERT INTO pay (id_pay, amount, currency, date_pay, id_system_user, id_game) 
VALUES ( NULL, NULL, 'U$S', '2021-07-22', 501, 13);

## INSERT DE MULTIPLES DATOS

INSERT INTO pay VALUES 
(NULL, 250, 'U$S', '2021-07-22', 'Paypal', 850, 77),
(NULL, 3700, 'Pesos Arg', '2021-07-22', 'Visa', 38, 31),
(NULL, 180, 'Libras', '2021-07-22', 'Transfer', 175, 16);

SELECT * 
FROM pay;

## INSERTAR DESDE OTRAS TABLAS 

# CREO TABLA TEMPORAL REPLICANDO CLASS Y LA LIMPIO
CREATE TABLE class_backup LIKE class;
TRUNCATE class_backup;

SELECT * FROM class_backup;

#INSERTO VALORES DE LA TABLA CLASS
INSERT INTO class_backup
SELECT * FROM class;

### CODE PARTE 3 UPDATE

#SET SQL_SAFE_UPDATES=0;

## SIN CONDICIONES

UPDATE pay 
SET amount = 123, pay_type = 'nuevo nombre';

SELECT * FROM pay;

## CON CONDICIONES
UPDATE pay
SET pay_type = 'Cash'
WHERE id_system_user = 501;

## CON CONDICIONES
UPDATE pay
SET currency = 'BIT'
WHERE id_game = 13;

SELECT * FROM pay;

### CODE PARTE 4 DELETE
## BORREMOS LOS CAMPOS QUE AGREGAMOS HOY

# DELETE TRADICIONAL
DELETE FROM class 
WHERE id_level = 1 and id_class = 999;

# DELETE DESDE EL FROM
SELECT * FROM class
WHERE description='test';
# REEMPLAZAMOS EL 'SELECT *' FROM POR 'DELETE'
DELETE FROM class 
WHERE description = 'test';

## EJEMPLO  ELIMINANDO FILAS DEPENDIENTES DE OTRAS TABLAS CON TABLAS DE POKEMON
#SETUP
CREATE TABLE videogames (
game_id INT NOT NULL,
game_date DATE NOT NULL,
PRIMARY KEY (game_id)
);
CREATE TABLE types (
type_id INT NOT NULL,
type_name VARCHAR(20) NOT NULL,
game_id INT NOT NULL,
PRIMARY KEY (type_id),
FOREIGN KEY(game_id) REFERENCES videogames(game_id));

INSERT INTO videogames
VALUES (1,'2023-01-01');

INSERT INTO types
VALUES (3,'game',1);

#ELIMINO: ERROR
DELETE FROM videogames
WHERE game_id=1;

#ELIMINO: CORECTO
DELETE FROM types
WHERE game_id=1;
DELETE FROM videogames
WHERE game_id=1;

DROP TABLE videogames,types;

## TRUNCAMOS TABLA PAY

TRUNCATE pay;

DROP TABLE pay;


