create table competencia(
    competencia_id  number(10,0) constraint competencia_pk primary key,
    fecha_incio     date default sysdate, 
    tipo            varchar2(1) not null,
    folio           varchar2(6) not null,
    constraint competencia_tipo_chk check(tipo in('I','E')),
    constraint competencia_folio_chk check(
        substr(folio,1,1) = 'C' and substr(folio,2,1)=tipo and substr(folio,3,4)=to_char(fecha_incio,'YYYY')
    ),
    constraint competencia_folio_tipo_uk unique(folio,tipo)
);

create table competencia_interna(
    competencia_id number(10,0) not null constraint competencia_interna_pk primary key,
    competencia_ant_id constraint competencia_interna_id_fk references competencia_interna(competencia_id),
    ingresos        number(8,2) not null,
    ganancia        number(8,2) generated always as (ingresos*0.15) virtual not null,
    constraint competencia_interna_competencia_id_fk foreign key(competencia_id)
    references competencia(competencia_id)
);

create table jugador_competencia(
    jugador_id number(10,0) not null constraint jugador_competencia_jugador_id_fk references jugador(jugador_id),
    competencia_id number(10,0) not null constraint jugador_competencia_competencia_id_fk references competencia(competencia_id),
    anotaciones     number(2,0) default 0,
    constraint jugador_competencia_pk primary key(jugador_id,competencia_id)
);


create index competencia_folio_tipo_ix on compuesto(folio,tipo);
create index competencia_externa_fecha_ix on competencia_externa(to_char(fecha_inicio,'mm/yyyy'))


---- Ejercicio 2
---tipos de datos, nombres de tablas, nombres de campos y valores requeridos.
-- No eliminar.

--Modificando el orden de la relación de Factura->Orden2 a Orden2->Factura
alter table Orden2 drop constraint orden2_pk;
alter table Orden2 add constraint orden_pk primary key(orden_id);

alter table Orden2 rename to Orden;

alter table Factura add orden_id number(10,0);
alter table Factura add constraint factura_orden_id_fk references Orden(orden_id);

-- comprobante factura null, 
alter table Factura modify comprobante blob null;

-- Cambiar tipo de dato de fecha
alter table Orden modify fecha_orden date;
--Cambiar el rango de importe a number(9,2)
alter table Orden modify importe numeric(9,2);

-- eliminar constraint unique 
alter table Orden drop constraint orden_fecha_orden_uk;
-- monto maximo de una orden 9,999,999.99 
alter table Orden add constraint orden_importe_chk check(importe <= 9999999.99)
-- agregar una columna
alter table Orden add total_articulos number(2,0);
-- 99 articulos max
alter table Orden add constraint orden_total_articulos_chk check(total_articulos <= 99)

-- 
--- Ejercicio 3

update seguro s, asegurado a
set s.num_poliza = to_char(s.fecha_inicio,'yyyy')|| to_char(s.seguro_id),
    s.fecha_status= s.fecha_status+7,
    s.asegurado_id=s.aval_id,
    s.aval_id=s.asegurado_id,
    s.status_seguro_id=(
        select status_seguro_id from status_seguro 
        where clave='VIGENTE'
    )
    where a.nivel='A';






merge into H_respaldo r using hist_status_seguro s on
(r.h_status_id = s.h_status_seg_id)
when matched then update
set r.fecha_status=s.fecha_status, r.status_seguro_id=s.status_seguro_id,r.seguro_id=s.seguro_id
when not matched then insert
(r.h_status_id,r.fecha_status,r.seguro_id,r.status_seguro_id) values
(s.h_status_seg_id,s.fecha_status,s.seguso_id,s.status_seguro_id);







