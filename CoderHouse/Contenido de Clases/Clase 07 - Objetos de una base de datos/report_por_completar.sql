### REPORTE: PARTE 1 CREAMOS LAS TABLAS

#QUery del punto 1
SELECT a.id_system_user,
id_user_type,
first_name,
last_name,
jugados,
completados
FROM system_user a
LEFT JOIN (SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user) b ON a.id_system_user=b.id_system_user;

SELECT a.id_system_user,
first_name,
last_name,
id_user_type,
jugados,
completados
FROM system_user as a
LEFT JOIN (SELECT id_system_user,
COUNT(*) as jugados, 
SUM(completed) as completados  
FROM play 
GROUP BY id_system_user) as b ON a.id_system_user=b.id_system_user;

##COMPLETAMOS PUNTO 3, GUARDANDO LOS RESULTAODS DEL PRIMER PUNTO, EN UNA TABLA llamada reporte_player

CREATE TABLE reporte_player
SELECT a.id_system_user,
first_name,
last_name,
id_user_type,
jugados,
completados
FROM system_user as a
LEFT JOIN (SELECT id_system_user,
COUNT(*) as jugados, 
SUM(completed) as completados  
FROM play 
GROUP BY id_system_user) as b ON a.id_system_user=b.id_system_user;

#Query con promedios

SELECT AVG(jugados) as jugados, 
	   AVG(completados) as completados
FROM report_player;



### REPORT PARTE 2: CREAMOS LA FUNCION HIDE_PII_STR






        
### REPORTE PARTE 3: CREAMOS LA VISTA TOMANDO EL PUNTO 2 DE LA CLASE PASADA

#Lo que hicimos la clase pasada
SELECT a.id_system_user,id_user_type,
CONCAT(CONCAT(last_name,', '),first_name) as complete_name,
jugados,
completados,
completados/jugados as proportion,
2*jugados+completados as ranking
FROM system_user a
LEFT JOIN (SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user) b ON a.id_system_user=b.id_system_user
ORDER BY ranking DESC, proportion DESC
LIMIT 10;

## CREAMOS VISTA, AGREGAMOS COLUMNAS PERSONALES PERO LAS TAPAMOS CON LA FUNCION










## CON ESTO TERMINAMOS EL PUNTO 4 DEL REPORTE

### REPORTE PARTE 4: CREAMOS UNA NUEVA VISTA TOMANDO EL PUNTO 3, PERO LE AGREGAMOS UN LIMITE FLEXIBLE
 


