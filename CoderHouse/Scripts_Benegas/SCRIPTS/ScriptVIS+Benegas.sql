#view de compras de valores de autos nuevos con su respectivo precio#

	CREATE view payments_newcars_info AS
(	SELECT a.id_car, a.cod_car, a.name_model, a.value_model, id_client,
	b.date_membership
	from new_cars as a
	LEFT JOIN payments as b ON a.id_car=b.id_car
    where a.id_car <= '50'
    order by id_car desc
	);

#view de compras de valores de autos usados con precios#

CREATE VIEW payments_usedcars AS
(	SELECT a.id_car, a.cod_car, a.name_model, a.value_model, b.id_client,
	b.date_membership
	from used_cars as a
	LEFT JOIN payments as b ON a.id_car=b.id_car
    where a.id_car >= '51'
    order by id_car asc
	);
    
#informacion de cliente y adquisicion#

CREATE VIEW Detalles_Clientes_producto AS
SELECT a.id_client, concat(first_name, ' ', last_name) as Full_Name, b.date_membership, b.id_car, 
( 	case 
	when b.id_car <= '50' then 'Nuevo'
	when b.id_car >= '50' then 'Usado'
	end) as Condition_Car
FROM customers a
LEFT JOIN payments as b on  a.id_client=b.id_client
Order by b.id_client;

select * from Detalles_Clientes_producto;


#Comentarios sobre deterioro de autos usados#

CREATE VIEW comments_usedCarsAndValue AS
(	
	SELECT a.name_model as MODELO, a.color_model AS COLOR, b.comment_det as DETALLE
	FROM used_cars as a 
	LEFT JOIN comment_det as b ON a.id_car=b.id_car
);

#NOMBRE COMPLETO DE CLIENTE, TIPO DE CLIENTE, Y METODO DE PAGO#

CREATE VIEW Client_cuotas as
(Select a.id_client, nombre_completo(a.first_name, a.last_name) AS NombreCompleto, (b.metodo_de_pago) as MetodoDePago,
(
case 
	when b.metodo_de_pago = ('al contado  ') then 'VIP'
	when b.metodo_de_pago = ('al contado    ') then 'VIP'    
    when b.metodo_de_pago = ('visa        ') then 'COMMON'
    when b.metodo_de_pago = ('mastercard  ') then 'VIP'
	when b.metodo_de_pago = ('mastercard    ') then 'VIP'
    when b.metodo_de_pago = ('mercado pago') then 'COMMON'
    when b.metodo_de_pago = ('mercado pago  ') then 'COMMON'
    when b.metodo_de_pago = ('mercado pago             ') then 'COMMON'  
end 
) as TipoDeCliente
FROM customers AS a
LEFT JOIN payments_datails as b ON a.id_client=b.id_client
);



