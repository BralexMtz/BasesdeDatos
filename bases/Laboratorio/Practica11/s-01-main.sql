
--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  19/01/2021
--@Descripción:     Practica 11




whenever sqlerror exit rollback;

Prompt conectando como sys
connect sys/system as sysdba



Prompt 1. Creando usuario P11
create user mama_p1101_subastas identified by jorge quota unlimited on users;
grant create session,create table, create synonym, create procedure, create sequence 
to mama_p1101_subastas;

Prompt 2. Otorgar permisos para operaciones select
grant select on mama_p1001_subastas.articulo to mama_p1101_subastas;
grant select on mama_p1001_subastas.articulo_arqueologico to mama_p1101_subastas;
grant select on mama_p1001_subastas.articulo_donado to mama_p1101_subastas;
grant select on mama_p1001_subastas.articulo_famoso to mama_p1101_subastas;
grant select on mama_p1001_subastas.cliente to mama_p1101_subastas;
grant select on mama_p1001_subastas.entidad to mama_p1101_subastas;
grant select on mama_p1001_subastas.factura_cliente to mama_p1101_subastas;
grant select on mama_p1001_subastas.historico_status_articulo to mama_p1101_subastas;
grant select on mama_p1001_subastas.pais to mama_p1101_subastas;
grant select on mama_p1001_subastas.status_articulo to mama_p1101_subastas;
grant select on mama_p1001_subastas.subasta to mama_p1101_subastas;
grant select on mama_p1001_subastas.subasta_venta to mama_p1101_subastas;
grant select on mama_p1001_subastas.tarjeta_cliente to mama_p1101_subastas;

Prompt conectando como mama_p1101_subastas
connect mama_p1101_subastas/jorge

Prompt 3. Creando sinonimos

create or replace synonym articulo for mama_p1001_subastas.articulo;
create or replace synonym articulo_arqueologico for mama_p1001_subastas.articulo_arqueologico;
create or replace synonym articulo_donado for mama_p1001_subastas.articulo_donado;
create or replace synonym articulo_famoso for mama_p1001_subastas.articulo_famoso;
create or replace synonym cliente for mama_p1001_subastas.cliente;
create or replace synonym entidad for mama_p1001_subastas.entidad;
create or replace synonym factura_cliente for mama_p1001_subastas.factura_cliente;
create or replace synonym historico_status_articulo for mama_p1001_subastas.historico_status_articulo;
create or replace synonym pais for mama_p1001_subastas.pais;
create or replace synonym status_articulo for mama_p1001_subastas.status_articulo;
create or replace synonym subasta for mama_p1001_subastas.subasta;
create or replace synonym subasta_venta for mama_p1001_subastas.subasta_venta;
create or replace synonym tarjeta_cliente for mama_p1001_subastas.tarjeta_cliente;
commit;
whenever sqlerror continue none