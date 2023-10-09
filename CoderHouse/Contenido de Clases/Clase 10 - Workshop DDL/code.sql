CREATE schema pokemon_test;
USE pokemon_test;

### CODE PARTE 1: CREAMOS LAS TABLAS SIN LAS CONEXIONES

CREATE TABLE pokemon (
poke_id INT NOT NULL,
pok_name VARCHAR(30) NOT NULL,
pok_height INT NOT NULL,
pok_weight INT NOT NULL,
pok_base_experience INT NOT NULL
);

CREATE TABLE videogames (
game_id INT NOT NULL,
game_date DATE NOT NULL,
game_name VARCHAR(30) NOT NULL,
game_sales INT NOT NULL
);
CREATE TABLE types (
type_id INT NOT NULL,
type_name VARCHAR(20) NOT NULL,
game_id VARCHAR(20) NOT NULL);

CREATE TABLE moves (
move_id INT NOT NULL,
move_name VARCHAR(30) NOT NULL,
type_id INT NOT NULL,
move_power INT NOT NULL
);

CREATE TABLE pokemon_moves (
poke_id INT NOT NULL,
move_id INT NOT NULL,
level INT NOT NULL
);

## VEMOS EL DIAGRMAA DE ENTIDAD-RELACION

DROP schema pokemon_test;
CREATE schema pokemon_test;
USE pokemon_test;
### CODE PARTE 2: CREAMOS LAS TABLAS CON LAS CONEXIONES

CREATE TABLE pokemon (
poke_id INT NOT NULL,
pok_name VARCHAR(30) NOT NULL,
pok_height INT NOT NULL,
pok_weight INT NOT NULL,
pok_base_experience INT NOT NULL,
PRIMARY KEY (poke_id)
);

CREATE TABLE videogames (
game_id INT NOT NULL,
game_date DATE NOT NULL,
game_name VARCHAR(30) NOT NULL,
game_sales INT NOT NULL,
PRIMARY KEY (game_id)
);

### ERROR COMUN: LOS TIPOS NO SON COMPATIBLES
CREATE TABLE types (
type_id INT NOT NULL,
type_name VARCHAR(20) NOT NULL,
game_id VARCHAR(20) NOT NULL,
PRIMARY KEY (type_id),
FOREIGN KEY(game_id) REFERENCES videogames(game_id));

CREATE TABLE moves (
move_id INT NOT NULL,
move_name VARCHAR(30) NOT NULL,
type_id INT NOT NULL,
move_power INT NOT NULL,
PRIMARY KEY (move_id),
FOREIGN KEY(type_id) REFERENCES types(type_id));

CREATE TABLE pokemon_moves (
poke_id INT NOT NULL,
move_id INT NOT NULL,
level INT NOT NULL,
FOREIGN KEY(poke_id) REFERENCES pokemon(poke_id),
FOREIGN KEY(move_id) REFERENCES moves(move_id)
);

## VEMOS EL NUEVO DIAGRAMA

## DUDA: COMO HAGO SI QUIERO QUE UNA TABLA TENGA UNA PRIMARY KEY COMPUESTA?

DROP TABLE pokemon_moves;

CREATE TABLE pokemon_moves (
poke_id INT NOT NULL,
move_id INT NOT NULL,
level INT NOT NULL,
PRIMARY KEY (poke_id,move_id)
);

DROP schema pokemon_test;
