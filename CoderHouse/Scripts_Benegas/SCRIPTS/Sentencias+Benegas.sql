use mysql;

# DEFINO DOS USUARIOS CON LA SENTENCIA 'CREATE USER, Y CON 'IDENTIFIED BY' les definire una constraseña. 

CREATE USER 'brian'@'localhost' identified BY 'CONTRASENIA1';

CREATE USER 'brian2'@'localhost' identified BY 'CONTRASENIA'; #Defino un primer usuario y su contraseña 

ALTER USER 'brian2'@'localhost' identified BY 'CONTRASENIA2'; #Modifico la contraseña del primer usuario 


#Chequeamos los permisos por defecto de los nuevos usuarios
SELECT * FROM USER 
WHERE user LIKE 'brian%'; 							

#EN ESTA SENTENCIA, OTORGAMOS AL USUARIO 'brian2' permisos de lectura sobre todas las tablas
GRANT SELECT ON *.* to 'brian2'@'localhost';

#Lo verificamos:
SELECT * FROM USER 
WHERE user LIKE 'brian2'; 

#Y ahora le otorgaremos los permisos de lectura, inserción y modificación de datos al usuario 'brian'
GRANT SELECT, UPDATE, INSERT ON *.* TO 'brian'@'localhost';

# Chequeamos los nuevos permisos: 

SELECT * FROM USER 
WHERE user LIKE 'brian'; 

SELECT * FROM USER;




# El usuario 'brian2' cuenta con todos los permisos a nuestras base de datos.
 
 





