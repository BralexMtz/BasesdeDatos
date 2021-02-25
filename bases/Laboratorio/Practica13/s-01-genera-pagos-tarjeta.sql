--@Autor(es):       Brayan Alexis Martinez Vazquez, Maria Fernanda Maya Ortega
--@Fecha creación:  31/01/2021
--@Descripción:     Procedimiento para generar pagos en una tarjeta.

set serveroutput on      
create or replace procedure sp_genera_pagos_tarjeta(
  p_importe in number ) is

  cursor cur_auto_ids is
  select a.auto_id, a.precio, sum(pa.importe) as total_pagado
  from cliente c
  join tarjeta_cliente tc
  on c.cliente_id=tc.cliente_id
  join auto a
  on a.cliente_id=c.cliente_id
  left join pago_auto pa
  on pa.auto_id=a.auto_id
  group by a.AUTO_ID,a.precio;
  
  
  v_num_pago_actual number(5,0);
  v_num_pagos number(4,0);
  v_valida_pago_auto_fk number(4,0);
  v_pago number(7,2);
  v_devolucion number(8,2);
begin
  
  v_num_pagos:=0;
  

  for a_id in cur_auto_ids loop
    
    if a_id.total_pagado < a_id.precio or a_id.total_pagado is null then
      select count(pa.num_pago) into v_valida_pago_auto_fk
      from auto a
      join pago_auto pa
      on a.auto_id=pa.auto_id
      where a.auto_id=a_id.auto_id;

      if v_valida_pago_auto_fk > 0 then
      -- sacar el ultimo numero de pago
        select max(num_pago) into v_num_pago_actual
        from pago_auto pa 
        where pa.AUTO_ID=a_id.auto_id;
      
      -- le sumamos uno
        v_num_pago_actual:=v_num_pago_actual+1;
      else
        v_num_pago_actual:=1;
      end if;  

      if a_id.total_pagado is null then 
        -- no se si se pueda 
        a_id.total_pagado:=0 ;
      end if;

      if p_importe > (a_id.precio-a_id.total_pagado) then
        v_pago:=a_id.precio-a_id.total_pagado;
        v_devolucion:=p_importe-v_pago;
      else
        v_pago:=p_importe;
        v_devolucion:=null;
      end if;
    

      insert into pago_auto(num_pago,auto_id,fecha_pago,importe,importe_devolucion)
      values(v_num_pago_actual, a_id.auto_id, sysdate, v_pago, v_devolucion);
      -- Contar la cantidad de pagos que se hacen 
      v_num_pagos:=v_num_pagos+1;

    end if; 
  end loop;  
  
  dbms_output.put_line('TOTAL DE PAGOS REGISTRADOS: '||v_num_pagos );
  dbms_output.put_line('IMPORTE TOTAL DE LOS PAGOS REGISTRADOS: '|| (v_num_pagos*p_importe) );

end;
/
show errors