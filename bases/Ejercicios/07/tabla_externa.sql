create table empleado_ext(
  num_empleado number(10,0),
  nombre varchar2(40)
) organization external (
   type oracle_loader
   default directory tmp_dir
   access parameters (
     records delimited by newline
     badfile tmp_dir:'empleado_ext_bad.log'
     logfile tmp_dir:'empleado_ext.log'
     fields terminated by ','
     lrtrim
     missing field values are null
     (
         num_empleado, nombre
     )
   )
   location ('empleado_ext.csv')
)
reject limit unlimited;