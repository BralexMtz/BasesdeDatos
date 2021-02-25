--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  25/01/2021
--@Descripción:     Practica 12 Main 

whenever sqlerror exit rollback;

prompt Conectando a SYS
connect sys as sysdba

prompt creando usuario

declare 
  v_cuenta  number;

begin  
  select count(*) into v_cuenta
    from all_users 
    where username = 'MAMA_P1201_AUTOS';
  if v_cuenta = 0 then
    dbms_output.put_line('El usuario no existe');

  else
    dbms_output.put_line('El usuario ya existe');
    execute immediate
    'drop user MAMA_P1201_AUTOS cascade';

  end if;

  dbms_output.put_line('Creando usuario');
  execute immediate
  'create user MAMA_P1201_AUTOS identified by jorge quota unlimited on users';
  execute immediate
  'grant create session, create table, create sequence,create procedure, create trigger to MAMA_P1201_AUTOS';

  dbms_output.put_line('Usuario listo');
  
end;
/