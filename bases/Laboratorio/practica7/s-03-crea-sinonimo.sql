--Conetando a asystem
prompt Proporcionar el password de sysdba
connect sys as sysdba

--Otorgando permisos
grant  create synonym to bmv_p0702_invitado;

prompt Proporcionar el password del usuario bmv_p0702_admin
connect bmv_p0702_admin

grant select on solicitante to bmv_p0702_invitado;

--Creando los sinónimos
prompt Proporcionar el password del usuario bmv_p0702_invitado
connect bmv_p0702_invitado

create or replace synonym s_persona for bmv_p0702_admin.solicitante;

prompt Listo!