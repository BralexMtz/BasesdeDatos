--@Autor(es):       Jorge Rodríguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:    Práctica 9 - Validador, script inicial.

--Modificar las siguientes variables en caso de ser necesario.
--En scripts reales no debeń incluirse passwords. Solo se hace para
--propósitos de pruebas y evitar escribirlos cada vez que se quiera ejecutar 
--el proceso de validación de la práctica (propósitos académicos).

--
-- Nombre del usuario empleado en esta práctica
--
define p_usuario='jrc_p0901_algebra'

--
-- Password del usuario empleado en esta práctica
--
define p_usuario_pass='jorge'

--
-- Password del usuario sys
--
define p_sys_password='system'

--
-- Nombre del archivo de respuestas
--
define p_archivo_respuestas='s-04-algebra-respuestas.sql'


--- ============= Las siguientes configuraciones ya no requieren cambiarse====

whenever sqlerror exit rollback
set verify off
set feedback off

Prompt =========================================================
Prompt Iniciando validador - Práctica 9
Prompt Presionar Enter si los valores configurados son correctos.
Prompt De lo contario editar el archvo s-05-validador-algebra-main.sql
Prompt O en su defecto proporcionar nuevos valores
Prompt =========================================================

accept p_usuario default &&p_usuario  prompt '* Nombre de usuario de la práctica [&&p_usuario]: '
accept p_usuario_pass default  &&p_usuario_pass  prompt '* Password para &p_usuario [configurado en script]: ' hide
accept p_sys_password default '&&p_sys_password' prompt '* Password de sys [configurado en script]: ' hide
accept p_archivo_respuestas default '&&p_archivo_respuestas' Prompt '* Archivo de respuestas [&&p_archivo_respuestas]: ' 

define p_archivo_validador ='s-05p-validador-algebra-relacional.plb'

@@&&p_archivo_validador

exit