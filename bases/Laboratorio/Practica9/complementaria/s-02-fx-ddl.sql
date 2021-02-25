create table empleado(
    empleado_id         number(10, 0)    not null,
    nombre              varchar2(40)     not null,
    ap_paterno          varchar2(40)    not null,
    ap_materno          varchar2(40),
    num_seguro          varchar2(18)     not null,
    email               varchar2(200),
    fecha_nacimiento    date               not null,
    sueldo_mensual      number(8, 2)     not null,
    longitud            number(15, 5)    not null,
    latitud             number(10, 5)    not null,
    fecha_registro      date             not null,
    pagina_web          varchar2(4000),
    constraint empleado_pk primary key (empleado_id)
);



