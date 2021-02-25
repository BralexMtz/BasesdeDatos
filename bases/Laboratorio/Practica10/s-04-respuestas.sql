


--1.sintaxis estándar
create table consulta_1 as
select a.nombre, a.clave_articulo, s.clave
from articulo a
join ARTICULO_FAMOSO af
on a.articulo_id=af.ARTICULO_ID
join STATUS_ARTICULO s 
on a.STATUS_ARTICULO_ID= s.STATUS_ARTICULO_ID
where af.NOMBRE_COMPLETO='William Harvey';

--2.Natural join
create table consulta_2 as
select articulo_id, a.nombre, a.clave_articulo
from  pais p
natural join ARTICULO_DONADO ad
join articulo a using(articulo_id)
join status_articulo s using(status_articulo_id)
  where p.descripcion='BELGICA' 
  and s.clave='ENTREGADO';


--3.natural join
--articulo, subasta_venta, subasta, cliente
create table consulta_3 as
select articulo_id, a.nombre, precio_inicial, precio_venta, tipo_articulo, 
  s.nombre as nombre_subasta, TO_CHAR(FECHA_INICIO,'yyyy/mm/dd HH:mi:ss PM') as fecha_inicio
from subasta s  
join articulo a using(subasta_id)
natural join subasta_venta sv 
join cliente c using(cliente_id)
where c.nombre='MARICELA' 
 and apellido_paterno='PAEZ' 
 and apellido_materno='MARTINEZ' 
 and to_char(fecha_fin,'yyyy')='2010';


--4. sintaxis estándar
create table consulta_4 as
select c.cliente_id, c.nombre, c.apellido_paterno, c.apellido_materno, t.numero_tarjeta, 
  t.tipo_tarjeta, t.anio_vigencia, t.mes_vigencia
from cliente c
join tarjeta_cliente t
on c.cliente_id = t.cliente_id
where(to_date(t.mes_vigencia ||'/20'|| t.anio_vigencia, 'mm/yyyy')<to_date('11/2011','mm/yyyy'));

--5. Sintáxis estándar
create table consulta_5 as
select a.articulo_id, a.nombre, a.clave_articulo, a.tipo_articulo, aa.anio_hallazgo, 
  a.precio_inicial, sv.precio_venta
from  articulo a
left outer join subasta_venta sv
on a.articulo_id = sv.articulo_id
join articulo_arqueologico aa
on a.articulo_id = aa.articulo_id
where(a.precio_inicial>800000);

--6. notación SQL anterior
create table consulta_6 as
select c.nombre, c.APELLIDO_PATERNO,c.APELLIDO_MATERNO, c.EMAIL, c.OCUPACION, tc.TIPO_TARJETA
from cliente c, TARJETA_CLIENTE tc
where c.cliente_id=tc.CLIENTE_ID(+)
and c.OCUPACION='ABOGADO';
-- El profe no dijo que agregaramos ocupacion

--7.Operadores de álgebra relacional
create table consulta_7 as
  select a.articulo_id,a.nombre, a.CLAVE_ARTICULO, a.PRECIO_INICIAL,a.STATUS_ARTICULO_ID
  from articulo a
    where a.PRECIO_INICIAL>900000
intersect
  select a.articulo_id,a.nombre, a.CLAVE_ARTICULO, a.PRECIO_INICIAL,a.STATUS_ARTICULO_ID
  from articulo a
  join status_articulo s
  on s.status_articulo_id=a.status_articulo_id
    where s.clave='REGISTRADO';

--8. sintaxis estándar
create table consulta_8 as
select a.articulo_id, a.CLAVE_ARTICULO, a.NOMBRE, s.status_articulo_id, aa.anio_hallazgo,
(1922-anio_hallazgo) "antiguedad"  
from STATUS_ARTICULO s
join articulo a
  on a.STATUS_ARTICULO_ID=s.STATUS_ARTICULO_ID
join ARTICULO_ARQUEOLOGICO aa
  on a.ARTICULO_ID=aa.ARTICULO_ID
  where aa.ANIO_HALLAZGO<=1722 
  and s.CLAVE='REGISTRADO';

--9. no indica
create table consulta_9 as
select a.nombre, a.tipo_articulo
from articulo a
join status_articulo sa
on a.status_articulo_id = sa.status_articulo_id
where((a.nombre like '%Colonial%' OR a.descripcion like '%Colonial%')
  and sa.clave = 'EN SUBASTA');

--10. Sintaxis estándar
create table consulta_10 as
select to_char(fc.fecha_factura,'dd/mm/yyyy') as "fecha_factura", 
  tc.numero_tarjeta, 
  c.nombre as "nombre_cliente",
  c.apellido_paterno,
  c.apellido_materno,
  sv.precio_venta,
  a.precio_inicial,
  (sv.precio_venta - a.precio_inicial) as "diferencia",
  a.nombre as "nombre_articulo",
  a.clave_articulo,
  a.tipo_articulo,
  af.nombre_completo,
  aa.anio_hallazgo,
  p.clave
  from cliente c
  join tarjeta_cliente tc
  on c.cliente_id = tc.cliente_id
  join factura_cliente fc
  on tc.tarjeta_cliente_id=fc.tarjeta_cliente_id
  join subasta_venta sv
  on sv.factura_cliente_id = fc.factura_cliente_id 
  join articulo a
  on a.articulo_id = sv.articulo_id
  left outer join articulo_famoso af
  on a.articulo_id = af.articulo_id
  left outer join articulo_arqueologico aa
  on a.articulo_id = aa.articulo_id
  left outer join articulo_donado ad
  on a.articulo_id = ad.articulo_id
  left outer join pais p
  on ad.pais_id = p.pais_id
  where tc.numero_tarjeta='5681375824866375';


-- 11 . Notacion anterior compatible con oracle
create table consulta_11 as
select to_char(fc.fecha_factura,'dd/mm/yyyy') as "fecha_factura", 
  tc.numero_tarjeta, 
  c.nombre as "nombre_cliente",
  c.apellido_paterno,
  c.apellido_materno,
  sv.precio_venta,
  a.precio_inicial,
  (sv.precio_venta - a.precio_inicial) as "diferencia",
  a.nombre as "nombre_articulo",
  a.clave_articulo,
  a.tipo_articulo,
  af.nombre_completo,
  aa.anio_hallazgo,
  p.clave
  from cliente c,tarjeta_cliente tc, factura_cliente fc, subasta_venta sv, articulo a,
    articulo_famoso af, articulo_arqueologico aa, articulo_donado ad, pais p
  where 
    c.cliente_id = tc.cliente_id and
    tc.tarjeta_cliente_id=fc.tarjeta_cliente_id and
    sv.factura_cliente_id = fc.factura_cliente_id and
    a.articulo_id = sv.articulo_id and
    a.articulo_id = af.articulo_id(+) and
    a.articulo_id = aa.articulo_id(+) and
    a.articulo_id = ad.articulo_id(+) and
    ad.pais_id = p.pais_id(+) and
    tc.numero_tarjeta='5681375824866375';

commit;