--@Autor(es): Brayan Alexis Martínez Vázquez María Fernanda Maya Ortega
--@Fecha creación: 13/11/2020
--@Descripción: Creacion de objetos
set verify off
set feedback off
set serveroutput on
whenever sqlerror exit rollback


prompt Proporcionar el password del usuario bmv_p0702_admin
connect bmv_p0702_admin



create sequence seq_visa 
  start with 5
  increment by 4
  cache 6
  nocycle;

select seq_visa.nextval from dual;

select seq_visa.currval from dual;


-- creando tabla certificacion
create table certificacion(
  certificacion_id number(10,0) constraint certificacion_pk primary key,
  clave varchar2(10) not null,
  nombre varchar2(40) not null,
  descripcion varchar2(400) not null,
  puntos_requeridos number(4,0) not null
);

-- crear tabla visa
create table visa(
  visa_id number(10,0) constraint visa_pk primary key,
  folio varchar2(18) not null constraint visa_folio_uk unique,
  es_turista number(1,0) not null,
  es_laboral number(1,0) not null,
  foto blob not null,
  visa_anterior_id constraint visa_visa_ant_id_fk references visa(visa_id),   
  constraint visa_es_turista_chk check( 
    (substr(folio,1,1)='T' and  es_turista=1 and es_laboral = 0 ) or
    (substr(folio,1,1)='L' and  es_turista=0 and es_laboral = 1 ) or
    (substr(folio,1,1)='A' and  es_turista=1 and es_laboral = 1 )
    ) 
);


create table visa_turista(
  visa_id constraint visa_turista_fk references visa(visa_id),
  fecha_inicio date not null,
  fecha_fin date not null, 
  dias_tolerancia number(2,0) not null,
  constraint visa_turista_fecha_fin_chk check(fecha_fin > fecha_inicio),
  constraint visa_turista_visa_id_pk primary key(visa_id)
);




create table visa_laboral(
  visa_id constraint visa_laboral_fk references visa(visa_id),
  fecha_inicio_labores date not null,
  empresa varchar2(40) not null,
  num_trabajador varchar2(18)  not null,
  nss varchar2(13) not null,
  observaciones varchar2(4000) not null,
    constraint visa_laboral_visa_id_pk primary key(visa_id)

);

create unique index visa_laboral_num_trabajador_nss on visa_laboral(num_trabajador, nss);

create or replace view v_visa_laboral(
  visa_id,foto,empresa,num_trabajador,nss
) as select v.visa_id,v.foto,vl.empresa,vl.num_trabajador,vl.nss 
  from visa v, visa_laboral vl
  where v.visa_id=vl.visa_id;


-- creando tabla solicitante
create table solicitante(
    solicitante_id number(10,0) not null constraint solicitante_pk primary key,
    nombre varchar2(40) not null,
    ap_paterno varchar2(40) not null,
    ap_materno varchar2(40),
    fecha_nacimiento date not null,
    fecha_solicitud date not null,
    visa_id constraint solicitante_visa_id_fk references visa(visa_id)
);

create index solicitante_nombre_ix on solicitante(upper(nombre));
create index solicitante_fecha_solicitud_ix on solicitante(to_char(fecha_solicitud,'DD/MM/YYYY'));
create index solicitante_visa_id_ix on solicitante(visa_id);


create table solicitante_certificacion(
    certificacion_id constraint solicitante_certificacion_certificacion_id_fk references certificacion(certificacion_id),
    solicitante_id constraint solicitante_certificacion_solicitante_id_fk references solicitante(solicitante_id),
    calificacion number(3,1) not null constraint solicitante_certificacion_calificacion_chk check (calificacion between 6.0 and 10.0),
    constraint solicitante_certificacion_pk primary key  (certificacion_id,solicitante_id)
);



commit;
prompt Listo!
