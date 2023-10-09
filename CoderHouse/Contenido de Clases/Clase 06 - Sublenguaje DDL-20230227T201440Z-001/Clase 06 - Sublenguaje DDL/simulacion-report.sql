### REPORTE: PARTE 1

#Vemos tablas utiles:
SELECT *
FROM system_user;
SELECT * 
FROM play;

# Intentamos agrupar todo por jugador
SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user;
#Que pasa si ponemos el numero de columna?
SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY 1;
#Analisis de consistencia de datos: Tiene sentido que haya mas juegos completados que jugados? 
SELECT id_system_user,
COUNT(*) as jugados,
SUM(completed) as completados
FROM play
GROUP BY id_system_user
HAVING completados>jugados;
SELECT DISTINCT completed
FROM play;

### REPORTE: PARTE 2
## Juntamos esa informacion con la tabla de usuarios:

########################################## TABLA 1 ######################################
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
########################################## TABLA 1 ######################################

## Agregamos ranking y limpiamos nombres, ordenamos y limitamos
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

### REPORTE: PARTE 3

##COMPLETAMOS PUNTO 1, GUARDANDO LOS RESULTAODS EN UNA TABLA Y GENERANDO QUERY CON PROMEDIOS
CREATE TABLE reporte_player
#query que creamos antes para tabla 1
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

SELECT * FROM reporte_player;
#Query con promedios
SELECT avg(jugados) as promedio_juados,
avg(completados) as promedio_completados
FROM reporte_player;

# Tabla de cohorts por user_type

SELECT id_user_type,count(*) as type_jugadores,
sum(jugados) as type_jugados_total,
sum(completados) as type_completados_total,
AVG(jugados) as type_jugados_promedio
FROM reporte_player
GROUP BY id_user_type
HAVING type_jugadores>3
ORDER BY type_jugados_promedio DESC
LIMIT 2;


