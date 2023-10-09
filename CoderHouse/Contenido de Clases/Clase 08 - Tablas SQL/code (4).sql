### WORKBENCH PARTE 1: Exploracion
#Ver Table inspector,
#Ver arbol de navegacion
#Ver propiedades de tabla

### CODE PARTE 1:A Tablas transaccionales
USE classicmodels;
#Analizamos posibles transaccionales
SELECT *
FROM orders;

SELECT *
FROM payments;

##CASO CLASICO DE LA VIDA REAL: UNA ORDERS COMPLETA Y NO TAN BIEN OPTIMIZADA COMO LA DEL EJEMPLO
SELECT * 
FROM orders;
#LEFT JOIN ?? Con que creen que se va a unir? Como?


### CODE PARTE 1:B  TABLAS DE HECHO
#Aca no tenemos un ejemplo que me guste mucho. Podria ser la orders tambien, 
#pero me parece que seria una forma procesada de la orders, como la siguiente:

SELECT 
a.customerNumber,
DATE_FORMAT(fecha_cohort,'%Y%m') as cohort,
DATE_FORMAT(paymentDate,'%Y%m') as mes_pagos
FROM payments a
LEFT JOIN (SELECT distinct customerNumber,MIN(paymentDate) as fecha_cohort
			FROM payments
			GROUP BY customerNumber) b on a.customerNumber=b.customerNumber;

### CODE PARTE 1:C  TABLAS DE DIMENSIONALES
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM products;


### WORKBENCH PARTE 2: Ver conexiones de tablas
#VER DDL de Table inspector
#Database > Reverse Engineer > Next > Diagrama E-R



### CODE PARTE 3: TABLAS y sus conexiones
### EJEMPLO 1: DROP TABLE CON DEPENDENCIAS
CREATE SCHEMA sample;
USE sample;

CREATE TABLE troops (
id INT,
description VARCHAR(45),
PRIMARY KEY (id));

CREATE TABLE friend (
id INT,
first_name VARCHAR(30),
last_name VARCHAR(30),
troop INT,
PRIMARY KEY (id),
FOREIGN KEY(troop) REFERENCES troops(id));

INSERT INTO troops (id, description) VALUES
(1,'Vermillion'),
(2, 'Skull');

INSERT INTO friend (id,first_name,last_name, troop) VALUES 
(1, 'Rick', 'Hunter', 2),
(2,'Roy', 'Fokler', 2),
(3,'Max', 'Sterling', 2),
(4,'Kramer', 'Key', 2),
(5, 'Mriya', 'Sterling', 2),
(6,'Ben', 'Dixon', 1);

DROP TABLE troops; #TENEMOS UN ERROR, POR QUE ESTAMOS DROPEANDO LA TABLA FRIEND, QUE ES UNA FOREIGN KEY DE LA TABLA troops
#No podemos dejar a la tabla troop sin la data que esta completando, tenemos que eliminarla primero

DROP TABLE friend;

DROP TABLE troops;

DROP SCHEMA sample;

### EJEMPLO 2: INSERT DATA NO CORRESPONDIDA EN LA SECUNDARIA


CREATE SCHEMA sample;
USE sample;


CREATE TABLE troops (
id INT,
description VARCHAR(45),
PRIMARY KEY (id));

CREATE TABLE friend (
id INT,
first_name VARCHAR(30),
last_name VARCHAR(30),
troop INT,
PRIMARY KEY (id),
FOREIGN KEY(troop) REFERENCES troops(id));

INSERT INTO friend (id,first_name,last_name, troop) VALUES 
(1, 'Rick', 'Hunter', 2),
(2,'Roy', 'Fokler', 2),
(3,'Max', 'Sterling', 2),
(4,'Kramer', 'Key', 2),
(5, 'Mriya', 'Sterling', 2),
(6,'Ben', 'Dixon', 1);

INSERT INTO troops (id, description) VALUES
(1,'Vermillion'),
(2, 'Skull');


DROP SCHEMA sample;