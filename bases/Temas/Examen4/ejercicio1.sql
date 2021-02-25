
select nombre,sinopsis
(
  (
    select * 
    from obra o
    where o.tipo='T'
    intersect 
    select *
    from obra o
    where o.costo_boleto>1000
  )
  minus
  select *
  from obra o
  where o.status_obra_id = 4
);



obras, y representacion:
nombre, sinopsis
fecha de presentacion
clave_sala representacion - 
con status PR

select o.nombre, o.sinopsis, r.fecha_representacion, s.clave
from obra o
left join representacion r
on o.obra_id=r.obra_id
left join sala s
on s.recinto_id=r.recinto_id, s.num_sala=r.num_sala
join status_obra s
on s.status_obra_id=o.status_obra_id
where s.clave='PR';

---

select obra_id,o.nombre "nombre obra", p.nombre "nombre personaje", 
  actor_id, a.nombre "nombre actor"
from obra o
natural join teatral t
join personaje p using(obra_id)
join actor a using(actor_id)
where o.tipo='T'
  and p.genero='F';


select a.nombre, ad.rfc
from actor a
left join actor ad
on a.suplente_id=ad.actor_id
join monologo m
on ad.actor_id=m.actor_id;

---



select o.nombre, o.sinopsis, o.tipo, sum(r.num_asistentes) "total_asistentes"
from obra o, representacion r
where o.obra_id=r.obra_id
and to_char(r.fecha_representacion,'mm-yyyy')='06-2014'
group by o.nombre, o.sinopsis, o.tipo
having sum(r.num_asistentes)<1000;


select o.nombre,r.fecha_representacion,r.num_asistentes,(
  select avg(r.num_asistentes)
  from representacion r
  where r.obra_id=13
)  as num_personas
from obra o
join representacion r
on o.obra_id=r.obra_id
where o.obra_id=13;

-- 

select ax.*, pa.fecha_pago, pa.importe
from actor ax, pago_actor pa, (
  select a.*, max(importe) as max_importe
  from pago_actor pa
  join actor a
  where pa.actor_id=a.actor_id
  and a.actor_id=ax.actor_id
  group by a.actor_id, a.nombre, a.ap_pat, a.ap_mat, a.curp, a.rfc, a.fecha_ingreso, 
  a.genero, a.suplente_id
) q1
where pa.importe=q1.max_importe
and  ax.actor_id=pa.actor_id
and q1.actor_id=ax.actor_id;






select c.*
from credencial c
where c.fecha_expedicion = (
  select max(c2.fecha_expedicion)
  from credencial c2
);

--

create or replace trigger tr_cambio_credito
before 
update of limite_credito 
on tarjeta
  cur_movimientos_sin_pagar is
  select num_mov, importe 
  from movimiento m
  where m.tipo='c'
  and m.tarjeta_id=:old.tarjeta_id
  and m.pagado=0;
begin
  if(:new.limite_credito < :old.limite_credito ) then

    update tarjeta set validado=1 where tarjeta_id=:old.tarjeta_id;

  elsif (:old.limite_credito = :new.limite_credito)
    or (:new.limite_credito < 0) then

    raise_application_error(-20011,'El nuevo valor del limite credito es incorrecto');

  elsif (:new.limite_credito > :old.limite_credito) then

    for m in cur_movimientos_sin_pagar loop
      insert into reporte_cliente(reporte_cliente_id,num_mov,importe,tarjeta_id) 
      values(reporte_cliente_seq,m.num_mov,m.importe,:old.tarjeta_id);
    end loop;

  end if;
end;
/
show errors


begin 

update tarjeta set limite_credito=30000 
where tarjeta_id=1;

end;
/

---