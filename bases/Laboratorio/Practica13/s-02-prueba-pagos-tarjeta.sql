--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  31/01/2021
--@Descripción:     Bloque anonimo para probar el procedimiento sp_genera_pagos_tajeta

set serveroutput on
declare
  v_importe number(8,2);
  
  v_suma_total_antes number;  
  v_suma_total_despues number;
  v_num_pagos number(4,0);
  cursor cur_autos_falta_pago is
    select a.auto_id, a.precio, sum(pa.importe) as total_pagado
    from cliente c
    join tarjeta_cliente tc
    on c.cliente_id=tc.cliente_id
    join auto a
    on a.cliente_id=c.cliente_id
    left join pago_auto pa
    on pa.auto_id=a.auto_id
    group by a.AUTO_ID,a.precio;

  
begin
    v_importe:=100;
    
    dbms_output.put_line('COMENZANDO PRUEBA   ');

    select sum(sum(pa.importe)) into v_suma_total_antes
    from cliente c
    join tarjeta_cliente tc
    on c.cliente_id=tc.cliente_id
    join auto a
    on a.cliente_id=c.cliente_id
    left join pago_auto pa
    on pa.auto_id=a.auto_id
    group by a.AUTO_ID,a.precio;
    
    for auto in cur_autos_falta_pago loop
      if auto.total_pagado < auto.precio or auto.total_pagado is null then
        if auto.precio < auto.total_pagado + v_importe then
          v_suma_total_antes :=v_suma_total_antes+(auto.precio-auto.total_pagado);
        else
          v_suma_total_antes :=v_suma_total_antes + v_importe;
        end if;
      end if;
    end loop;
    
    sp_genera_pagos_tarjeta(v_importe);
     
       
    select sum(sum(pa.importe)) into v_suma_total_despues
    from cliente c
    join tarjeta_cliente tc
    on c.cliente_id=tc.cliente_id
    join auto a
    on a.cliente_id=c.cliente_id
    left join pago_auto pa
    on pa.auto_id=a.auto_id
    group by a.AUTO_ID,a.precio
    having sum(pa.importe) <= a.precio;


    if v_suma_total_antes=v_suma_total_despues then
      dbms_output.put_line('OK Prueba exitosa!');
    else    
      dbms_output.put_line('[ERROR] El resultado es '|| v_suma_total_despues ||' es diferente al esperado '||v_suma_total_antes);
    end if;
    
end;
/

rollback;


