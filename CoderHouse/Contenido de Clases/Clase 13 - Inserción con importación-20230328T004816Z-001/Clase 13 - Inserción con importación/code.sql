#### CODE PARTE 1: STACK

#### CODE PARTE 2: CONSOLA

CREATE TABLE productos (
id int NOT NULL AUTO_INCREMENT, 
nombre varchar(40) NOT NULL, 
existencia int NOT NULL 
           DEFAULT '0', 
precio float NOT NULL 
       DEFAULT '0', 
precio_compra float NOT NULL 
       DEFAULT '0', 
PRIMARY KEY (id)
);

# \connect root@localhost:3306
#\sql
show databases;
use gammers_model;
show tables;
explain productos;
SELECT * FROM productos;


#### CODE PARTE 3: IMPORTACION POR FILE

load data local infile
'/Users/Cereghetti/Desktop/productos.csv'
into table productos
fields terminated by ','
terminated by '\r\n';

SET GLOBAL LOCAL_INFILE=1;