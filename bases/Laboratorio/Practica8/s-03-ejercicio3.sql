--@Autor(es):       Maria Fernanda Maya Ortega, Brayan Alexis Martinez Vazquez
--@Fecha creación:  19/12/2020
--@Descripción:     ejercicio 3 de la practica 8


insert into ESTATUS_CUENTA(estatus_cuenta_id, clave, descripcion, activo) 
  values (1,'ABIERTA','Cuenta válida y vigente',1);

insert into ESTATUS_CUENTA(estatus_cuenta_id, clave, descripcion, activo) 
  values (2,'SUSPENDIDA','Cuenta que no permite movimientos por un 
  periodo determinado',1);

insert into ESTATUS_CUENTA(estatus_cuenta_id, clave, descripcion, activo) 
  values (3,'CONGELADA','Cuenta que no permite movimientos por tiempo indefinido',1); 

--Llenar la tabla de Bancos

insert into BANCO(banco_id, nombre) 
  values (60,'BMEX');

insert into BANCO(banco_id, nombre) 
  values (61,'BANCA PLUS');

insert into BANCO(banco_id, nombre) 
  values (62,'BANEXITO');

--LLENAR TABLA TIPOS PORTAFOLIO
insert into TIPO_PORTAFOLIO(tipo_portafolio_id, clave, nombre, activo) 
  values (100,'IEFA','Renta variable internacional',1);

insert into TIPO_PORTAFOLIO(tipo_portafolio_id, clave, nombre, activo) 
  values (200,'IVV','Renta variable de los Estados Unidos',1);

insert into TIPO_PORTAFOLIO(tipo_portafolio_id, clave, nombre, activo) 
  values (300,'IEMG','Renta variable internacional Global',1);

--insertar nuevo cliente
 --NO SE SI SE PONE O NO EL AVAL ARRIBA
insert into CLIENTE(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id) 
  values (cliente_seq.nextval,'GERARDO','LARA','URSUL','LAURGE891101HDF003', TO_DATE('01/11/1989', 'dd/mm/yyyy'), 'gerardo@mail.com',null);
-- inciso E

insert into CLIENTE(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id) 
  values (cliente_seq.nextval,'PACO','LUNA','PEREZ','LUPEPA900401HDF009', TO_DATE('01/04/1990', 'dd/mm/yyyy'), 'paco@mail.com',null);

insert into CUENTA(cuenta_id,num_cuenta,tipo,saldo,fecha_estatus,estatus_cuenta_id,banco_id,cliente_id)
  values(cuenta_seq.nextval,903903,'A',5500.5,sysdate, 1, 60,cliente_seq.currval);

insert into CUENTA_AHORRO(cuenta_id, nip_cajero, num_tarjeta_debito, limite_retiro)
  values(cuenta_seq.currval, 9990,'1657090812110000',10000);

insert into HISTORICO_ESTATUS_CUENTA(historico_estatus_cuenta_id,fecha_estatus,cuenta_id, estatus_cuenta_id)
  values(hist_estatus_cta_seq.nextval, TO_DATE('10/10/2009 09:40:55','dd/mm/yyyy HH24:MI:SS'),cuenta_seq.currval,1);

-- inciso F
insert into CLIENTE(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id) 
  values (cliente_seq.nextval,'HUGO','MORA','PAZ','MOPAHU010922HDF005', TO_DATE('22/09/2001', 'dd/mm/yyyy'), null,(
    select cliente_id from cliente where nombre='PACO' and ap_paterno='LUNA'
  ));

insert into CUENTA(cuenta_id,num_cuenta,tipo,saldo,fecha_estatus,estatus_cuenta_id,banco_id,cliente_id)
    values(cuenta_seq.nextval,903904,'I',1000000,TO_DATE('14/02/2017 17:00:00','dd/mm/yyyy HH24:MI:SS'), 3, 62,cliente_seq.currval);

insert into HISTORICO_ESTATUS_CUENTA(historico_estatus_cuenta_id,fecha_estatus,cuenta_id, estatus_cuenta_id)
  values(hist_estatus_cta_seq.nextval, TO_DATE('01/01/2016 17:00:00','dd/mm/yyyy HH24:MI:SS'),cuenta_seq.currval,1);

insert into HISTORICO_ESTATUS_CUENTA(historico_estatus_cuenta_id,fecha_estatus,cuenta_id, estatus_cuenta_id)
  values(hist_estatus_cta_seq.nextval, TO_DATE('14/02/2017 17:00:00','dd/mm/yyyy HH24:MI:SS'),cuenta_seq.currval,3);

insert into cuenta_inversion(cuenta_id, num_contrato, fecha_contrato, total_portafolios)
  values(cuenta_seq.currval,'124884-2',TO_DATE('31/12/2018','dd/mm/yyyy'),2);

insert into portafolio_inversion(tipo_portafolio_id,cuenta_id, porcentaje,plazo)
  values(100,cuenta_seq.currval,50,6);

insert into portafolio_inversion(tipo_portafolio_id,cuenta_id, porcentaje,plazo)
  values(200,cuenta_seq.currval,50,6);

-- G

insert into CLIENTE(cliente_id, nombre, ap_paterno, ap_materno, curp, fecha_nacimiento, email, cliente_aval_id) 
  values (cliente_seq.nextval,'SARA','OLMOS','GUTIERREZ','GUOLSA790203HDFG00', TO_DATE('03/02/1979', 'dd/mm/yyyy'), 'sara@gmail.com',(
    select cliente_id from cliente where nombre='PACO' and ap_paterno='LUNA'
  ));

insert into CUENTA(cuenta_id,num_cuenta,tipo,saldo,fecha_estatus,estatus_cuenta_id,banco_id,cliente_id)
    values(cuenta_seq.nextval,903911,'A',5000,TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy HH24:MI:SS'), 1, 62,cliente_seq.currval);

insert into CUENTA_AHORRO(cuenta_id, nip_cajero, num_tarjeta_debito, limite_retiro)
  values(cuenta_seq.currval, 8888,'1450678300097777',25000);

insert into HISTORICO_ESTATUS_CUENTA(historico_estatus_cuenta_id,fecha_estatus,cuenta_id, estatus_cuenta_id)
  values(hist_estatus_cta_seq.nextval, TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy HH24:MI:SS'),cuenta_seq.currval,1);


insert into CUENTA(cuenta_id,num_cuenta,tipo,saldo,fecha_estatus,estatus_cuenta_id,banco_id,cliente_id)
    values(cuenta_seq.nextval,903912,'I',5000,TO_DATE('18/10/2017 11:51:05','dd/mm/yyyy HH24:MI:SS'), 3, 62,cliente_seq.currval);

insert into cuenta_inversion(cuenta_id, num_contrato, fecha_contrato, total_portafolios)
  values(cuenta_seq.currval,'133478-3',TO_DATE('19/09/2017','dd/mm/yyyy'),1);

insert into HISTORICO_ESTATUS_CUENTA(historico_estatus_cuenta_id,fecha_estatus,cuenta_id, estatus_cuenta_id)
  values(hist_estatus_cta_seq.nextval, TO_DATE('18/09/2017 11:51:05','dd/mm/yyyy HH24:MI:SS'),cuenta_seq.currval,1);

insert into HISTORICO_ESTATUS_CUENTA(historico_estatus_cuenta_id,fecha_estatus,cuenta_id, estatus_cuenta_id)
  values(hist_estatus_cta_seq.nextval, TO_DATE('18/10/2017 11:51:05','dd/mm/yyyy HH24:MI:SS'),cuenta_seq.currval,3);

insert into portafolio_inversion(tipo_portafolio_id,cuenta_id, porcentaje,plazo)
  values(300,cuenta_seq.currval,100,2);

COMMIT;


