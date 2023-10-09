#### CODE PARTE 1: VISTAS BASICAS
### Vista basica, copiando a una tabla
USE gamers;

CREATE VIEW ejemplo_1 AS
SELECT * 
FROM class;

SELECT * FROM ejemplo_1;
### ERROR POR VISTA QUE YA EXISTE
CREATE VIEW ejemplo_1 AS
SELECT * 
FROM class;

### PODEMOS ELIMINAR ESTE ERROR EN LAS VISTAS, AGREGANDO OR REPLACE
CREATE OR REPLACE VIEW ejemplo_1 AS
SELECT * 
FROM class;

### AGREGAMOS WHERE, GROUP BY, HAVING Y ORDER BY CUANDO CREAMOS LA VIEW
## LA EJECUCION NO SE DA EN LA CREACION DE LA VIEW, SINO CUANDO HACEMOS EL SELECT DE LA VIEW. 
## MIREMOS LO QUE PASA SI HAY UN ERROR EN LA VIEW
CREATE OR REPLACE VIEW ejemplo_1 AS
SELECT id_level,AVG(id_class) as promedio_class 
FROM class
WHERE id_level>5
GROUP BY id_level
HAVING promedio_class>=0
ORDER BY id_level ASC,promedio_class DESC;

SELECT * FROM ejemplo_1;

### AGREGAMOS WHERE, GROUP BY, HAVING Y ORDER BY POR FUERA DE LA CREACION DE LA VISTA
DROP VIEW ejemplo_1;
CREATE OR REPLACE VIEW ejemplo_2 AS
SELECT *
FROM class;

SELECT id_level,AVG(id_class) as promedio_class 
FROM ejemplo_2
WHERE id_level>5
GROUP BY id_level
HAVING promedio_class>0
ORDER BY id_level ASC,promedio_class DESC;

#### EJERCICIO GRUPAL
#Realicemos una vista que liste los nombres y descripción de los distintos videojuegos que ningún usuario ha podido completar







CREATE OR REPLACE VIEW juegos_dificiles AS
	(
    SELECT name,COALESCE(AVG(completed),0) as proporcion_completados
	FROM game a
	LEFT JOIN play b 
	on a.id_game=b.id_game
	GROUP BY name
	HAVING proporcion_completados=0);


SELECT * FROM juegos_dificiles;

#### CODE PARTE 2: MODIFICANDO VISTAS

### PODEMOS HACERLO CON WORKBENCH

### PODEMOS HACERLO CON CODIGO (RECOMENDADO)

## ALTERAR/ CAMBIAR VISTAS
ALTER VIEW juegos_dificiles AS 
	(
    SELECT name,COALESCE(AVG(completed),0) as proporcion_completados
	FROM game a
	LEFT JOIN play b 
	on a.id_game=b.id_game
	GROUP BY name
	HAVING proporcion_completados=1);
    
## ELIMINAR VISTAS
DROP VIEW juegos_dificiles;

## OBVIAMENTE, NOTAR QUE ALTERVIEW NO SE PUEDE USAR UNA VEZ QUE LA VISTA NO EXISTE

ALTER VIEW juegos_dificiles AS 
	(
    SELECT name,COALESCE(AVG(completed),0) as proporcion_completados
	FROM game a
	LEFT JOIN play b 
	on a.id_game=b.id_game
	GROUP BY name
	HAVING proporcion_completados=1);

#RECORDATORIO PARA VER TODAS LAS TABLAS Y VISTAS
SHOW FULL TABLES;

#### CODE PARTE 3: USANDO VISTAS PARA EXPRESAR LAS METRICAS

##HOY ESTAMOS EN LA FECHA '2021-10-20' Y TENEMOS QUE CALCULAR:
#ACQUISITION CREACION DE LA CUENTA
#ACTIVATION: PRIMER COMENTARIO
#RETENTION: COMENTARIOS
#CHURN: DEJAR DE COMENTAR POR DOS MESES

CREATE TABLE metricas_raw AS 
SELECT a.id_system_user,COALESCE(a.id_system_user=b.id_system_user,0) as comentador,fecha_registro,ultimo_login,
DATEDIFF('2021-10-20',ultimo_login)<365 AS cuenta_retenida,
DATEDIFF('2021-10-20',ultimo_login)>365 cuenta_churneada
FROM system_user a
LEFT JOIN (
SELECT id_system_user,MIN(comment_date) as fecha_registro,max(comment_date) as ultimo_login
FROM commentary
GROUP BY id_system_user) b ON a.id_system_user=b.id_system_user;

SELECT * FROM metricas_raw;

#ASUMIMOS QUE HOY ES
CREATE OR REPLACE VIEW metricas AS 
SELECT COUNT(*) as cuentas_adquiridas,
SUM(comentador) as cuentas_activadas,
SUM(cuenta_retenida) AS cuentas_retenidas,
SUM(cuenta_churneada) as cuentas_churneadas
FROM metricas_raw;

SELECT * FROM metricas;

SELECT cuentas_activadas/cuentas_adquiridas as activation_rate,
cuentas_retenidas/cuentas_activadas as retention_rate,
cuentas_churneadas/cuentas_activadas as churn_rate
FROM metricas