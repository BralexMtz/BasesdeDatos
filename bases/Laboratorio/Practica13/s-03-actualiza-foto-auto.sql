--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  31/01/2021
--@Descripción:     Procedimiento para cargar fotos del SO en la bd.


connect sys as sysdba
prompt creando objeto

create or replace directory fotos_dir as '/home/bralex/Desktop/bd/Bases\ de\ datos/Laboratorio/Practica13/autos/';

prompt otorgando permisos de lectura al usuario

grant read on directory fotos_dir to mama_p1201_autos;

prompt connectando con mama_p1201_autos

connect mama_p1201_autos/ jorge


create or replace procedure sp_actualiza_foto_auto (
  p_auto_id_inicio in number,
  p_num_imagenes in number
) is 

cursor cur_autos is
  select auto_id
  from auto
  where auto_id between p_auto_id_inicio
    and (p_auto_id_inicio + p_num_imagenes);

v_nombre_foto varchar2(30);
--Rferencia/puntero al archivop
v_bfile bfile;
v_foto blob;

--Se requieren porque le procedimiento necesita la salida
v_src_offset number;
v_dest_offset number;
v_src_length number;
v_blob_length number;

begin 
  for r in cur_autos loop
    v_nombre_foto :='auto-'||r.auto_id||'.jpg';
    v_bfile :=bfilename('FOTOS_DIR',v_nombre_foto);

    if dbms_lob.fileexists(v_bfile) = 0 then 
      raise_application_error(-20001, 'El archivo '||v_nombre_foto
        ||' no existe en el objeto fotos_dir');
    end if;

    if dbms_lob.fileisopen(v_bfile) = 1 then
      raise_application_error(-20002, 'El archivo esta abierto, debe estar cerrado');
    end if;


-- se usa for update para evitar que otros usuarios intenten escribir o leer en la 
-- columna foto

    select foto into v_foto
    from auto 
    where auto_id = r.auto_id
    for update;

    dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
    v_src_offset :=1;
    v_dest_offset := 1;
    v_src_length := dbms_lob.getlength(v_bfile);

   --Se lee el contenido completo del archivo ya que su tamañao es pequeño
   --para archivos grandes la caraga debe ser por partes para evitar
   --matar a la RAM

    dbms_lob.loadblobfromfile(
        dest_lob   => v_foto, 
        src_bfile  => v_bfile,
        amount     => v_src_length,
        src_offset => v_src_offset,
        dest_offset=> v_dest_offset
    );
    --cerrando el archivo
    dbms_lob.close(v_bfile);

    --Verificando la cantidad de bytes escritos en el objeto blob
    v_blob_length := dbms_lob.getlength(v_foto);

    if v_src_length = v_blob_length then
    --todo bien
    dbms_output.put_line('Carga exitosa, para la foto: '
      ||v_nombre_foto
      ||', auto_id: '
      ||r.auto_id
      ||', cantidad de bytes: '
      ||v_blob_length);
    else
      --ERROR!
      raise_application_error(-20003, 
        'Longitud cargada en la columna foto inválida para el auto_id: '||r.auto_id);
    end if;


  end loop;

end;
/
show errors