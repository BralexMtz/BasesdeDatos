--@Autor: Jorge Rodriguez Campos
--@Fecha creación: dd/mm/yyyy
--@Descripción: Creación de Usuarios
create user bmv_p07_previo identified by bralex quota unlimited on users;
grant create table, create session, create sequence, create procedure to bmv_p07_previo;