									#############################################################
					
														#BENEGAS_BRIAN#
   
							
									#############################################################

CREATE SCHEMA concesionarioBenegas;

USE concesionarioBenegas;

##########################################################  TABLAS ##################################################################################

#TABLA DE CLIENTES#

CREATE TABLE customers 
(
	id_client INT auto_increment NOT NULL,
	cod_client 	VARCHAR (50) NOT NUll,
	first_name VARCHAR (25) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	dni VARCHAR (20) NOT NULL,
    adress VARCHAR (40) NOT NULL,
    phone VARCHAR (40) NOT NULL,
    client_email VARCHAR (80) NOT NULL,
    city_client VARCHAR (50) NOT NULL,
    postal_code VARCHAR (20) NOT NULL,
    PRIMARY KEY (id_client)
);

#TABLA DE PAGOS#####

CREATE TABLE payments 
(
	id_payments INT NOT NULL auto_increment,
    id_client INT NOT NULL,
    cod_client INT NOT NULL,
    cod_car INT NOT NULL,
    date_payment DATE NOT NULL,
    Value_model INT NOT NULL,
    metodo_de_pago VARCHAR (25) NOT NULL,
	PRIMARY KEY pagos (id_payments)
);

#TABLA DE DETALLES DE PAGO###

CREATE TABLE payments_datails	
(	
	id_payments INT NOT NULL auto_increment, 
	cod_client INT NOT NULL,
	id_client INT NOT NULL,
    cod_car INT NOT NULL,
    date_membership DATE NOT NULL,
    spot BOOLEAN,
    financing BOOLEAN,
    cuotas INT,
    PRIMARY KEY (id_payments)
);

#TABLA DE PROVEEDORES###

CREATE TABLE suppliers
(	
	id_supplier INT NOT NULL AUTO_INCREMENT,
	cod_car INT NOT NULL,
    name_model VARCHAR (50) NOT NULL,
    date_model DATE NOT NULL,
	color_model VARCHAR (30)NOT NULL,
    value_model_factory INT not null,
    adress VARCHAR(50),
    primary key (id_supplier)
);

#TABLA DE AUTOS 0-KM###
CREATE TABLE new_cars 	
( 
	id_car INT AUTO_INCREMENT NOT NULL,
    cod_car INT NOT NULL,
    name_model VARCHAR (40) NOT NULL,
    date_model DATE NOT NULL,
    color_model VARCHAR (20) NOT NULL,
    value_model int NOT NULL,
    PRIMARY KEY (id_car)
);

#TABLA DE AUTOS USADOS###
CREATE TABLE used_cars
(
	id_car INT AUTO_INCREMENT NOT NULL,
    cod_car INT NOT NULL,
	name_model VARCHAR (40) NOT NULL,
    date_model DATE NOT NULL,
    color_model VARCHAR (20) NOT NULL,
    value_model int NOT NULL,
    PRIMARY KEY (id_car)
);

#TABLA DE ESTADO AUTOS USADOS####
CREATE TABLE deterioration 
(
	id_car INT AUTO_INCREMENT NOT NULL,
    cod_car INT NOT NULL,
    comment_det VARCHAR (200),
    PRIMARY KEY (id_car)
);

#............................................##################### FK'S #####################...................................................#

ALTER TABLE payments
ADD FOREIGN KEY (id_client) REFERENCES customers (id_client),
ADD foreign key (id_payments) REFERENCES payments_datails (id_payments);

ALTER TABLE payments_datails
ADD FOREIGN KEY  (id_payments) references customers (id_client);

ALTER TABLE suppliers 
ADD FOREIGN KEY (id_supplier) references new_cars (id_car),
ADD FOREIGN KEY (id_supplier) references used_cars (id_car);

ALTER TABLE new_cars
ADD FOREIGN KEY (value_model) references payments (id_payments);

ALTER TABLE used_cars
ADD FOREIGN KEY (value_model) references payments (id_payments);

ALTER TABLE deterioration
ADD FOREIGN KEY (id_car) references used_cars (id_car);

################################################INSERTANDO ALGUNOS DATOS############################################################################


INSERT INTO customers (cod_client, first_name, last_name, dni, adress, phone, client_email, city_client, postal_code)
	VALUES (
	'VIP' 'Pedro' 'Alfonso' '42520201' 'Haiti 2334' '5432125333' 'alonso2134@gmail.com' 'Buenos Aires' '1714'
	);
    
    ####Error: 1136: Column count doesn't match value count at row 1####