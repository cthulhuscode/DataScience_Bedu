				-- Sesión 3 - Joins y Vistas --
 
-- -------------------------------
-- 				## WORK ##
-- --------------------------------
                
 ##
 # Reto 1 - Subconsultas
 ##
 
-- 1 ¿Cuál es el nombre de los empleados cuyo sueldo es MAYOR a $10,000?
select nombre, apellido_paterno from empleado 
where id_puesto IN (
	select id_puesto 
	from puesto
	where salario > 10000
);

-- 2 ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
select id_empleado, 
	   min(cantidad) as min, 
       max(cantidad) as max
from (
	select clave, id_empleado, count(id_venta) as cantidad 
	from venta
	group by clave, id_empleado
) as subconsulta
group by id_empleado;

-- 3 ¿Cuáles claves de venta incluyen artículos cuyos precios son mayores a $5,000?
select clave, id_articulo from venta
where id_articulo IN (
	select id_articulo 
    from articulo 
    where precio > 5000
);

                
 ##
 # Reto 2 - Joins
 ##
 
# Mostrar las llaves primarias de una tabla
SHOW KEYS FROM venta;
 
-- 1 ¿Cuál es el nombre de los empleados que realizaron cada venta?
select id_venta, clave, nombre, apellido_paterno
from venta as v
join empleado as e
	on v.id_empleado = e.id_empleado
order by clave;

-- 2 ¿Cuál es el nombre de los artículos que se han vendido?
select id_venta, clave, nombre
from venta as v
join articulo as a
	on v.id_articulo = a.id_articulo
order by clave;

-- 3 ¿Cuál es el total de cada venta?
select clave, round(sum(precio), 2) as total
from venta as v
join articulo as a
	on v.id_articulo = a.id_articulo
group by clave
order by clave;

 ##
 # Reto 3 - Vistas
 ##
 
-- 1 Obtener el puesto de un empleado.
create view 131_Puestos as
select id_empleado, 
	   concat(e.nombre, " ", e.apellido_paterno) as nombre,
       p.nombre as puesto 
from empleado as e
join puesto as p
	on p.id_puesto = e.id_puesto;

-- 2 Saber qué artículos ha vendido cada empleado.
create view 131_ArticulosVendidos as
select clave, 
	   concat(e.nombre, " ", apellido_paterno) as empleado, 
	   a.nombre as articulo
from venta as v
join empleado as e
	on e.id_empleado = v.id_empleado
join articulo as a
	on a.id_articulo = v.id_articulo
order by clave;

-- 3 Saber qué puesto ha tenido más ventas.
create view 131_PuestoMaxVentas as
select
	   p.nombre as puesto,
       count(v.clave) as cantidad
from venta as v
join empleado as e
	on v.id_empleado = e.id_empleado
join puesto as p
	on e.id_puesto = p.id_puesto
group by p.nombre
order by cantidad desc 
limit 1;




 