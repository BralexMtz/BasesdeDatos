-- HEADER DEL PROFE


prompt conectando como sys
connect sys as sysdba

prompt creando usuario.
create user mama_p1001_subastas identified by jorge quota unlimited on users;
-- 
grant create session, create table, create procedure, create sequence to mama_p1001_subastas;

prompt conectando con el usuario mama_p1001_subastas

connect mama_p1001_subastas/jorge

--- crear tablas 
start s-02-ddl.sql 

--cargar datos
start s-03-carga-inicial.sql

-- confirmando carga de datos
commit;






