USE concesionariobenegas;
 
DELIMITER $$
CREATE FUNCTION valor_de_fabrica (Valor_concesionario INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE valor_de_fabrica INT;
    SET valor_de_fabrica = ((valor_concesionario) - ((valor_consesionario)/10));
RETURN valor_de_fabrica;
END$$
 DELIMITER ;


DELIMITER $$
CREATE FUNCTION NOMBRE_COMPLETO (FIRST_NAME VARCHAR(100), LAST_NAME VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	DECLARE COMPLETED_NAME varchar(100);
    SET COMPLETED_NAME = concat(LAST_NAME, ' ', FIRST_NAME);
RETURN COMPLETED_NAME;
END$$
DELIMITER ;



create view valor_de_fabricaNEWCARS as
select name_model, valor_de_fabrica(value_model)
from new_cars;

create view valor_de_fabricaUSEDCARS as
select name_model, valor_de_fabrica(value_model)
from used_cars;

select id_client, NOMBRE_COMPLETO(first_name, last_name) AS completed_name
from customers;





