				-- Sesión 2 - Agrupaciones y subconsultas --
 
-- -------------------------------
-- 				## WORK ##
-- --------------------------------
                
 ##
 # Reto 1
 ##
 
 USE tienda;
 
-- 1 Qué artículos incluyen la palabra Pasta en su nombre?
SELECT * FROM articulo WHERE nombre LIKE "%Pasta%";

-- 2 ¿Qué artículos incluyen la palabra Cannelloni en su nombre?
SELECT * FROM articulo WHERE nombre LIKE "%Cannelloni%";

-- 3 ¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
SELECT * FROM articulo WHERE nombre LIKE "%-%";

-- 4 ¿Qué puestos incluyen la palabra Designer?
SELECT nombre FROM puesto WHERE nombre LIKE "%Designer%";

-- 5 ¿Qué puestos incluyen la palabra Developer?
SELECT nombre FROM puesto WHERE nombre LIKE "%Developer%";


## 
# Reto 2
## 

-- 1 ¿Cuál es el promedio de salario de los puestos?
SELECT AVG(salario) AS promedio_salarios
FROM puesto;

-- 2 ¿Cuántos artículos incluyen la palabra Pasta en su nombre?
SELECT COUNT(*) FROM articulo WHERE nombre LIKE "%Pasta%";

-- 3 ¿Cuál es el salario mínimo y máximo?
SELECT MIN(salario) AS salario_minimo, MAX(salario) AS salario_maximo
FROM puesto;

-- 4 ¿Cuál es la suma del salario de los últimos cinco puestos agregados?
SELECT SUM(salario) AS suma_salario 
FROM puesto
WHERE id_puesto > ( 
	SELECT MAX(id_puesto) - 5 AS valor FROM puesto
);

SELECT SUM(salario) from (
	select salario
    from puesto
    order by id_puesto desc
    limit 5
) salarios;

## 
# Reto 3
## 

-- 1 ¿Cuántos registros hay por cada uno de los puestos?
SELECT nombre, COUNT(*) AS total_registros FROM puesto
GROUP BY nombre;

-- 2 ¿Cuánto dinero se paga en total por puesto?
SELECT nombre, SUM(salario) AS total FROM puesto
GROUP BY nombre
ORDER BY total DESC;

-- 3 ¿Cuál es el número total de ventas por vendedor?
SELECT v.id_empleado, CONCAT(e.nombre, " ", e.apellido_paterno) as empleado, count(v.id_venta) as total_ventas FROM venta v
INNER JOIN empleado e
ON v.id_empleado = e.id_empleado
GROUP BY v.id_empleado
ORDER BY empleado;

-- 4 ¿Cuál es el número total de ventas por artículo?
SELECT v.id_articulo, a.nombre as articulo, count(v.id_venta) as total_ventas FROM venta v
INNER JOIN articulo a
ON v.id_articulo = a.id_articulo
GROUP BY v.id_venta
ORDER BY articulo;

SELECT SUM(salario), nombre from puesto
GROUP BY nombre;
