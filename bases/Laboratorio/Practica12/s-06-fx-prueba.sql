--@Autor: Brayan Alexis Martinez Vazquez y María Fernanda Maya Ortega 
--@Fecha creación: 26/01/2021
--@Descripción: Bloque anonimo que crea un auto

set serveroutput on
Prompt generando reportes CSV
declare
  v_cadena_obtenida varchar(4000);
  v_cadena_esperada varchar2(4000) :='1,DFQ523710JRNWD144771,P,850280.08,8,N/A,6542.46,dcromar5f@smh.com.au';
begin
  --invocar a la función
  select exporta_datos_auto_csv_fx(1,2) into v_cadena_obtenida from dual;
  -- comparar las cadenas
  if v_cadena_esperada = v_cadena_obtenida then
    dbms_output.put_line('OK, prueba exitosa');
  else
    raise_application_error(-20001,'Las cadenas no coinciden: Cadena esperada '
      ||v_cadena_esperada ||' Cadena obtenida:' ||v_cadena_obtenida);
end if;
end;
/