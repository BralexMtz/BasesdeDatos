
--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  19/01/2021
--@Descripción:     Practica 11



-- Ejercicio 1
create table consulta_1 as
select count(*) as num_articulos, SUM(sv.precio_venta) as ingresos 
from SUBASTA s
join articulo a
on s.SUBASTA_ID = a.SUBASTA_ID
left join subasta_venta sv
on sv.ARTICULO_ID=a.ARTICULO_ID
where to_char(s.FECHA_INICIO,'YYYY')='2010';

-- Ejercicio 2
create table consulta_2 as
select count(*) as num_articulos
from subasta s
join articulo a
on s.subasta_id=a.subasta_id
left join subasta_venta sv
on sv.articulo_id=a.articulo_id
where to_char(s.FECHA_INICIO,'YYYY')='2010' 
 and sv.subasta_venta_id is null;

-- Ejercicio 3
create table consulta_3 as
select min(a.precio_inicial) as min_precio_inicial,
  max(a.precio_inicial) as max_precio_inicial,
  min(sv.PRECIO_VENTA) as min_precio_venta,
  max(sv.PRECIO_VENTA) as max_precio_venta
from articulo a
join subasta s
on a.subasta_id = s.subasta_id
join subasta_venta sv
on sv.ARTICULO_ID=a.articulo_id
where s.nombre='EXPO-MAZATLAN';

-- Ejercicio 4
create table consulta_4 as
select c.cliente_id, c.email, tc.numero_tarjeta
from cliente c
join tarjeta_cliente tc
on c.cliente_id=tc.cliente_id
left join subasta_venta sv
on c.cliente_id=sv.cliente_id
where to_char(c.fecha_nacimiento,'YYYY')>1970 
and to_char(c.fecha_nacimiento,'YYYY')<1975
and sv.cliente_id is null;


-- Ejercicio 5
create table consulta_5 as
select  count(*) as num_articulos,a.tipo_articulo, 
  sa.clave
from articulo a
join status_articulo sa
on a.status_articulo_id = sa.status_articulo_id
left join articulo_famoso af
on a.articulo_id = af.articulo_id
left join articulo_arqueologico aa
on a.articulo_id = aa.articulo_id
left join articulo_donado ad
on a.articulo_id = ad.articulo_id
where sa.clave = 'VENDIDO' 
  or sa.clave = 'ENTREGADO'
group by a.tipo_articulo, sa.clave;



-- Ejercicio 6 --Preguntar la redacción
create table consulta_6 as
select s.nombre, s.fecha_inicio,s.lugar,
  a.tipo_articulo, sum(sv.precio_venta) as total_venta
from subasta s
join articulo a
on s.subasta_id=a.subasta_id
join subasta_venta sv
on sv.ARTICULO_ID=a.articulo_id
where to_char(s.fecha_fin,'YYYY')='2009'
group by a.tipo_articulo,s.nombre,
  s.fecha_inicio,s.lugar;


-- Ejercicio 7
create table consulta_7 as
select c.cliente_id, c.nombre, 
  c.apellido_paterno,c.apellido_materno, 
  count(*) as num_articulos, 
  sum(sv.precio_venta) as total
from cliente c
join subasta_venta sv
on sv.cliente_id = c.cliente_id
group by c.cliente_id, c.nombre, 
  c.apellido_paterno,c.apellido_materno
having count(*) > 5
union
select c.cliente_id, c.nombre, c.apellido_paterno,
  c.apellido_materno, count(*) as num_articulos, 
  sum(sv.precio_venta) as total
from cliente c
join subasta_venta sv
on sv.cliente_id = c.cliente_id
group by c.cliente_id, c.nombre, 
  c.apellido_paterno, c.apellido_materno
having sum(sv.precio_venta) > 3000000;



-- Ejercicio 8
create table consulta_8 as
select q1.subasta_id,q1.nombre,q1.fecha_inicio,
  a.nombre as nombre_articulo,
  a.clave_articulo, q1.max_precio_venta as mas_caro
from subasta_venta sv,articulo a, (
  select s.subasta_id,s.nombre,s.fecha_inicio,
    max(sv.precio_venta) as max_precio_venta
  from subasta s
  join articulo a
  on a.subasta_id=s.subasta_id
  join subasta_venta sv
  on sv.articulo_id=a.articulo_id
  where to_char(s.fecha_inicio,'YYYY')=2010
    and to_char(s.fecha_inicio,'mm') in (1,3,6)
  group by s.subasta_id,s.nombre,s.fecha_inicio
) q1
where sv.articulo_id=a.articulo_id
  and a.subasta_id=q1.subasta_id
  and sv.PRECIO_VENTA=q1.max_precio_venta;


-- Ejercicio 9
create table consulta_9 as
select sum(sv.precio_venta) as monto_total
from cliente c, tarjeta_cliente tc, 
  factura_cliente fc, subasta_venta sv
where c.cliente_id = tc.cliente_id 
  and tc.tarjeta_cliente_id = fc.tarjeta_cliente_id 
  and sv.factura_cliente_id = fc.factura_cliente_id 
  and c.nombre = 'GALILEA' 
  and c.apellido_paterno = 'GOMEZ' 
  and c.apellido_materno = 'GONZALEZ' 
  and fc.fecha_factura = (
    select max(fecha_factura)
    from factura_cliente
    where tarjeta_cliente_id = tc.tarjeta_cliente_id
);


-- Ejercicio 10
create table consulta_10 as
select s.subasta_id, s.nombre, 
  count(*) as num_articulos
from subasta_venta sv
join articulo a
on sv.articulo_id=a.articulo_id
join subasta s
on a.subasta_id=s.subasta_id
where to_char(s.fecha_inicio,'YYYY')=2010
group by s.subasta_id,s.nombre
having count(*) > 3
order by s.subasta_id;


-- Ejercicio 11
create table consulta_11 as
select s.subasta_id, s.fecha_inicio, 
  a.articulo_id,a.nombre,a.precio_inicial,(
    select avg(a.precio_inicial)
    from articulo a
    join subasta s
    on s.subasta_id=a.subasta_id
    where to_char(s.fecha_inicio,'YYYY')=2010
    and a.nombre like '%otocicleta%'
) as promedio
from subasta_venta sv
join articulo a
on sv.articulo_id=a.articulo_id
join subasta s
on a.subasta_id=s.subasta_id
where a.status_articulo_id in (3,4) 
  and  to_char(fecha_inicio,'mm-YYYY')='07-2010'
  and a.nombre like '%otocicleta%';
  
-- Ejercicio 12
create table consulta_12 as
select p.pais_id,p.clave, p.descripcion
from pais p
join articulo_donado ad
on p.pais_id=ad.pais_id
join articulo a
on ad.articulo_id=a.articulo_id
where a.precio_inicial>300000
group by p.pais_id, p.clave,p.descripcion
having count(*)>=3;

-- Ejercicio 13
create table consulta_13 as
select s.subasta_id, s.nombre, s.fecha_inicio, 
  sum(sv.precio_venta) as monto_total
from subasta_venta sv
join articulo a
on sv.articulo_id=a.articulo_id
join subasta s
on a.subasta_id=s.subasta_id
where to_char(s.fecha_fin,'YYYY')=2010
group by s.subasta_id,s.nombre, s.fecha_inicio
having sum(sv.precio_venta) >= 3000000;


-- Ejercicio 14
create table consulta_14 as
select  c.nombre, c.APELLIDO_PATERNO, c.APELLIDO_MATERNO, 
  sum(sv.PRECIO_VENTA) as monto_total
from cliente c
join subasta_venta sv
on c.cliente_id=sv.cliente_id
where sv.factura_cliente_id is null
group by c.nombre,c.apellido_paterno,c.APELLIDO_MATERNO
having sum(sv.PRECIO_VENTA) > 1000000;

-- Ejercicio 15
create table consulta_15 as
select * 
from subasta s
where s.subasta_id=(
  select s.subasta_id
  from subasta s
  join articulo a
  on s.subasta_id=a.subasta_id
  join subasta_venta sv
  on sv.articulo_id=a.articulo_id
  group by s.subasta_id
  having count(*)=(
    select max(q.num_articulos) as max_articulos
    from ( 
      select s.subasta_id,count(*) as num_articulos
      from subasta s
      join articulo a
      on s.subasta_id=a.subasta_id
      join subasta_venta sv
      on sv.articulo_id=a.articulo_id
      group by s.subasta_id
    ) q
  )
);

commit;
