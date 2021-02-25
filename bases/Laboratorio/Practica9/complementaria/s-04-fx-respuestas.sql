--@Autor(es): Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación: 09/01/2021
--@Descripción: Práctica 09 C


create table consulta_1 as
select EMPLEADO_ID , AP_PATERNO, AP_MATERNO,email, 
to_char(FECHA_REGISTRO,'dd/mm/yyyy hh24:mi:ss')  as fecha_registro from empleado;
  

create table consulta_2 as
select EMPLEADO_ID, (SUELDO_MENSUAL/2) "SUELDO_QUINCENAL",  
  round(SUELDO_MENSUAL/2,1) "SUELDO_REDONDEADO",
  floor(SUELDO_MENSUAL/2)"SUELDO_SIN_DECIMALES"
  from empleado;

create table consulta_3 as
select round(sqrt( power(la2-la1,2)+power(lo2-lo1,2)  ),5) as distancia from (
  select e1.latitud as la1,e1.longitud as lo1,e2.latitud as la2,e2.longitud as lo2
  from empleado e1, empleado e2
  where e1.empleado_id =1
  and e2.empleado_id=2
);


create table consulta_4 as
select empleado_id, to_char(fecha_nacimiento,'day dd month yyyy') "FECHA_NACIMIENTO" 
from empleado;

create table consulta_5 as
select empleado_id, 
    floor( (sysdate - fecha_nacimiento)/365) as años
from empleado;


create table consulta_6 as
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') as fecha_actual, 
to_char(sysdate+( (2/24) + (1/72)),'dd/mm/yyyy hh24:mi:ss') as fecha_futura 
from dual; 

create table consulta_7 as
select ap_paterno, ap_materno, upper('EMP-'||ap||am) as clave 
  from (
    select ap_paterno,ap_materno, SUBSTR(ap_paterno,0,2) as ap, SUBSTR(ap_materno,-2) as am from empleado
  ); 

create table consulta_8 as
select ap_paterno, ap_materno, upper('EMP-'||ap||nvl(am,'00')) as clave 
  from (
    select ap_paterno,ap_materno,SUBSTR(ap_paterno,0,2) as ap, 
    SUBSTR(ap_materno,-2) as am
    from empleado
  );

create table consulta_9 as
select email,nvl(substr(email,1,instr(email,'@')-1),'sn') as ID  from empleado;
 

create table consulta_10 as
select num_seguro,
num_seguro || '-'||
decode(substr(num_seguro,length(num_seguro),length(num_seguro)+1),
'1','A',
'2','B',
'3','C',
'4','D',
'5','E',
'0') as nuevo_numero
from EMPLEADO;


create table consulta_11 as
select nombre,
  pagina_web,
  substr(
    pagina_web,nullif(instr(pagina_web,'?')+1,1)
  ) as parametros
from empleado
where pagina_web is not null;

