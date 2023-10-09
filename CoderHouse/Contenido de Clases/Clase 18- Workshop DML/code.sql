#### WORKSHOP 2 
SET SQL_SAFE_UPDATES = 0;

### 1) AGREGAMOS VIEWES Y FUNCIONES A LA BASE DE DATOS

## VISTA DE TOP 10 POKEMON SEGUN SUS STATS
CREATE VIEW `top_10_view_by_stats` AS 
select * FROM pokemon a
LEFT JOIN base_stats b on a.pok_id=b.pok_id
LIMIT 10;

SELECT * FROM top_10_view_by_stats;

##Creamos una mejor funcion para calcular el valor de cada Pokemon

CREATE FUNCTION stat_ratio (b_atk INT,b_def INT,b_sp_atk INT,b_sp_def INT,b_speed INT)
RETURNS VARCHAR(40)
DETERMINISTIC
RETURN (
	(b_atk+b_sp_atk)/(b_def+b_sp_def)*b_speed);

## Hacemos una view en base a esta funcion

CREATE VIEW `top_10_view_by_stats_ratio` AS 
select a.pok_id,pok_name, stat_ratio(b_atk,b_def,b_sp_atk,b_sp_def,b_speed) as stat_ratio
FROM pokemon a
LEFT JOIN base_stats b on a.pok_id=b.pok_id
ORDER BY 3 DESC
LIMIT 10;

## CREAMOS UN TRIGGER POR SI SE INSERTAN NUEVOS POKEMON CON MALA INFORMACION
DELIMITER //
CREATE TRIGGER NEW_POKEMON 
BEFORE INSERT ON POKEMON
FOR EACH ROW 
BEGIN 
	IF NEW.pok_height < 0 THEN
		SET NEW.pok_height = 0;
	END IF;
	IF NEW.pok_weight < 0 THEN
		SET NEW.pok_weight = 0;
	END IF;
	IF NEW.pok_base_experience < 0 THEN
		SET NEW.pok_base_experience = 0;
	END IF; 
	END //
DELIMITER ;

#IMAGNEMOS QUE SE HIZO UN INSERT, Y TENEMOS UNA FILA INCOMPLETA

SELECT * FROM pokemon;

## ACTUALIZAMOS EL POKEMON YA CREADO
UPDATE pokemon
SET pok_height=30,pok_weight=80,pok_base_experience=270
WHERE pok_id=722;


## CREAR PROCEDIMIENTO QUE NOS DIGA SI HAY INCONSISTENCIAS

#CREAMOS TABLA
CREATE TABLE database_status (timestamp timestamp, errores_base_stats INT,errores_pokemon_moves INT, errores_pokemon_types INT, errores_evolution_matchup INT);

#CREAMOS PROCEDIMIENTO
DELIMITER //
CREATE PROCEDURE database_control ()
BEGIN
INSERT INTO database_status
SELECT CURRENT_TIMESTAMP(),SUM(errores_base_stats),sum(errores_pokemon_moves),sum(errores_pokemon_types),sum(errores_evolution_matchup)
FROM
	(SELECT a.pok_id,
	CASE WHEN b.pok_id IS NULL THEN 1 ELSE 0 END as errores_base_stats,
	CASE WHEN c.pok_id IS NULL THEN 1 ELSE 0 END as errores_pokemon_moves,
	CASE WHEN d.pok_id IS NULL THEN 1 ELSE 0 END as errores_pokemon_types,
	CASE WHEN e.pok_id IS NULL THEN 1 ELSE 0 END as errores_evolution_matchup
	FROM pokemon a
	LEFT JOIN base_stats b ON a.pok_id=b.pok_id
	LEFT JOIN pokemon_moves c ON a.pok_id=c.pok_id
	LEFT JOIN pokemon_types d ON a.pok_id=d.pok_id
	LEFT JOIN pokemon_evolution_matchup e ON a.pok_id=e.pok_id
	WHERE b.pok_id IS NULL OR c.pok_id IS NULL OR d.pok_id IS NULL OR e.pok_id IS NULL) a;
END //
DELIMITER ;

#TESTEAMOS EL PROCEDIMIENTO 
CALL database_control;

select * from pokemon;


## Agregamos un trigger a ese procedimiento
DELIMITER $$
CREATE TRIGGER new_pokemon_check
AFTER INSERT ON pokemon
FOR EACH ROW
BEGIN
	CALL database_control;
END $$
DELIMITER ;

## Hacemos import de data, height y weight x10


## Testeamos
SELECT * FROM database_status;

SELECT * FROM database_status
ORDER BY timestamp DESC
LIMIT 1;

