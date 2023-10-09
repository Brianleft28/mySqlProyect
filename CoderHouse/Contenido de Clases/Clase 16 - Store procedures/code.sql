#### CODE PARTE 1: DELIMITER
#EJEMPLO BASICO
DELIMITER $$
SELECT * FROM class $$
DELIMITER ;

#EJEMPLO HASTA QUE NO DEFINAMOS EL CAMBIO A LA NORMALIDAD, NO SE VA A HACER

# solo se ejecuta la primer consulta, pero no da error
DELIMITER $$
SELECT * FROM class $$
SELECT * FROM commentary;
DELIMITER ;

# se ejecutan las dos consultas
DELIMITER $$
SELECT * FROM class $$
SELECT * FROM commentary $$
DELIMITER ;

## EJEMPLO DE LA CLASE ANTERIOR, SOLO LO PODEMOS EJECUTAR CON DELIMITER (O CON LA INTERFAZ)
#DELIMITER //
CREATE FUNCTION `calcular_litros_de_pintura` (largo INT, alto INT, total_manos INT) RETURNS FLOAT
NO SQL
BEGIN
    	DECLARE resultado FLOAT;
    	DECLARE litro_x_m2 FLOAT;
	SET litro_x_m2 = 0.10;
	SET resultado = ((largo * alto) * total_manos) * litro_x_m2;
RETURN resultado;
END ;#//
#DELIMITER ;

SELECT calcular_litros_de_pintura(10,10,5);

#### CODE PARTE 2: STORED PROCEDURES SIMPLES
###CREO EL PROCEDIMIENTO CON EL NAVEGADOR DE WORKBENCH

CREATE PROCEDURE `nombre_del_sp` ()
BEGIN
SELECT * FROM class;
END

# LO TESTEAMOS
CALL nombre_del_sp;
# LO DROPEAMOS
DROP PROCEDURE nombre_del_sp

### EJEMPLO SIMPLE

# SIN PARAMETROS DE ENTRADA Y DE SALIDA, SOLO SE EJECUTA UN SELECT
DELIMITER //
CREATE PROCEDURE `nombre_del_sp` ()
BEGIN
SELECT * FROM class;
END //
DELIMITER ;

# USAMOS CALL PARA EJECUTAR EL PROCEDIMIENTO
CALL nombre_del_sp;

## DROPEAMOS EL PROCEDIMIENTO COMO CUALQUIER OBJETO
DROP PROCEDURE nombre_del_sp

## LA EJECUCION DEL PROCEDIMIENTO SE HACE EN EL CALL, NO EN LA CREACION. POR ESO PODEMOS CREAR PROCEDIMIENTOS ERRONEOS (VERIFICAR QUERY PRIMERO)
DELIMITER //
CREATE PROCEDURE `nombre_del_sp` ()
BEGIN
SELECT * FROM inexistente;
END //
DELIMITER ;
CALL nombre_del_sp;

### EJEMPLO CON PARAMETROS DE ENTRADA

## Tengo que agregar un nivel en level_game
SELECT * FROM level_game;

## Creo un procedimiento para hacerlo
DELIMITER $$
CREATE PROCEDURE insertar_level_game (IN id_level INT, IN description VARCHAR(40))
BEGIN
  INSERT INTO level_game (id_level, description) VALUES (id_level, description);
END $$
DELIMITER ;

CALL insertar_level_game(17,'level 17');

SELECT * FROM level_game;

### EJEMPLO CON PARAMETROS DE SALIDA

# DEFINIMOS QUE LA CANTIDAD DE NIVELES SE VA A GUARDAR EN UNA VARIABLE LLAMADA VAL_TOTAL Y CREAMOS ESA VARIABLE
DELIMITER $$
CREATE PROCEDURE cantidad_level_game (OUT val_total INT)
BEGIN
  SELECT COUNT(*) INTO val_total FROM level_game;
END $$
DELIMITER ;

# SETEAMOS LA VARIABLE EN 0
SET @total_niveles = 0;
#HACEMOS EL CALL PARA DEFINIR EL VALOR DE LA VARIABLE
CALL cantidad_level_game(@total_niveles);

#MIRAMOS RESULTADO
SELECT @total_niveles;

# COMBINAMOS LOS DOS PROCEDIMIENTOS
CALL insertar_level_game(18,'level 18');
CALL cantidad_level_game(@total_niveles);
SELECT @total_niveles;
CALL insertar_level_game(19,'level 19');
CALL cantidad_level_game(@total_niveles);
SELECT @total_niveles;

DROP PROCEDURE insertar_level_game;
DROP PROCEDURE cantidad_level_game;

#### CODE PARTE 3: CONDICIONALES EN SP
## IF (TABLA)

SELECT id_game, id_system_user, 
IF(completed > 0, 'Terminado', 'No terminado') AS estado
FROM play;

##CASE - WHEN (TABLA)
SELECT id_game, dificultad,
CASE WHEN dificultad<0.25 THEN 'muy dificil'
	WHEN dificultad<0.5 THEN 'dificil'
    WHEN dificultad<0.75 THEN 'intermedia'
    ELSE 'facil' END as nivel_dificultad
FROM (SELECT id_game,AVG(completed) dificultad 
		FROM play 
        GROUP BY 1) a;

#### CODE PARTE 4: STORED PROCEDURES COMPLEJOS
### EJEMPLO CON IF

DELIMITER //
CREATE PROCEDURE procedimiento_if (IN condicion INTEGER)
BEGIN
If condicion = 1 THEN
	SELECT * FROM game;
ELSE
	SELECT * FROM commentary;
END IF;
END //
DELIMITER ;

CALL procedimiento_if(1);
CALL procedimiento_if(2);

### EJEMPLO CON PARAMETROS DE SALIDA Y ENTRADA 1: COMBINAMOS CASOS PREVIOS

DELIMITER $$
CREATE PROCEDURE insertar_y_contar_level_game (IN id_level INT, IN description VARCHAR(40),OUT val_total INT)
BEGIN
  INSERT INTO level_game (id_level, description) VALUES (id_level, description);
  SELECT COUNT(*) INTO val_total FROM level_game;
END $$
DELIMITER ;

CALL insertar_y_contar_level_game(20,'level 20',@total_niveles);
select @total_niveles;
CALL insertar_y_contar_level_game(21,'level 21',@total_niveles);
select @total_niveles;

### EJEMPLO CON PARAMETROS DE SALIDA Y ENTRADA 2: MODIFICANDO TABLAS


DELIMITER $$
CREATE PROCEDURE level_game_default ()
BEGIN
  DROP TABLE IF EXISTS hora_ejecucion;
  CREATE TABLE hora_ejecucion (tiempo TIME);
  INSERT INTO hora_ejecucion VALUES (CURRENT_TIME);
  DELETE FROM level_game
  WHERE id_level>16;
END $$
DELIMITER ;

SELECT * FROM level_game;
CALL level_game_default;
SELECT * FROM level_game;
SELECT * FROM hora_ejecucion;

### CODE PARTE 5: CLAUSULAS DINAMICAS
## EJEMPLO 1: INSERTANDO NIVELES
PREPARE ejemplo_insert FROM 'INSERT INTO level_game (id_level, description) VALUES (?, ?)';

SET @val1 = (select CAST(MAX(id_level)+1 AS CHAR(40)) FROM level_game);
SET @val2 = CONCAT('level ',@val1);

EXECUTE ejemplo_insert USING @val1, @val2;

select * from level_game;

## EJEMPLO 2: CREANDO TABLAS DINAMICAS
# CREAMOS VARIABLES PARA LAS PARTES DE LA FECHA
SET @val1 = YEAR(CURRENT_DATE);
SET @val2 = MONTH(CURRENT_DATE);
SET @val3 = DAY(CURRENT_DATE);
# CREAMOS LE NOMBRE DE LA TABLA
SET @table_name = CONCAT('fecha_', @val1, '_', @val2, '_', @val3);
# CREAMOS EL COMANDO A EJECUTAR
SET @sql = CONCAT('CREATE TABLE ', @table_name, ' (col1 VARCHAR(40), col2 VARCHAR(40))');
PREPARE stmt FROM @sql;
EXECUTE stmt;

EXECUTE tabla_con_fecha USING @val1, @val2, @val3;

SHOW TABLES LIKE 'fecha%';