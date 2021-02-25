--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  25/01/2021
--@Descripción:     Practica 12, Archivo Prueba 1

--Escenario 1:
--Validando Auditoria para inserción

set serveroutput on
declare

registro_encontrado number(2,0);
v_auto_id number(10,0);
v_auditoria_auto_id number(10,0);
v_fecha_evento date;
v_usuario varchar2(40);
v_tipo_evento varchar2(1);
v_precio_anterior number(9,2);
v_precio_actual number(9,2);
v_detalle_evento varchar2(2000);

begin

--1. Realizar una inserción en auto para provocar que el trigger se active.
--- Guardar el id del nuevo auto en una variable v_auto_id
v_auto_id:=1007;
v_precio_actual:=597121.03;

insert into auto(auto_id, marca, modelo, anio, num_serie, tipo, precio, descuento, 
  foto, fecha_status, status_auto_id, agencia_id, cliente_id) 
values(v_auto_id,'Ford','S',1996,'12345HBCSAD6HBJDSA','P',56273.00,35.99,empty_blob(),
  sysdate,1,1,null);

--2. Realizar una consulta en auditoria_auto para obtener el registro que
-- debió haber sido generado empleando como criterio de búsqueda al id
-- del auto.
select count(*) into registro_encontrado
from auditoria_auto where detalle_evento like '% auto_id ='||v_auto_id||'%';

if registro_encontrado > 0 then
  select usuario,  tipo_evento,  detalle_evento
  into v_usuario,v_tipo_evento,v_detalle_evento
  from auditoria_auto where detalle_evento like '% auto_id ='||v_auto_id||'%';

-- Revisar los valores de las columnas del registro y verificar si son correctos.
-- Si son correctos imprimir OK, datos correctos. De lo contrario, lanzar excepción
-- Ejemplo:

    if v_usuario <> 'MAMA_P1201_AUTOS' then
        raise_application_error(-20001,'El valor del campo usuario es incorrecto, se obtuvo '
        ||v_usuario
        || ', se esperaba mama_p1201_autos');
    else
        dbms_output.put_line('valor para columna usuario correcta.');
    end if;
    
    if v_tipo_evento <> 'I' then
        raise_application_error(-20001,'El valor del tipo evento, se obtuvo '
        ||v_tipo_evento
        || ', se esperaba I');
    else
        dbms_output.put_line('valor para columna usuario correcta.');
    end if;

    dbms_output.put_line(v_detalle_evento);

else
-- El registro no fue encontrado, quiere decir que el trigger no está funcionando, se lanza
-- una excepción para provocar un error.
    raise_application_Error(-20001,'El registro con auto_id = '||v_auto_id);
end if;
--si se llega a este punto quiere decir que todo está OK, se indica que la prueba fue exitosa.
    dbms_output.put_line('OK, prueba 1 exitosa.');



dbms_output.put_line('-----------------INICIO PRUEBA 2------------------');




--1. Realizar una inserción en auto para provocar que el trigger se active.
--- Guardar el id del nuevo auto en una variable v_auto_id

update auto set precio=v_precio_actual, marca='Tesla' 
where auto_id=v_auto_id;

--2. Realizar una consulta en auditoria_auto para obtener el registro que
-- debió haber sido generado empleando como criterio de búsqueda al id
-- del auto.

select count(*) into registro_encontrado
from auditoria_auto where detalle_evento like '% precio ='||v_precio_actual||'%' and tipo_evento='U';

if registro_encontrado > 0 then
  select usuario,  tipo_evento,  detalle_evento
  into v_usuario,v_tipo_evento,v_detalle_evento
  from auditoria_auto where detalle_evento like '% precio ='||v_precio_actual||'%' and tipo_evento='U';

-- Revisar los valores de las columnas del registro y verificar si son correctos.
-- Si son correctos imprimir OK, datos correctos. De lo contrario, lanzar excepción
-- Ejemplo:

    if v_usuario <> 'MAMA_P1201_AUTOS' then
        raise_application_error(-20001,'El valor del campo usuario es incorrecto, se obtuvo '
        ||v_usuario
        || ', se esperaba mama_p1201_autos');
    else
        dbms_output.put_line('valor para columna usuario correcta.');
    end if;
    
    if v_tipo_evento <> 'U' then
        raise_application_error(-20001,'El valor del tipo evento es incorrecto, se obtuvo '
        ||v_tipo_evento
        || ', se esperaba U');
    else
        dbms_output.put_line('valor para columna usuario correcta.');
    end if;

    dbms_output.put_line(v_detalle_evento);

else
-- El registro no fue encontrado, quiere decir que el trigger no está funcionando, se lanza
-- una excepción para provocar un error.
    raise_application_Error(-20001,'El registro con auto_id = '||v_precio_actual);
end if;
--si se llega a este punto quiere decir que todo está OK, se indica que la prueba fue exitosa.
    dbms_output.put_line('OK, prueba 2 exitosa.');

end;
/
show errors
-----------------------------------------------------------------------------------------
-- realizar al menos una prueba más, para cualquiera de los siguientes escenarios:
-- Validar una actualización
-----------------------------------------------------------------------------------------
