--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  25/01/2021
--@Descripción:     Practica 12, Archivo Principal

--si ocurre un error, se hace rollback de los datos y
--se sale de SQL *Plus
whenever sqlerror exit rollback
Prompt creando usuario mama_p1201_autos
@s-01-creacion-usuario.sql
Prompt conectando como usuario mama_p1201_autos
connect mama_p1201_autos
Prompt creando objetos
@s-02-autos-ddl.sql
Prompt realizando la carga de datos
@s-03-agencia.sql
@s-03-cliente.sql
@s-03-tarjeta-cliente.sql
@s-03-status-auto.sql
@s-03-auto.sql
@s-03-auto-carga.sql
@s-03-auto-particular.sql
@s-03-historico-status-auto.sql
@s-03-pago-auto.sql
Prompt confirmando cambios
commit;
--Si se encuentra un error, no se sale de SQL *Plus
--no se hace commit ni rollback, es decir, se
--regresa al estado original.
whenever sqlerror continue none
Prompt Listo!