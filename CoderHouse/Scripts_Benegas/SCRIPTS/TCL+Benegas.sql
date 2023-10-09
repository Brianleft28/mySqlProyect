set @@autocommit = 0;

#Borro autos donde el id sea menos o igual a 54 de la tabla used cars
#luego rehago la sentencia delete con rollback, y luego lo ejecuto en el motor con commit

START transaction;

	DELETE from used_cars 
	where id_Car <= 54;

ROLLBACK; 
COMMIT;

#INSERTO OCHO REGISTROS EN LA TABLA COMMENT_DET CON UN SP QUE CREE EN LAS CLASES, 
#LUEGO LOS BORRO CON UN ROLLBACK TO SAVEPOINT 0 YA QUE NO EXISTEN LOS AUTOS A LOS QUE REFERENCIA


START TRANSACTION;
#1 dato
CALL ingresar_commentDet('102', 'ASJ456', 'No tiene ruedas');
#2 dato
CALL ingresar_commentDet('103','HFD548','Detalle en la pintura');
#3 dato 
CALL ingresar_commentDet('104','BDF845','Dobla un poco mal');
#4 dato	
CALL ingresar_commentDet('105','ASA848','Mancha en el parabrisas');

SAVEPOINT cuarto_dato; 

#5 dato
CALL ingresar_commentDet('106','XAS878','No abre la puerta izquierda');
#6 dato
CALL ingresar_commentDet('107','LOL555','No funciona bien el embrague');
#7 dato 
CALL ingresar_commentDet('108','DFH585','No anda el acelerador');
#8 dato 
CALL ingresar_commentDet('109','GDF548','Las puertas no tienen ventanas');

SAVEPOINT octavo_dato;

#release savepoint cuarto_dato;
select * from comment_det;

COMMIT;

#ejecutar la siguiente sentencia para deshacer los registros.

START transaction;
DELETE FROM COMMENT_DET 
WHERE ID_CAR >= 102;
select * from comment_det;
commit;

