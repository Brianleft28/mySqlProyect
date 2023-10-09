SET SQL_SAFE_UPDATES = 0;

# creamos una tabla con la disponibilidad de stock de autos nuevos y usados # 

create table inventory
select id_car, cod_car, name_model
from new_cars
union
select id_car, cod_car, name_model
from used_cars;


ALTER TABLE inventory ADD PRIMARY KEY (id_car);

ALTER TABLE new_cars 
ADD constraint INVENTORY_NEWCARS foreign key(id_car) REFERENCES inventory (id_car);

ALTER TABLE inventory add column available VARCHAR (40);

ALTER TABLE used_cars
ADD CONSTRAINT INVENTORY_USEDCARS foreign key(id_car) references inventory (id_car);

ALTER TABLE inventory 
DROP COLUMN cod_car;

# actualizamos los valores de la disponibilidad de autos nuevos y usados #

UPDATE inventory 
SET available = 20
WHERE id_car  < 50;

UPDATE inventory
SET available = 1 
where id_car >= 50;

select * from inventory;
select * from new_cars;
select * from used_cars;
select * from payments;


#"payments" es la tabla que contiene informacion de la venta de automóviles e "inventario" es la tabla que contiene el stock de automóviles. 
#La columna "available" en la tabla "inventory" se actualiza con el número total de automóviles vendidos que correspondan para ese modelo.
#Este trigger se activará después de cada actualización en la tabla "payments" y contará el número de automóviles disponibles para ese modelo en particular. 
#Luego, actualizará la columna "available" en la tabla "inventory" con el número de automóviles disponibles calculado.

DELIMITER $$
CREATE TRIGGER update_available_cars
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
  UPDATE inventory 
		SET available = available - 1
WHERE id_car = NEW.id_car;
END $$
DELIMITER ;

INSERT into payments Values (101, 72, '2022-12-12', 3000000, 23);    

#Este trigger se activa antes de cada venta y verifica que haya suficientes vehículos en el inventario para realizar la venta#
#Si no hay suficientes vehículos, el trigger lanza un error y la venta no se realiza.#

DELIMITER $$
CREATE TRIGGER validar_stockCars
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
	DECLARE cantidad_actual INT;
    SELECT available INTO cantidad_actual FROM inventory
    WHERE id_car = NEW.id_car;
IF 
	cantidad_actual = 0 then
	SIGNAL sqlstate '45000' SET MESSAGE_TEXT = 'No hay vehiculos disponible para continuar la compra'
    ;
END IF;
END $$
DELIMITER ;

INSERT into payments Values  (102, 13, '2022-12-13', 250000, 72);    
INSERT into payments Values (102, 13, '2022-12-13', 250000, 72);    

#1 chequeamos si el choche 72 aparece en la tabla payments (el primero) 
#2 luego si esta disponible en la tabla inventory
#como vemos el mensaje de error se mostro correctamente porque luego de la primer compra, tenemos 0 coches con id_car = 72#

select * from payments;
select * from inventory;

#Por ultimo, este TRIGGER nos dira que compra se insertó, que usario la insertó y cuando (Hora y fecha en columnas separadas)#
#Voy a crear una tabla que se llame LogPayments, será la tabla donde se almacena la info#

Create table LogPayments (id_payments VARCHAR(40), user VARCHAR (40), fecha date, hora timestamp);

DELIMITER $$
CREATE TRIGGER LogPayments 
AFTER INSERT ON payments 
FOR EACH ROW
BEGIN
 INSERT INTO LogPayments Values (New.id_payments, USER(), CURDATE(), CURTIME());
END $$
DELIMITER ;

drop trigger LogPayments;

#Lo probamos
select * from payments;
INSERT into payments Values  (103, 54, '2022-12-14', 545000, 1);    
INSERT into payments Values  (104, 13, '2022-12-14', 212000, 4);    

select * from LogPayments;

# No puedo hacer que la hora me quede sin la fecha # 