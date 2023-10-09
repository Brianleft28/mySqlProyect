### CODE PARTE 1: DUDA DE ESTUDIANTE
SET SQL_SAFE_UPDATES = 0;



Create table tabla_0  (id_reserva VARCHAR(40), id_lead VARCHAR(60),created_date DATE,created_by VARCHAR(40));
INSERT INTO tabla_0 VALUES 
('R-9D3EBD4C','0064X00002DHnYVQA1','2023-03-10','Brenda'),
('R-9D3EBD4C','0064X00002DHnYVQA1','2023-03-13','Oscar'),
('R-883827B0','0064X00002DImAWQA1','2023-01-08','Julio');

#QUERY

select max(created_date) as created_date, id_reserva, id_lead, created_by
from tabla_0
group by id_reserva, id_lead, created_by;


#RESOLUCION
#1) ORDENAR COLUMNAS, PRIMER VARIABLES DEL GROUP BY Y POR ULTIMO LAS QUE NO ESTAN
 
select id_reserva, id_lead, created_by, max(created_date) as created_date
from tabla_0
group by id_reserva, id_lead, created_by;

# Si estamos agrupando por el creador, entonces no vamos a tener distintas lineas para el mismo id.
#2) Sacamos el creador del lead, para tener la cantidad correcta de leads 
select id_reserva, id_lead, max(created_date) as created_date
from tabla_0
group by id_reserva, id_lead;

#3) Hacemos un left join con el creador del lead
SELECT a.id_reserva,a.id_lead,a.created_date,b.created_by
FROM
(select a.id_reserva, a.id_lead, max(a.created_date) as created_date
from tabla_0 a
group by a.id_reserva, a.id_lead) a
LEFT JOIN tabla_0 b ON a.id_reserva=b.id_reserva AND a.id_lead=b.id_lead AND a.created_date=b.created_date;

## Consideraciones: esta query solo sirve si pueden tener un lead por dia con distinto creador. 
#Como seria la solucion si pudieran tener mas de uno?

DROP TABLE tabla_0;

#### CODE PARTE 2: TRIGGERS SIMPLES

### VER EN WORKBENCH TRIGGERS ASOCIADOS A TABLAS
### 1) EN TABLE INSPECTOR
### 2) EN CARPETA ESPECIFICA


## CODE PARTE 2:A 



CREATE TABLE new_games (
id_game INT PRIMARY KEY,
name varchar(100),
description varchar(300));


CREATE TRIGGER tr_add_new_game
AFTER INSERT ON game
FOR EACH ROW
INSERT INTO new_games (id_game,name,description) VALUES (NEW.id_game,NEW.name,NEW.description);

INSERT INTO game (id_game, name, description, id_level, id_class) 
VALUES (150, 'Mortal Kombat', 'play station', 2, 143);

SELECT * FROM new_games;

DELETE FROM game WHERE id_game=150;



## CODE PARTE 2:B



CREATE TABLE metricas_generales(usuarios_totales INT);

DELIMITER $$
CREATE TRIGGER contar_usuarios_delete
AFTER DELETE ON system_user
FOR EACH ROW
BEGIN
	DECLARE usuarios INT;
	DELETE FROM metricas_generales;
    SET usuarios= (SELECT COUNT(*) FROM system_user);
    INSERT INTO metricas_generales VALUES (usuarios);
END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER contar_usuarios_insert
AFTER INSERT ON system_user
FOR EACH ROW
BEGIN
	DECLARE usuarios INT;
	DELETE FROM metricas_generales;
    SET usuarios= (SELECT COUNT(*) FROM system_user);
    INSERT INTO metricas_generales VALUES (usuarios);
END $$
DELIMITER ;

SELECT COUNT(*) FROM system_user; 
SELECT * FROM metricas_generales;



## CODE PARTE 2:C


DELIMITER $$
CREATE TRIGGER validar_correo
BEFORE INSERT ON system_user
FOR EACH ROW
BEGIN
  IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo electrónico ingresado no es válido';
  END IF;
END $$
DELIMITER ;

INSERT INTO system_user VALUES
(1001,'Ivan','Cereghetti','ivceregh@gmail.com','asdadasd','40');

SELECT * FROM metricas_generales;

DELETE FROM system_user WHERE id_system_user=1001;

SELECT * FROM metricas_generales;

### CODE PARTE 2:D
# QUE PASA SI SE QUIERE ACTUALIZAR LA TABLA DE ULTIMA FECHA? SI O SI TIENE QUE SER MAYOR O IGUAL A LA PRIMERA
SELECT * FROM comment;


DELIMITER $$
CREATE TRIGGER validar_fechas_comment
BEFORE UPDATE ON comment
FOR EACH ROW
BEGIN
  IF NEW.last_date < OLD.first_date THEN 
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha final ingresada no puede ser menor a la primer fecha'; 
  END IF; 
END $$
DELIMITER ;


SELECT * FROM comment;

UPDATE comment
SET last_date='2015-11-17'
WHERE id_game=1 AND id_system_user=31;

SELECT * FROM comment;

UPDATE comment
SET last_date='2015-09-09'
WHERE id_game=1 AND id_system_user=31;


#### PARTE 3: TRIGGERS DE AUDITORIA CON FUNCIONES
### PARTE 3:A LISTA DE FUNCIONES
## FUNCIONES DE FECHA Y HORA
SELECT 
NOW(),
CURRENT_TIMESTAMP(),
CURRENT_DATE(),
CURDATE(),
CURRENT_TIME(),
CURTIME();
## FUNCIONES DE USUARIO
# EN NUESTRO  CASO NO VAN A SER MUY UTILES, POR QUE NO TENEMOS CONFIGURADAS LAS CUENTAS NI OTROS USUARIOS QUE USEN LA BASE DE DATOS

SELECT 
SESSION_USER(), #nos da el usuario y el hostname de la cuenta usada para conectarse al servidor,
SYSTEM_USER(), # SYSTEM_USER devuelve el sistema operativo del usuario conectado
USER(); #USER nos devuelve lo mismo que SESSION USER, pero en formato mail, osea usuario arroba host

## FUNCIONES DE PLATAFORMA
SELECT DATABASE(),
VERSION();


### PARTE 3:B

CREATE TABLE game_audit (id_game VARCHAR(40),user VARCHAR(20),timestamp timestamp);
CREATE TRIGGER game_audit_insert
AFTER INSERT ON game
FOR EACH ROW
  INSERT INTO game_audit VALUES (NEW.id_game,USER(),CURRENT_TIMESTAMP());

SELECT * FROM game;

INSERT INTO game (id_game, name, description, id_level, id_class) 
VALUES (101, 'Minecraft', 'play station', 2, 143);

SELECT * FROM game_audit;

SELECT * FROM new_games;

