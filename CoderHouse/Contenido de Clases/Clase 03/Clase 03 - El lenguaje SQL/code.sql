################################ PARTE 1 ##############################
### Ejemplos basicos
# CONSULTAR TODOS LOS CAMPOS DE UNA TABLA
SELECT *
FROM class;
#CONSULTAR DETERMINADOS CAMPOS DE UNA TABLA
SELECT id_class, description 
FROM class;
#CONSULTAR LOS MISMOS CAMPOS EN DISTINTO ORDEN
SELECT description,id_class
FROM class;

### CONSIDERACIONES DE SINTAXIS
# LAS CONSULTAS NO SON SENSIBLES A LAS MAYUSCULAS O MINUSCULAS
select DESCRIPTION,ID_CLASS
from CLASS;
### POSIBLES PROBLEMAS
#ERROR: ESCRIBIR INCORRECTAMENTE EL NOMBRE DE UNA TABLA/COLUMNA
select id_lvel
from CLASS;
#ERROR: NO PONER PUNTO Y COMA EN EL FIN DE LA CONSULTA
select *
from CLASS;
#PROBLEMA DE CONCEPTO: NO ESTRUCTURAR LA QUERY CORRECTAMENTE PARA QUE OTROS LA LEAN
SELECT * FROM class;

################################ PARTE 2 #############################
#### Ejemplo de SELECT con DISTINCT
# 1000 rows returned
SELECT first_name 
FROM system_user;
#954 rows returned
SELECT DISTINCT first_name 
FROM system_user;
#1000 rows returned
SELECT DISTINCT first_name,last_name
FROM system_user;

################################ PARTE 3 #############################
##EJEMPLOS PRACTICOS
# EJEMPLO 1
SELECT * 
FROM system_user 
WHERE first_name="Gillie";
# EJEMPLO 2
SELECT first_name, last_name 
FROM system_user 
WHERE id_user_type = 334;
# EJEMPLO 3
SELECT first_name, last_name 
FROM system_user 
WHERE id_system_user = 56;
# EJEMPLO 4
 
