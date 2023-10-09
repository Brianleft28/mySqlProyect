#### CODE PARTE 1: ON DELETE CASCADE

## CREAMOS TABLAS DE EJEMPLO
CREATE TABLE pais (
pais_id INT PRIMARY KEY,
nombre_pais VARCHAR(50) 
);

CREATE TABLE personas (
persona_id INT PRIMARY KEY,
nombre_completo VARCHAR(60),
pais_id INT);

## AGREGAMOS CONSTRAINT
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON DELETE CASCADE;

## INSERTAMOS VALORES
INSERT INTO PAIS (pais_id,nombre_pais)
VALUES 	(1, 'España'),
		(2, 'Italia'),
        (3, 'Argentina'),
        (4, 'Albania'),
        (5, 'Brasil');
        
INSERT INTO PERSONAS (persona_id,nombre_completo, pais_id)
VALUES 	(1, 'Fernando Omar',3),
		(2, 'Julian Conte',3),
        (3, 'Nicolas Mariano',1),
        (4, 'Laura Grisel',2),
        (5, 'Constantino Pascual',4);

## ELIMINAMOS A ARGENTINA

DELETE FROM pais 
WHERE pais_id = 3;

## CONSECUENCIAS: SE ELIMINO A ARGENTINA DE LAS DOS TABLAS
SELECT * FROM PAIS;
SELECT * FROM PERSONAS;

## DROP CONSTRAINT: VENTAJA DE PONER NOMBRE A LAS RESTRICCIONES

# EXPLORAR TABLE INSPECTOR DE PERSONAS
ALTER TABLE personas
DROP CONSTRAINT FK_PERSONAS_PAIS;
# VER CAMBIOS EN TABLE INSPECTOR DE PERSONAS

# VER QUE PASARIA SIN CONSTRAINT
ALTER TABLE personas
ADD FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON DELETE CASCADE;
# VER TABLE INSPECTOR
# NO SABEMOS EL NOMBRE GENERICO Y TENEMOS QUE BUSCARLO PARA ELIMINARLO
ALTER TABLE personas
DROP  CONSTRAINT personas_ibfk_1;

DROP TABLE pais,personas;


#### CODE PARTE 2: ON DELETE RESTRICT - NO ACTION

## CREAMOS TABLAS DE EJEMPLO
CREATE TABLE pais (
pais_id INT PRIMARY KEY,
nombre_pais VARCHAR(50) 
);

CREATE TABLE personas (
persona_id INT PRIMARY KEY,
nombre_completo VARCHAR(60),
pais_id INT);

## AGREGAMOS CONSTRAINT
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON DELETE RESTRICT;

## INSERTAMOS VALORES
INSERT INTO PAIS (pais_id,nombre_pais)
VALUES 	(1, 'España'),
		(2, 'Italia'),
        (3, 'Argentina'),
        (4, 'Albania'),
        (5, 'Brasil');
        
INSERT INTO PERSONAS (persona_id,nombre_completo, pais_id)
VALUES 	(1, 'Fernando Omar',3),
		(2, 'Julian Conte',3),
        (3, 'Nicolas Mariano',1),
        (4, 'Laura Grisel',2),
        (5, 'Constantino Pascual',4);

## ELIMINAMOS A ARGENTINA? NO PODEMOS!

DELETE FROM pais 
WHERE pais_id = 3;

## ELIMINAMOS A BRASIL

DELETE FROM pais 
WHERE pais_id = 5;

## CONSECUENCIAS: SE ELIMINO A BRASIL DE LA TABLA PERSONAS, POR QUE NO HABIA REFERENCIAS EN LA TABLA PAIS DE ESE REGISTRO. 
#POR ESO NO PUDIMOS ELIMINAR A ARGENTINA
SELECT * FROM PAIS;
SELECT * FROM PERSONAS;

DROP TABLE pais,personas;

#### CODE PARTE 3: ON DELETE SET NULL

## CREAMOS TABLAS DE EJEMPLO
CREATE TABLE pais (
pais_id INT PRIMARY KEY,
nombre_pais VARCHAR(50) 
);

CREATE TABLE personas (
persona_id INT PRIMARY KEY,
nombre_completo VARCHAR(60),
pais_id INT);

## AGREGAMOS CONSTRAINT
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON DELETE SET NULL;

## INSERTAMOS VALORES
INSERT INTO PAIS (pais_id,nombre_pais)
VALUES 	(1, 'España'),
		(2, 'Italia'),
        (3, 'Argentina'),
        (4, 'Albania'),
        (5, 'Brasil');
        
INSERT INTO PERSONAS (persona_id,nombre_completo, pais_id)
VALUES 	(1, 'Fernando Omar',3),
		(2, 'Julian Conte',3),
        (3, 'Nicolas Mariano',1),
        (4, 'Laura Grisel',2),
        (5, 'Constantino Pascual',4);

## ELIMINAMOS A ARGENTINA

DELETE FROM pais 
WHERE pais_id = 3;

## CONSECUENCIAS: SE ELIMINO A ARGENTINA DE LA TABLA PERSONAS, LAS REFERENCIAS A ESE REGISTRO EN LA OTRA TABLA FUERON REEMPLAZADAS POR NULL
SELECT * FROM PAIS;
SELECT * FROM PERSONAS;

### CASO RARO: QUE PASA SI VUELVO A AGREGAR A ARGENTINA?
INSERT INTO PAIS (pais_id,nombre_pais)
VALUES (3, 'Argentina');

# SIGUEN CON NULL POR QUE SE ROMPIO LA CONEXION

DROP TABLE pais,personas;

#### CODE PARTE 4: ON UPDATE

SET SQL_SAFE_UPDATES=0;

## CREAMOS TABLAS DE EJEMPLO
CREATE TABLE pais (
pais_id INT PRIMARY KEY,
nombre_pais VARCHAR(50) 
);

CREATE TABLE personas (
persona_id INT PRIMARY KEY,
nombre_completo VARCHAR(60),
pais_id INT);

## INSERTAMOS VALORES
INSERT INTO PAIS (pais_id,nombre_pais)
VALUES 	(1, 'España'),
		(2, 'Italia'),
        (3, 'Argentina'),
        (4, 'Albania'),
        (5, 'Brasil');
        
INSERT INTO PERSONAS (persona_id,nombre_completo, pais_id)
VALUES 	(1, 'Fernando Omar',3),
		(2, 'Julian Conte',3),
        (3, 'Nicolas Mariano',1),
        (4, 'Laura Grisel',2),
        (5, 'Constantino Pascual',4);

### ON UPDATE CASCADE

## AGREGAMOS CONSTRAINT
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON UPDATE CASCADE;

UPDATE pais 
SET pais_id=10
WHERE nombre_pais = 'Argentina';

SELECT * FROM pais;
SELECT * FROM personas;

ALTER TABLE personas
DROP CONSTRAINT FK_PERSONAS_PAIS;


### ON UPDATE RESTRICT / NO ACTION

## AGREGAMOS CONSTRAINT
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON UPDATE NO ACTION;

UPDATE pais 
SET pais_id=3
WHERE nombre_pais = 'Argentina';

## PROBAMOS CON RESTRICT
ALTER TABLE personas
DROP CONSTRAINT FK_PERSONAS_PAIS;
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON UPDATE RESTRICT;

UPDATE pais 
SET pais_id=3
WHERE nombre_pais = 'Argentina';

## CONSECUENCIA CON LOS DOS TENEMOS EL MISMO ERROR

ALTER TABLE personas
DROP CONSTRAINT FK_PERSONAS_PAIS;


### ON UPDATE SET NULL

## AGREGAMOS CONSTRAINT
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON UPDATE SET NULL;

UPDATE pais 
SET pais_id=3
WHERE nombre_pais = 'Argentina';

SELECT * FROM pais;
SELECT * FROM personas;

## CONSECUENCIAS: SE ELIMINO A ARGENTINA DE LA TABLA PERSONAS, LAS REFERENCIAS A ESE REGISTRO EN LA OTRA TABLA FUERON REEMPLAZADAS POR NULL

ALTER TABLE personas
DROP CONSTRAINT FK_PERSONAS_PAIS;

#### OTROS EJEMPLOS

### QUE PASA SI DEFINIMOS ON UPDATE Y ON DELETE?

## CREAMOS TABLAS DE EJEMPLO
CREATE TABLE pais (
pais_id INT PRIMARY KEY,
nombre_pais VARCHAR(50) 
);

CREATE TABLE personas (
persona_id INT PRIMARY KEY,
nombre_completo VARCHAR(60),
pais_id INT);

## INSERTAMOS VALORES
INSERT INTO PAIS (pais_id,nombre_pais)
VALUES 	(1, 'España'),
		(2, 'Italia'),
        (3, 'Argentina'),
        (4, 'Albania'),
        (5, 'Brasil');
        
INSERT INTO PERSONAS (persona_id,nombre_completo, pais_id)
VALUES 	(1, 'Fernando Omar',3),
		(2, 'Julian Conte',3),
        (3, 'Nicolas Mariano',1),
        (4, 'Laura Grisel',2),
        (5, 'Constantino Pascual',4);

### ON UPDATE CASCADE

## AGREGAMOS CONSTRAINT
ALTER TABLE personas
ADD CONSTRAINT FK_PERSONAS_PAIS FOREIGN KEY (pais_id) REFERENCES PAIS(pais_id) ON DELETE SET NULL ON UPDATE CASCADE;

SELECT * FROM pais;
SELECT * FROM personas;

UPDATE pais 
SET pais_id=10
WHERE nombre_pais = 'Argentina';

SELECT * FROM personas;

DELETE FROM pais 
WHERE pais_id = 2;

SELECT * FROM personas;
