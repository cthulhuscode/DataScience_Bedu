select *
	from information_schema.schemata;

show databases;

use tienda;
show tables;

describe articulo;
describe empleado;
describe puesto;
describe venta;

-- 
select distinct concat(a.firstName, " ", a.lastName), concat(b.firstName, " ", b.lastName)
from employees a, employees b
where a.reportsTo = b.reportsTo
limit 10;





 