### REPORTE: PARTE 1 CREAMOS LAS TABLAS

##COMPLETAMOS PUNTO 3, GUARDANDO LOS RESULTAODS DEL PRIMER PUNTO, EN UNA TABLA
CREATE TABLE reporte_player
#query que creamos antes para tabla 1
SELECT a.id_system_user,
id_user_type,
first_name,
last_name,
jugados,
completados
FROM system_user a
LEFT JOIN (SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user) b ON a.id_system_user=b.id_system_user;

SELECT * FROM reporte_player;
#Query con promedios
SELECT avg(jugados) as promedio_juados,
avg(completados) as promedio_completados
FROM reporte_player;

### REPORT PARTE 2: CREAMOS LA FUNCION

CREATE FUNCTION HIDE_PII_STR (pii VARCHAR(40))
RETURNS VARCHAR(40)
DETERMINISTIC
RETURN (
	SELECT CONCAT(LEFT(pii,3),
		REGEXP_REPLACE(RIGHT(pii,CHAR_LENGTH(pii)-3),'[^@]', '*')) as pii);
        
### REPORTE PARTE 3: CREAMOS LA VISTA TOMANDO EL PUNTO 2 DE LA CLASE PASADA

#Lo que hicimos la clase pasada
SELECT a.id_system_user,id_user_type,
CONCAT(CONCAT(last_name,', '),first_name) as complete_name,
jugados,
completados,
completados/jugados as proportion,
2*jugados+completados as ranking
FROM system_user a
LEFT JOIN (SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user) b ON a.id_system_user=b.id_system_user
ORDER BY ranking DESC, proportion DESC
LIMIT 10;

## CREAMOS VISTA, AGREGAMOS COLUMNAS PERSONALES PERO LAS TAPAMOS CON LA FUNCION

CREATE VIEW top10_no_pii as
SELECT a.id_system_user,id_user_type,
COMPLETE_NAMES(first_name,last_name) as complete_name,
HIDE_PII_STR(email),
HIDE_PII_STR(password),
jugados,
completados,
completados/jugados as proportion,
2*jugados+completados as ranking
FROM system_user a
LEFT JOIN (SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user) b ON a.id_system_user=b.id_system_user
ORDER BY ranking DESC, proportion DESC
LIMIT 10;
## CON ESTO TERMINAMOS EL PUNTO 4 DEL REPORTE

### REPORTE PARTE 4: CREAMOS LA VISTA TOMANDO EL PUNTO 3, PERO LE AGREGAMOS UN LIMITE FLEXIBLE
 
CREATE VIEW top AS
SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user
HAVING jugados>2
ORDER BY completados/jugados DESC;

DELIMITER //
CREATE PROCEDURE top_x (IN x INT)
BEGIN
SELECT * 
FROM top
LIMIT x;
END //

CALL top_x(20);