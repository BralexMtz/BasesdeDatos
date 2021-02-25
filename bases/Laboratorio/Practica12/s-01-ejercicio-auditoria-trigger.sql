--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  25/01/2021
--@Descripción:     Practica 12, Archivo Principal

create or replace trigger tr_auto_auditoria
  before 
  insert or 
  update of auto_id,marca, modelo, anio, num_serie, tipo, precio, descuento, fecha_status, 
  status_auto_id, agencia_id, cliente_id or 
  delete  on auto
  for each row

  DECLARE

  v_USERNAME VARCHAR2(40);
  v_auditoria_auto_id number(10,0);
  v_fecha_evento date;
  v_tipo_evento char(1);
  v_precio_anterior number(9,2);
  v_precio_actual number(9,2);
  v_detalle_evento varchar2(2000);
  v_datos_anteriores varchar2(2000);
  v_datos_nuevos varchar2(2000);
  BEGIN
    v_USERNAME := USER;
    v_precio_actual := NULL;
    v_precio_anterior := NULL;

    

    -- INSERTAR DATOS EN LA AUDITORIA
    v_auditoria_auto_id := auditoria_auto_seq.nextval;
    v_fecha_evento := sysdate; 

    case
      when inserting then
        v_tipo_evento := 'I';

        v_detalle_evento := 'El usuario '||v_USERNAME
          ||' ha creado un nuevo auto con fecha '
          ||to_char(v_fecha_evento, 'dd/mm/yyyy hh24:mi:ss')
          ||' con los siguientes valores auto_id ='||:new.auto_id
          ||' marca = '||:new.marca
          ||' modelo = '||:new.modelo
          ||' anio = '||:new.anio
          ||' num_serie = '||:new.num_serie
          ||' tipo = '||:new.tipo
          ||' precio = '||:new.precio
          ||' descuento = '||nvl(:new.descuento,0)
          ||' fecha_status = '||to_char(:new.fecha_status ,'dd/mm/yyyy hh24:mi:ss')
          ||' status_id = '||:new.status_auto_id
          ||' agencia_id = '||:new.agencia_id
          ||' cliente_id = '||nvl(:new.cliente_id,0);
    
      when updating then 
        v_tipo_evento := 'U';
        
        v_datos_anteriores := '';
        v_datos_nuevos := '';

        if updating('auto_id') then
          v_datos_anteriores := v_datos_anteriores||', auto_id ='||:old.auto_id;
          v_datos_nuevos := v_datos_nuevos||', auto_id ='||:new.auto_id;
        end if;
        if updating('marca') then
          v_datos_anteriores := v_datos_anteriores||', marca ='||:old.marca;
          v_datos_nuevos := v_datos_nuevos||', marca ='||:new.marca;
        end if;
        if updating('modelo') then
          v_datos_anteriores := v_datos_anteriores||', modelo ='||:old.modelo;
          v_datos_nuevos := v_datos_nuevos||', modelo ='||:new.modelo;
        end if;
        if updating('anio') then
          v_datos_anteriores:=v_datos_anteriores||', anio ='||:old.anio;
          v_datos_nuevos:=v_datos_nuevos||', anio ='||:new.anio;
        end if;
        if updating('num_serie') then
          v_datos_anteriores:=v_datos_anteriores||', num_serie ='||:old.num_serie;
          v_datos_nuevos:=v_datos_nuevos||', num_serie ='||:new.num_serie;
        end if;
        if updating('tipo') then
          v_datos_anteriores:=v_datos_anteriores||', tipo ='||:old.tipo;
          v_datos_nuevos:=v_datos_nuevos||', tipo ='||:new.tipo;
        end if;
        if updating('precio') then
          v_datos_anteriores:=v_datos_anteriores||', precio ='||:old.precio;
          v_datos_nuevos:=v_datos_nuevos||', precio ='||:new.precio;
          v_precio_anterior:= :old.precio;
          v_precio_actual:= :new.precio;
        end if;
        if updating('descuento') then
          v_datos_anteriores:=v_datos_anteriores||', descuento ='||:old.descuento;
          v_datos_nuevos:=v_datos_nuevos||', descuento ='||:new.descuento;
        end if;
        if updating('fecha_status') then
          v_datos_anteriores:=v_datos_anteriores||', fecha_status ='||:old.fecha_status;
          v_datos_nuevos:=v_datos_nuevos||', fecha_status ='||:new.fecha_status;
        end if;
        if updating('status_auto_id') then
          v_datos_anteriores:=v_datos_anteriores||', status_auto_id ='||:old.status_auto_id;
          v_datos_nuevos:=v_datos_nuevos||', status_auto_id ='||:new.status_auto_id;
        end if;
        if updating('agencia_id') then
          v_datos_anteriores:=v_datos_anteriores||', agencia_id ='||:old.agencia_id;
          v_datos_nuevos:=v_datos_nuevos||', agencia_id ='||:new.agencia_id;
        end if;
        if updating('cliente_id') then
          v_datos_anteriores:=v_datos_anteriores||', cliente_id ='||:old.cliente_id;
          v_datos_nuevos:=v_datos_nuevos||', cliente_id ='||:new.cliente_id;
        end if;
        
        v_detalle_evento := 'El usuario '||v_USERNAME||
        ' ha actualizado los datos de un auto con fecha'||
        to_char(v_fecha_evento, 'dd/mm/yyyy hh24:mi:ss')||
        '. Datos anteriores:'||v_datos_anteriores||', datos nuevos'||v_datos_nuevos;
        
      when deleting then
        v_tipo_evento:='I';
        v_detalle_evento:='El usuario '||v_USERNAME
          ||' ha eliminado los dato de un auto con fecha '
          ||to_char(v_fecha_evento, 'dd/mm/yyyy hh24:mi:ss')
          ||'. Datos del auto eliminado : auto_id ='||:old.auto_id
          ||' marca = '||:old.marca
          ||' modelo = '||:old.modelo
          ||' anio = '||:old.anio
          ||' num_serie = '||:old.num_serie
          ||' tipo = '||:old.tipo
          ||' precio = ' ||:old.precio
          ||' descuento = ' ||nvl(:old.descuento,0)
          ||' fecha_status = ' ||to_char(:old.fecha_status , 'dd/mm/yyyy hh24:mi:ss')
          ||' status_id = ' ||:old.status_auto_id
          ||' agencia_id = ' ||:old.agencia_id
          ||' cliente_id = ' ||nvl(:old.cliente_id,0);
  
    end case;

    insert into auditoria_auto(auditoria_auto_id, fecha_evento, usuario, tipo_evento,
      precio_anterior, precio_actual, detalle_evento)
    values(v_auditoria_auto_id,v_fecha_evento,v_USERNAME,v_tipo_evento,v_precio_anterior,
      v_precio_actual,v_detalle_evento);

  END;
  /
show errors 