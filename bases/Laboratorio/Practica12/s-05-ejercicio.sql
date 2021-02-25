create or replace function exporta_datos_auto_csv_fx(
    p_auto_id number,
    p_num_pago number
) return varchar2 is
  cursor cur_datos is
  select  a.auto_id, a.num_serie, a.tipo, a.precio, ap.num_cilindros, ac.peso_maximo, 
    pa.importe, c.email
    from AUTO a, auto_particular ap, auto_carga ac, cliente c, pago_auto pa
    where  a.auto_id=ap.auto_id(+)
      and a.auto_id=ac.auto_id(+)
      and c.cliente_id=a.cliente_id
      and a.auto_id=pa.auto_id
      and pa.auto_id=p_auto_id
      and pa.num_pago=p_num_pago;
    v_str varchar2(300);
begin

    for a in cur_datos loop
      if cur_datos%found then
        v_str := a.auto_id||','
          ||a.num_serie
          ||','
          ||a.tipo
          ||','
          ||a.precio
          ||','
          ||nvl(to_char(a.num_cilindros),'N/A')
          ||','
          ||nvl(to_char(a.peso_maximo),'N/A')
          ||','
          ||a.importe
          ||','
          ||a.email;
     else
       v_str:='';
     end if;            
    end loop;

    return v_str;
  
end;
/
show errors