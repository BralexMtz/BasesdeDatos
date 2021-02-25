--@Autor(es): Brayan Alexis Martínez Vázquez María Fernanda Maya Ortega
--@Fecha creación: 13/11/2020
--@Descripción: Creacion de usuarios y roles
set verify off
set feedback off
set serveroutput on
whenever sqlerror exit rollback


prompt Proporcionar el password del usuario sys:
connect sys as sysdba
-- CREACION DE ROLES
prompt creando rol p0702_admin_rol
create role p0702_admin_rol;
grant create session, create table, create view to p0702_admin_rol;

prompt creando rol p0702_basic_rol
create role p0702_basic_rol;
grant create session, create table to p0702_basic_rol;

prompt creando rol p0702_guest_rol
create role p0702_guest_rol;
grant create session, create synonym to p0702_guest_rol;

--CREACION DE USUARIOS
prompt creando al usuario bmv_p0702_admin 
create user bmv_p0702_admin identified by brayan quota 1024M on users;
--asignando rol
grant p0702_admin_rol to bmv_p0702_admin;

prompt creando al usuario bmv_p0702_oper 
create user bmv_p0702_oper identified by brayan quota 500M on users;
--asignando rol
grant p0702_basic_rol to bmv_p0702_oper;

prompt creando al usuario bmv_p0702_invitado 
create user bmv_p0702_invitado identified by brayan; 
--asignando rol
grant p0702_guest_rol to bmv_p0702_invitado;


-- ASIGNANDO PRIVILEGIOS ADICIONALES
grant create procedure, create sequence to bmv_p0702_admin;
grant create procedure, create sequence to bmv_p0702_oper;
grant create procedure, create sequence to bmv_p0702_invitado;

rollback;
prompt Listo!
exit;
-- Para ejecutar en la carpeta del script, entrar nolog
-- $> sqlplus /nolog
-- -SQL> !ls
-- -SQL> start s-01-usuarios.sql
-- -SQL> @s-01-usuarios.sql
--  