#### CODE PARTE 1 : VARIABLES
### CREAMOS UNA VARIABLE Y LA USAMOS EN UNA CONSULTA SELECT
SET @variable=CURRENT_DATE;
SELECT @variable;

### CREAMOS UNA VARIABLE DESDE UNA QUERY Y LA USAMOS PARA FILTRAR
SET @new_variable := (
					SELECT id_system_user 
					FROM play
                    GROUP BY id_system_user
                    ORDER BY COUNT(*) DESC
                    LIMIT 1);
SELECT * FROM commentary
WHERE id_system_user=@new_variable;

### SETEAMOS UNA VARIABLE CON UNA QUERY
SELECT @max_rows := count(*) FROM game;
SELECT @max_rows;

### PODEMOS SETEAR MAS DE UNA VARIABLE Y ES LO MISMO USAR EL '=' o ':='
SET @variable1=2,@variable2=CURRENT_DATE()-1;

### SOLO PODEMOS SETEAR UN VALOR EN CADA VARIABLE

SET @new_variable := (
					SELECT id_system_user 
					FROM play
                    GROUP BY id_system_user
                    ORDER BY COUNT(*) DESC
                    LIMIT 2);
                    
SELECT * FROM 
performance_schema.user_variables_by_thread;
#https://dev.mysql.com/doc/refman/5.7/en/performance-schema-user-variable-tables.html


#### CODE PARTE 2 : FUNCIONES SIN CUERPO

### VEMOS LAS FUNCIONES DE LAS CLASES PASADAS, FUNCIONES SIN CUERPO

CREATE FUNCTION HIDE_PII_STR (pii VARCHAR(40))
RETURNS VARCHAR(40)
DETERMINISTIC
RETURN (
	SELECT CONCAT(LEFT(pii,3),
		REGEXP_REPLACE(RIGHT(pii,CHAR_LENGTH(pii)-3),'[^@]', '*')) as pii);
        
CREATE FUNCTION COMPLETE_NAMES (primer_nombre VARCHAR(40),ultimo_nombre VARCHAR(40))
RETURNS VARCHAR(40)
DETERMINISTIC
RETURN (
	SELECT CONCAT(last_name,', ',first_name));

#### CODE PARTE 3 : FUNCIONES COMPLETAS, CON CUERPO

## FUNCION 1 
# NO PODEMOS EJECUTARLA, POR QUE NO NOS TOMA EL DELIMITER CORRECTAMENTE, LO HACEMOS DESDE WORKBENCH POR AHORA

CREATE FUNCTION `calcular_litros_de_pintura` (largo INT, alto INT, total_manos INT) RETURNS FLOAT
NO SQL
BEGIN
    	DECLARE resultado FLOAT;
    	DECLARE litro_x_m2 FLOAT;
	SET litro_x_m2 = 0.10;
	SET resultado = ((largo * alto) * total_manos) * litro_x_m2;
RETURN resultado;
END

# PROBVEMOS CAMBIANDO LOS VALORES Y VIENDO COMO CAMBIA EL RESULTADO
;
SELECT calcular_litros_de_pintura(10,9.2,5);

### NO SQL VS DETERMINISTIC - NO HAY DIFERENCIAS
DROP FUNCTION calcular_litros_de_pintura;
CREATE FUNCTION `calcular_litros_de_pintura` (largo INT, alto INT, total_manos INT) RETURNS FLOAT
DETERMINISTIC
BEGIN
    	DECLARE resultado FLOAT;
    	DECLARE litro_x_m2 FLOAT;
	SET litro_x_m2 = 0.10;
	SET resultado = ((largo * alto) * total_manos) * litro_x_m2;
RETURN resultado;
END
;
SELECT calcular_litros_de_pintura(10,9.2,5);
