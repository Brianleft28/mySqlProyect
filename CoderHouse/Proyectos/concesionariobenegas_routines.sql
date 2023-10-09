CREATE DATABASE  IF NOT EXISTS `concesionariobenegas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `concesionariobenegas`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: concesionariobenegas
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `comments_usedcarsandvalue`
--

DROP TABLE IF EXISTS `comments_usedcarsandvalue`;
/*!50001 DROP VIEW IF EXISTS `comments_usedcarsandvalue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `comments_usedcarsandvalue` AS SELECT 
 1 AS `MODELO`,
 1 AS `COLOR`,
 1 AS `DETALLE`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `valor_de_fabricanewcars`
--

DROP TABLE IF EXISTS `valor_de_fabricanewcars`;
/*!50001 DROP VIEW IF EXISTS `valor_de_fabricanewcars`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `valor_de_fabricanewcars` AS SELECT 
 1 AS `name_model`,
 1 AS `factory_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `valor_de_fabricausedcars`
--

DROP TABLE IF EXISTS `valor_de_fabricausedcars`;
/*!50001 DROP VIEW IF EXISTS `valor_de_fabricausedcars`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `valor_de_fabricausedcars` AS SELECT 
 1 AS `name_model`,
 1 AS `factory_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `payments_usedcars`
--

DROP TABLE IF EXISTS `payments_usedcars`;
/*!50001 DROP VIEW IF EXISTS `payments_usedcars`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `payments_usedcars` AS SELECT 
 1 AS `id_car`,
 1 AS `cod_car`,
 1 AS `name_model`,
 1 AS `value_model`,
 1 AS `id_client`,
 1 AS `date_membership`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `payments_newcars_info`
--

DROP TABLE IF EXISTS `payments_newcars_info`;
/*!50001 DROP VIEW IF EXISTS `payments_newcars_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `payments_newcars_info` AS SELECT 
 1 AS `id_car`,
 1 AS `cod_car`,
 1 AS `name_model`,
 1 AS `value_model`,
 1 AS `id_client`,
 1 AS `date_membership`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `client_cuotas`
--

DROP TABLE IF EXISTS `client_cuotas`;
/*!50001 DROP VIEW IF EXISTS `client_cuotas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `client_cuotas` AS SELECT 
 1 AS `id_client`,
 1 AS `NombreCompleto`,
 1 AS `MetodoDePago`,
 1 AS `TipoDeCliente`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `detalles_clientes_producto`
--

DROP TABLE IF EXISTS `detalles_clientes_producto`;
/*!50001 DROP VIEW IF EXISTS `detalles_clientes_producto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `detalles_clientes_producto` AS SELECT 
 1 AS `id_client`,
 1 AS `Full_Name`,
 1 AS `date_membership`,
 1 AS `id_car`,
 1 AS `Condition_Car`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `comments_usedcarsandvalue`
--

/*!50001 DROP VIEW IF EXISTS `comments_usedcarsandvalue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `comments_usedcarsandvalue` AS select `a`.`name_model` AS `MODELO`,`a`.`color_model` AS `COLOR`,`b`.`comment_det` AS `DETALLE` from (`used_cars` `a` left join `comment_det` `b` on((`a`.`id_car` = `b`.`id_car`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `valor_de_fabricanewcars`
--

/*!50001 DROP VIEW IF EXISTS `valor_de_fabricanewcars`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `valor_de_fabricanewcars` AS select `new_cars`.`name_model` AS `name_model`,`valor_de_fabrica`(`new_cars`.`value_model`) AS `factory_value` from `new_cars` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `valor_de_fabricausedcars`
--

/*!50001 DROP VIEW IF EXISTS `valor_de_fabricausedcars`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `valor_de_fabricausedcars` AS select `used_cars`.`name_model` AS `name_model`,`valor_de_fabrica`(`used_cars`.`value_model`) AS `factory_value` from `used_cars` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `payments_usedcars`
--

/*!50001 DROP VIEW IF EXISTS `payments_usedcars`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `payments_usedcars` AS select `a`.`id_car` AS `id_car`,`a`.`cod_car` AS `cod_car`,`a`.`name_model` AS `name_model`,`a`.`value_model` AS `value_model`,`b`.`id_client` AS `id_client`,`b`.`date_membership` AS `date_membership` from (`used_cars` `a` left join `payments` `b` on((`a`.`id_car` = `b`.`id_car`))) where (`a`.`id_car` >= '51') order by `a`.`id_car` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `payments_newcars_info`
--

/*!50001 DROP VIEW IF EXISTS `payments_newcars_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `payments_newcars_info` AS select `a`.`id_car` AS `id_car`,`a`.`cod_car` AS `cod_car`,`a`.`name_model` AS `name_model`,`a`.`value_model` AS `value_model`,`b`.`id_client` AS `id_client`,`b`.`date_membership` AS `date_membership` from (`new_cars` `a` left join `payments` `b` on((`a`.`id_car` = `b`.`id_car`))) where (`a`.`id_car` <= '50') order by `a`.`id_car` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `client_cuotas`
--

/*!50001 DROP VIEW IF EXISTS `client_cuotas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `client_cuotas` AS select `a`.`id_client` AS `id_client`,concat(`a`.`first_name`,' ',`a`.`last_name`) AS `NombreCompleto`,`b`.`metodo_de_pago` AS `MetodoDePago`,(case when (`b`.`metodo_de_pago` = 'al contado  ') then 'VIP' when (`b`.`metodo_de_pago` = 'al contado    ') then 'VIP' when (`b`.`metodo_de_pago` = 'visa        ') then 'COMMON' when (`b`.`metodo_de_pago` = 'mastercard  ') then 'VIP' when (`b`.`metodo_de_pago` = 'mastercard    ') then 'VIP' when (`b`.`metodo_de_pago` = 'mercado pago') then 'COMMON' when (`b`.`metodo_de_pago` = 'mercado pago  ') then 'COMMON' when (`b`.`metodo_de_pago` = 'mercado pago             ') then 'COMMON' end) AS `TipoDeCliente` from (`customers` `a` left join `payments_datails` `b` on((`a`.`id_client` = `b`.`id_client`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `detalles_clientes_producto`
--

/*!50001 DROP VIEW IF EXISTS `detalles_clientes_producto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detalles_clientes_producto` AS select `a`.`id_client` AS `id_client`,concat(`a`.`first_name`,' ',`a`.`last_name`) AS `Full_Name`,`b`.`date_membership` AS `date_membership`,`b`.`id_car` AS `id_car`,(case when (`b`.`id_car` <= '50') then 'Nuevo' when (`b`.`id_car` >= '50') then 'Usado' end) AS `Condition_Car` from (`customers` `a` left join `payments` `b` on((`a`.`id_client` = `b`.`id_client`))) order by `b`.`id_client` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'concesionariobenegas'
--

--
-- Dumping routines for database 'concesionariobenegas'
--
/*!50003 DROP FUNCTION IF EXISTS `NOMBRE_COMPLETO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `NOMBRE_COMPLETO`(FIRST_NAME VARCHAR(100), LAST_NAME VARCHAR(100)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE COMPLETED_NAME varchar(100);
    SET COMPLETED_NAME = concat(LAST_NAME, ' ', FIRST_NAME);
RETURN COMPLETED_NAME;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `valor_de_fabrica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `valor_de_fabrica`(Valor_concesionario INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE valor_de_fabrica INT;
    SET valor_de_fabrica = ((valor_concesionario) - ((valor_concesionario)/10));
RETURN valor_de_fabrica;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ingresar_commentDet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_commentDet`(IN id_car INT, IN cod_car VARCHAR(40), IN comment_det VARCHAR(200))
BEGIN

INSERT INTO comment_det (id_car, cod_car, comment_det) VALUES  (id_car, cod_car, comment_det);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ingresar_Usedcar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_Usedcar`(IN id_car INT, IN cod_car VARCHAR(40), name_model VARCHAR(40), date_model DATE, 
									color_model VARCHAR(20), IN value_model INT)
BEGIN

INSERT INTO used_cars (id_car, cod_car, name_model, date_model, color_model, value_model) VALUES  
								(id_car, cod_car, name_model, date_model, color_model, value_model);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ingresar_Usedcar_SUPPLIER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_Usedcar_SUPPLIER`(IN id_car INT, IN cod_car VARCHAR(40), IN name_supplier VARCHAR(40), IN value_model_factory INT, 
											IN adress VARCHAR(50))
BEGIN

INSERT INTO suppliers (id_car, cod_car, name_supplier, value_model_factory, adress) VALUES  
								(id_car, cod_car, name_supplier, value_model_factory, adress);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ordenamientoValor_newcars` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ordenamientoValor_newcars`(IN valor INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ordenamientoValor_usedcars` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ordenamientoValor_usedcars`(IN valor INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-24 19:27:37
