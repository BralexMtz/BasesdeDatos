--@Autor(es): Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación: 09/01/2021
--@Descripción: Práctica 09 C


whenever sqlerror exit rollback;

prompt Conectando a SYS
connect sys as sysdba

prompt creando usuario

declare 
  v_cuenta  number;

begin  
  select count(*) into v_cuenta
    from all_users 
    where username = 'bmmm_p0901_fx';
  if v_cuenta = 0 then
    dbms_output.put_line('El usuario no existe');

  else
    dbms_output.put_line('El usuario ya existe');
    execute immediate
    'drop user bmmm_p0901_fx cascade';

  end if;

  dbms_output.put_line('Creando usuario');
  execute immediate
  'create user bmmm_p0901_fx identified by jorge quota unlimited on users';
  execute immediate
  'grant create session, create table, create sequence,create procedure to bmmm_p0901_fx';

  dbms_output.put_line('Usuario listo');
  
end;
/


connect bmmm_p0901_fx/jorge

@s-02-fx-ddl.sql
set define off
@s-03-fx-carga-inicial.sql
set define on

commit;