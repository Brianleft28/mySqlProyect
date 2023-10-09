### PROCEDIMIENTOS 'S.P' ###
SET sql_safe_updates=0;
#CREO UN PROCEDIMIENTO PARA ORDENAR LOS VALORES DE LOS AUTOS NUEVOS SEGUN SU ACCESIBILIDAD#

# SI EL VALOR INGRESADO SE ENCUENTRA ENTRE LOS VALORES DE LA TABLA NEW_CARS (VALOR MINIMO 606355) NOS MOSTRATARÁ LOS DATOS #
									#CASO CONTRARIO NOS TIRARÁ UN ERROR#

DELIMITER $$
CREATE PROCEDURE sp_ordenamientoValor_newcars (IN valor INT)
BEGIN
CASE WHEN  valor >= 606355 THEN 
SELECT name_model, value_model,
CASE 
WHEN value_model > 800000 then 'caro'
WHEN value_model < 800000 AND  value_model > 700000 then 'valor intermedio'
ELSE 'accesible' END AS ACCESIBILIDAD_NEWCARS
FROM new_cars
order by 2;
ELSE select 'El valor no esta en la tabla NEW_CARS' AS ERROR;
END CASE;
END $$
DELIMITER ;

# EL VALOR MINIMO NOS TRAERA LA TABLA #
#CALL sp_ordenamientoValor_newcars (606355);

# SI ES MENOR NOS SALDRA ERROR #
#CALL sp_ordenamientoValor_newcars (606354);
	
	#Voy a crear una igual pero para tabla used_cars#

DELIMITER $$
CREATE PROCEDURE sp_ordenamientoValor_usedcars (IN valor INT)
BEGIN
CASE WHEN  valor >= 315676 THEN 
SELECT name_model, value_model,
CASE 
WHEN value_model > 500000 then 'caro'
WHEN value_model > 410000 then 'valor intermedio'
WHEN value_model < 410000 and value_model > 320000 then 'valor intermedio-economico'
ELSE 'accesible' END AS ACCESIBILIDAD_USEDCARS
FROM used_cars
order by 2;
ELSE select 'El valor no esta en la tabla USED_CARS' AS ERROR;
END CASE;
END $$
DELIMITER ;

#CALL sp_ordenamientoValor_usedcars (320000);

			##################################################################
			################### SP PARA INGRESAR DATOS #######################
			##################################################################
#PRIMERO VOY A HACER UN SP PARA SUPPLIERS, LUEGO PARA INRESAR EL AUTOS USADO, Y LUEGO UNA PARA INGRESAR COMENTARIOS SOBRE EL MISMO#
# SP PARA EL SUPPLIER #

DELIMITER $$
CREATE PROCEDURE ingresar_Usedcar_SUPPLIER (IN id_car INT, IN cod_car VARCHAR(40), IN name_supplier VARCHAR(40), IN value_model_factory INT, 
											IN adress VARCHAR(50))
BEGIN

INSERT INTO suppliers (id_car, cod_car, name_supplier, value_model_factory, adress) VALUES  
								(id_car, cod_car, name_supplier, value_model_factory, adress);

END $$
DELIMITER ;

CALL ingresar_Usedcar_SUPPLIER (101, 'SOY312', 'Used Cars Company', '600000' , 'Miranda 8545');

####SP DE COMENTARIOS SOBRE EL AUTO USADO###

DELIMITER $$
CREATE PROCEDURE ingresar_commentDet (IN id_car INT, IN cod_car VARCHAR(40), IN comment_det VARCHAR(200))
BEGIN

INSERT INTO comment_det (id_car, cod_car, comment_det) VALUES  (id_car, cod_car, comment_det);

END $$
DELIMITER ;

######## sp para ingresar el auto #########


DELIMITER $$
CREATE PROCEDURE ingresar_Usedcar (IN id_car INT, IN cod_car VARCHAR(40), name_model VARCHAR(40), date_model DATE, 
									color_model VARCHAR(20), IN value_model INT)
BEGIN

INSERT INTO used_cars (id_car, cod_car, name_model, date_model, color_model, value_model) VALUES  
								(id_car, cod_car, name_model, date_model, color_model, value_model);

END $$
DELIMITER ;

#ingresamos los datos: 

CALL ingresar_commentDet(101, 'SOY312','No tiene stereo');
CALL ingresar_Usedcar_SUPPLIER (101, 'SOY312', 'Used Cars Company', '600000' , 'Miranda 8545');
CALL ingresar_Usedcar (101, 'SOY312', 'Ford Falcon', '1982-04-25', 'Verde', 510000);

select * from used_cars;
select * from suppliers;
select * from comment_det;

select * from valor_de_fabricanewcars;
