### CODE PARTE 1: FUNCIONES
USE gammers_model;

CREATE FUNCTION COMPLETE_NAMES (primer_nombre VARCHAR(40),ultimo_nombre VARCHAR(40))
RETURNS VARCHAR(40)
DETERMINISTIC
RETURN (
	SELECT CONCAT(last_name,', ',first_name));

SELECT *,
COMPLETE_NAMES(first_name,last_name) 
FROM system_user;

### CODE PARTE 2: VISTAS

CREATE VIEW top5 AS
SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user
HAVING jugados>2
ORDER BY completados/jugados DESC
LIMIT 5;

#Podemos hacer consultas
SELECT * FROM top5;

#Noten en la interfaz la diferencia de icono, y la diferencia de secciones que tenemos.

DROP VIEW top5;

#Para saber que cosa es que, podemos ver las tablas y las vistas con este comando
SHOW FULL TABLES;

### CODE PARTE 3: STORED PROCEDURES
#HAGAMOS UN EJEMPLO SENCILLO
DELIMITER //
CREATE PROCEDURE comments_from_date (IN x DATE)
BEGIN
SELECT * 
FROM commentary
WHERE comment_date>x;
END //

CALL comments_from_date('2019-01-01');
