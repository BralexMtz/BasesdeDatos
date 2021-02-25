--@Autor: Jorge Rodriguez Campos
--@Fecha creación: dd/mm/yyyy
--@Descripción: Archivo principal
whenever sqlerror exit rollback;
prompt conectando como sys para eliminar/crear al usuario
connect sys as sysdba
prompt eliminando al usuario bmv_p07_previo en caso de existir
start s-00-asignaturas-elimina-usuarios.sql
-- completar
prompt creando usuario bmv_p07_previo
start s-01-asignaturas-crea-usuarios.sql

--completar
prompt conectando como usuario bmv_p07_previo
connect bmv_p07_previo/bralex

--completar con el comando connect
prompt creando tablas
start s-02-asignaturas-ddl.sql

--completar
prompt cargando datos
start s-03-asignaturas-carga-inicial.sql

--completar
prompt Listo!