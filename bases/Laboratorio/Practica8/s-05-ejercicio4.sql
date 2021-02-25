--@Autor(es):       Maria Fernanda Maya Ortega, Brayan Alexis Martinez Vazquez
--@Fecha creación:  03/01/2021
--@Descripción:     ejercicio 4 de la practica 8

--A. 
update cuenta set estatus_cuenta_id = ( select estatus_cuenta_id from estatus_cuenta where clave='CONGELADA' ) where num_cuenta = 903911;

update cuenta set fecha_estatus = to_date('25/12/2018 23:59:59','dd/mm/yyyy HH24:MI:SS') where num_cuenta = 903911;

insert into historico_estatus_cuenta(historico_estatus_cuenta_id,fecha_estatus,cuenta_id, estatus_cuenta_id) 
  values(hist_estatus_cta_seq.nextval,TO_DATE('25/12/2018 23:59:59','dd/mm/yyyy HH24:MI:SS'),
  (select cuenta_id from cuenta where num_cuenta = 903911), 
  (select estatus_cuenta_id from estatus_cuenta where clave='CONGELADA') );


-- B

delete from portafolio_inversion 
  where tipo_portafolio_id = (select tipo_portafolio_id from tipo_portafolio where clave = 'IVV') 
  and cuenta_id = (select cuenta_id from cuenta_inversion where num_contrato='124884-2');

update  portafolio_inversion set porcentaje = 100 
  where tipo_portafolio_id = (select tipo_portafolio_id from tipo_portafolio where clave = 'IEFA') 
  and cuenta_id = (select cuenta_id from cuenta_inversion where num_contrato='124884-2');

update cuenta_inversion set total_portafolios = 1
  where num_contrato='124884-2';
-- C
delete from portafolio_inversion 
  where cuenta_id =(
    select cu.cuenta_id from cuenta cu ,cliente cl
    where cu.cliente_id=cl.cliente_id 
    and cl.nombre='PACO' and cl.ap_paterno='LUNA' AND cl.ap_materno = 'PEREZ'
  );

delete from cuenta_inversion 
  where cuenta_id =(
    select cu.cuenta_id from cuenta cu ,cliente cl
    where cu.cliente_id=cl.cliente_id
    and cl.nombre='PACO' and cl.ap_paterno='LUNA' AND cl.ap_materno = 'PEREZ'
  );

delete from cuenta_ahorro 
  where cuenta_id =(
    select cu.cuenta_id from cuenta cu ,cliente cl
    where cu.cliente_id=cl.cliente_id
    and cl.nombre='PACO' and cl.ap_paterno='LUNA' AND cl.ap_materno = 'PEREZ'
  );

delete from historico_estatus_cuenta
  where cuenta_id =(
    select cu.cuenta_id from cuenta cu ,cliente cl
    where cu.cliente_id=cl.cliente_id
    and cl.nombre='PACO' and cl.ap_paterno='LUNA' AND cl.ap_materno = 'PEREZ'
  );

delete from cuenta 
 where cuenta_id =(
    select cu.cuenta_id from cuenta cu ,cliente cl
    where cu.cliente_id=cl.cliente_id
    and cl.nombre='PACO' and cl.ap_paterno='LUNA' AND cl.ap_materno = 'PEREZ'
  );

update cliente set cliente_aval_id = null
  where cliente_aval_id=(
   select cliente_id from cliente 
   where nombre='PACO' and ap_paterno='LUNA' AND ap_materno = 'PEREZ'
  );

delete from cliente where nombre='PACO' and ap_paterno='LUNA' AND ap_materno = 'PEREZ';

commit;