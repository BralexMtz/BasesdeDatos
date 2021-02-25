set serveroutput on

declare
v_blob_size_before number(10,0);
v_blob_size_after number(10,0);

begin

  select length(foto) into v_blob_size_before 
  from auto 
  where auto_id=3;

  sp_actualiza_foto_auto(3,0);

  select length(foto) into v_blob_size_after from auto where auto_id=3;
  if v_blob_size_before <> v_blob_size_after then
    dbms_output.put_line('La imagen se actualizó con exito');
  else
    raise_application_error(-20001, 'La imagen no se pudo actualizar'); 
  end if;

end;
/

rollback;
