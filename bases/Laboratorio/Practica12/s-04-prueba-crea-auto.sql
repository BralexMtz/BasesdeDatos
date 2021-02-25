--@Autor: Brayan Alexis Martinez Vazquez y María Fernanda Maya Ortega 
--@Fecha creación: 25/01/2021
--@Descripción: Validador del ejercicio 2

set serveroutput on
Prompt insertando un nuevo auto
declare

v_auto_id auto.auto_id%type;
v_tipo auto.tipo%type;

begin

  p_crea_auto(v_auto_id,'SUZUKI','CARRY',2019,'QDFFRH2021','C',200000,45,null,null,
    null, 200, 345, 'P');
  dbms_output.put_line('Auto creado con éxito, id: '||v_auto_id);

  v_tipo := null;
  select tipo into v_tipo
  from auto where  auto_id = v_auto_id; 
  
  if(v_tipo is not null) then
    dbms_output.put_line('OK, Se realizó la inserción con éxito');
  else
    raise_application_error(-20002,'[ERROR] : La inserción del auto,'||
      ' no fue exitosa ');
  end if;

end;
/
--haciendo commit
-- En caso de no encontrar a algún registro lanzar excepción.
