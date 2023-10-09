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
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	dni VARCHAR (20) NOT NULL,
    adress VARCHAR (40) NOT NULL,
	client_email VARCHAR (80) NOT NULL,
	phone  varchar (80)NOT NULL,
    city_client VARCHAR (50) NOT NULL,
    postal_code int NOT NULL,
    PRIMARY KEY (id_client)
);

#TABLA DE PAGOS#####

CREATE TABLE payments 
(
	id_payments INT auto_increment NOT NULL,
    id_client INT NOT NULL,
    date_membership DATE NOT NULL,
    Value_model INT,
	id_car INT NOT NULL,
	PRIMARY KEY (id_payments)
);

#TABLA DE DETALLES DE PAGO###

CREATE TABLE payments_datails	
(	
	id_payments INT NOT NULL auto_increment,
    id_car INT not null,
	id_client INT NOT NULL,
    date_payment date,
    cuotas INT,
	metodo_de_pago VARCHAR (25) NOT NULL,
    PRIMARY KEY (id_payments)
);

#TABLA DE PROVEEDORES###

CREATE TABLE suppliers
(	
	id_car INT NOT NULL AUTO_INCREMENT,
	cod_car VARCHAR(40) NOT NULL,
    name_supplier VARCHAR(40),
    value_model_factory INT,
    adress VARCHAR(50),
    primary key (id_car)
);

#TABLA DE AUTOS 0-KM###
CREATE TABLE new_cars 	
( 
	id_car INT AUTO_INCREMENT NOT NULL,
    cod_car VARCHAR (40) NOT NULL,
    name_model VARCHAR (40) NOT NULL,
    date_model date NOT NULL,
    color_model VARCHAR (40) NOT NULL,
    value_model int NOT NULL,
    PRIMARY KEY (id_car)
);

#TABLA DE AUTOS USADOS###
CREATE TABLE used_cars
(
	id_car INT AUTO_INCREMENT NOT NULL,
    cod_car varchar(40) NOT NULL,
	name_model VARCHAR (40) NOT NULL,
    date_model DATE NOT NULL,
    color_model VARCHAR (20) NOT NULL,
    value_model int NOT NULL,
    PRIMARY KEY (id_car)
);

#TABLA DE ESTADO AUTOS USADOS####
CREATE TABLE comment_det 
(
	id_car INT AUTO_INCREMENT NOT NULL,
    cod_car varchar (40) NOT NULL,
    comment_det VARCHAR (200),
    PRIMARY KEY (id_car)
);

################################################INSERTANDO  DATOS############################################################################

		
					#### insertando valores con importanciones: FORMATO CSV ###
    select * from customers;                
	select * from suppliers;						
    select * from new_cars;
    select * from comment_det;
    select * from used_cars;
	select * from payments_datails;
    select * from payments;
    
#-----------------------------------------------------------------------------------------------------------------------------------#
#............................................##################### FK'S #####################.................................................#

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE payments
ADD constraint payments_customers_fk
FOREIGN KEY (id_client) REFERENCES customers (id_client)  on update cascade on delete cascade,
ADD constraint	payments_paymentsdetails_fk
foreign key (id_payments) REFERENCES payments_datails (id_payments)on update cascade on delete cascade;

ALTER TABLE payments_datails
ADD constraint paymentsdetails_customers_fk
FOREIGN KEY  (id_client) references customers (id_client)on update cascade on delete cascade;

ALTER TABLE used_cars
ADD CONSTRAINT supplier_usedcars_fk
FOREIGN KEY (id_car) references suppliers (id_car) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT usedcars_deterioration_fk
FOREIGN KEY (id_car) references comment_det (id_car) on update cascade on delete cascade;

ALTER TABLE new_cars
ADD CONSTRAINT supplier_newcars_fk
FOREIGN KEY (id_car) references suppliers (id_car) ON UPDATE CASCADE ON DELETE CASCADE;
###############################################################################################################################################

