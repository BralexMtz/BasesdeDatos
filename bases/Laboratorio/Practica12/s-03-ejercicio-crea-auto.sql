--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  25/01/2021
--@Descripción:     Creación de procedimiento.
set serveroutput on
create or replace procedure p_crea_auto(
    p_auto_id in out number, 
    p_marca in varchar2, 
    p_modelo in varchar2, 
    p_anio in number, 
    p_num_serie in varchar2 , 
    p_tipo in varchar2,
    p_precio in number, 
    p_agencia_id in number, 
    p_num_cilindros in number default null, 
    p_num_pasajeros in number default null, 
    p_clase in varchar2 default null, 
    p_peso_maximo in number default null, 
    p_volumen in number default null, 
    p_tipo_combustible in varchar2 default null
) is

  v_status auto.status_auto_id%type;
  v_fecha date;
  v_historico_status_id historico_status_auto.historico_status_id%type;

BEGIN
  v_status :=2;
  v_fecha := sysdate;

  select auto_seq.nextval into p_auto_id
  from dual;

  select historico_status_auto_seq.nextval into v_historico_status_id
  from dual;

  if  ( p_tipo = 'P' and p_num_cilindros is not null 
      and p_num_pasajeros is not null 
      and p_clase is not null 
      and p_peso_maximo is null
      and p_volumen is null
      and p_tipo_combustible is null ) 
     or ( p_tipo = 'C' and p_num_pasajeros is null 
      and p_clase is null 
      and p_peso_maximo is not null
      and p_volumen is not null
      and p_tipo_combustible is not null )
      then
      -- insercion padre
      dbms_output.put_line('Insertando padre');

      insert into auto (auto_id, marca, modelo, anio, num_serie, tipo, precio, 
        descuento, foto, fecha_status, status_auto_id, agencia_id, cliente_id)
        values(p_auto_id,p_marca, p_modelo, p_anio, p_num_serie, p_tipo, p_precio, null, 
         empty_blob(), sysdate, v_status, p_agencia_id,null);
  
      dbms_output.put_line('Insertando en historico');
  
      insert into historico_status_auto(historico_status_id, fecha_status, 
        status_auto_id, auto_id) 
      values(v_historico_status_id,v_fecha,v_status,p_auto_id);
  
      
  else
    dbms_output.put_line(' D: ');
    raise_application_error(-20001,'El tipo de auto no es correcto,'||
      ' los valores del subtipo no son correctos ');
  end if;

  dbms_output.put_line('Insertando subtipo');
  if p_tipo = 'P' then
    dbms_output.put_line(' PARTICULAR');
    insert into auto_particular(auto_id,num_cilindros,num_pasajeros,clase) values(p_auto_id,p_num_cilindros, p_num_pasajeros,p_clase);
        
  elsif p_tipo='C' then
    dbms_output.put_line(' CARGA');
    insert into auto_carga(auto_id,peso_maximo,volumen,tipo_combustible) values(p_auto_id,p_peso_maximo,p_volumen,p_tipo_combustible);
  end if;

END;
/


