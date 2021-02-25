--@Autor(es): Brayan Alexis
--@Fecha creación: 09/01/2021
--@Descripción: Práctica 09 - Archivo de respuestas.

prompt creando consulta1
create table consulta_1 as
select  clave, fecha_inicio, fecha_fin from plan_estudios;

prompt creando consulta2
create table consulta_2 as
select * from asignatura where asignatura_requerida_id is null 
intersect 
select * from asignatura where creditos >= 9 ;

prompt creando consulta3

create table consulta_3 as
select nombre,APELLIDO_PATERNO,APELLIDO_MATERNO from profesor where 
  to_char(fecha_nacimiento,'YYYY') = '1970' 
union
Select nombre,APELLIDO_PATERNO,APELLIDO_MATERNO from profesor where 
  upper(nombre) like 'A%';

--create table consulta_4 as
-- select

--create table consulta_5 as
create table consulta_5 as
select NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO from profesor where to_char(fecha_nacimiento,'YYYY') = '1970'   
union all 
select NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO from profesor where upper(nombre) like 'A%'; 

create table consulta_6 as
select * from (
    select nombre,APELLIDO_PATERNO,APELLIDO_MATERNO,fecha_nacimiento from profesor where 
      to_char(fecha_nacimiento,'YYYY') = '1970' 
    union
    select nombre,APELLIDO_PATERNO,APELLIDO_MATERNO,fecha_nacimiento from profesor where 
      upper(nombre) like 'A%'
) order by fecha_nacimiento;

create table consulta_7 as
select ASIGNATURA_ID, NOMBRE, PLAN_ESTUDIOS_ID, CREDITOS  from asignatura 
  where plan_estudios_id =1 
Union 
select ASIGNATURA_ID, NOMBRE, PLAN_ESTUDIOS_ID, CREDITOS from asignatura 
  where plan_estudios_id =2 
Minus 
Select ASIGNATURA_ID, NOMBRE, PLAN_ESTUDIOS_ID, CREDITOS from asignatura 
  where creditos >=9 ;

create table consulta_8 as
select c.curso_id "Id Curso",c.cupo_maximo "Cupo",a.nombre "Nombre A."
from curso c
join ASIGNATURA a
on a.ASIGNATURA_ID=c.ASIGNATURA_ID
where c.CLAVE_GRUPO='005';
