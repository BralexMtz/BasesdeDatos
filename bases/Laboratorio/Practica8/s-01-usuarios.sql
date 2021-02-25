--@Autor(es): María Fernanda Maya Ortega, Brayan Alexis Martinez Vazquez
--@Fecha creación: 19/12/2020
--@Descripción: Crea usuario y le da permisos 

prompt Escribir password de system:
connect sys as sysdba

create user mama_p0802_cuentas identified by jorge quota unlimited on users;
grant create session, create table, create sequence, create procedure to mama_p0802_cuentas;

