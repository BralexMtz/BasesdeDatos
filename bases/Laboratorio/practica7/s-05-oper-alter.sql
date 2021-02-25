
alter table empleado drop(tipo);
alter table empleado add es_temporal number(1,0) not null;
alter table empleado add es_becario number(1,0) not null;
alter table empleado add es_permanente number(1,0) not null;



alter table empleado modify sueldo_mensual number(8,2);
alter table empleado add constraint empleado_sueldo_mensual_chk check(SUELDO_MENSUAL<=100000);

alter table empleado add supervisor_id constraint empleado_empleado_supervisor_fk references empleado(empleado_id) null;

alter table status_becario rename column status_id to status_becario_id;

alter table status_becario drop(empleado_id);
alter table becario add status_becario_id constraint becario_status_becario_id_fk references status_becario(status_becario_id) not null;


alter table becario add fecha_status date not null;

alter table permanente add constraint num_contrato_chk 
check(
  substr(num_contrato,1,3)='EPE' and 
  validate_conversion(substr(num_contrato,4,13) as number)=1
);

alter table temporal modify fecha_fin date ;

alter table pago_emp drop constraint PAGO_EMP_PK;
alter table pago_emp add pago_emp_id number(10,0) constraint pago_emp_id_pk primary key;

create index pago_emp_empleado_id_num_pago_uk on pago_emp(empleado_id,NUM_PAGO);

alter table empleado rename column FECHA_NAC to fecha_nacimiento;

alter table pago_emp rename to pago_empleado;

alter sequence SEQ_EMPLEADO 
  increment by 2
  minvalue 6
  nocycle
  cache 4;
