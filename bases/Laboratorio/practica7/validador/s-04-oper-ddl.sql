
--@Autor(es):       Jorge Rodríguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:    Práctica 07 Complementaria - Caso 2

Prompt conectando  jrc_p0702_oper
connect jrc_p0702_oper/jorge

-- 
-- SEQUENCE: SEQ_EMPLEADO 
--

CREATE SEQUENCE SEQ_EMPLEADO
    START WITH 10
    INCREMENT BY 3
    MINVALUE 5
    NOMAXVALUE
    CACHE 3
    NOORDER
;

-- 
-- TABLE: EMPLEADO 
--

CREATE TABLE EMPLEADO(
    EMPLEADO_ID       NUMBER(10, 0)    NOT NULL,
    NOMBRE            VARCHAR2(40)     NOT NULL,
    AP_PAT            VARCHAR2(40)     NOT NULL,
    AP_MAT            VARCHAR2(40)     NOT NULL,
    SUELDO_MENSUAL    NUMBER(5, 2)     NOT NULL,
    FECHA_NAC         DATE             NOT NULL,
    TIPO              CHAR(1)          NOT NULL,
    CONSTRAINT EMPLEADO_PK PRIMARY KEY (EMPLEADO_ID)
)
;



-- 
-- TABLE: BECARIO 
--

CREATE TABLE BECARIO(
    EMPLEADO_ID    NUMBER(10, 0)    NOT NULL,
    CARRERA        VARCHAR2(40)     NOT NULL,
    PROMEDIO       NUMBER(3, 1)     NOT NULL,
    CONSTRAINT BECARIO_PK PRIMARY KEY (EMPLEADO_ID), 
    CONSTRAINT RefEMPLEADO2 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
)
;



-- 
-- TABLE: PAGO_EMP 
--

CREATE TABLE PAGO_EMP(
    NUM_PAGO       NUMBER(10, 0)    NOT NULL,
    EMPLEADO_ID    NUMBER(10, 0)    NOT NULL,
    FECHA_PAGO     DATE             NOT NULL,
    IMPORTE        NUMBER(10, 2)    NOT NULL,
    CONSTRAINT PAGO_EMP_PK PRIMARY KEY (NUM_PAGO, EMPLEADO_ID), 
    CONSTRAINT PAGO_EMP_EMPLEADO_ID_FK FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
)
;



-- 
-- TABLE: PERMANENTE 
--

CREATE TABLE PERMANENTE(
    EMPLEADO_ID     NUMBER(10, 0)    NOT NULL,
    NUM_CONTRATO    VARCHAR2(13)     NOT NULL,
    CONSTRAINT PERMANENTE_PK PRIMARY KEY (EMPLEADO_ID), 
    CONSTRAINT RefEMPLEADO3 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
)
;



-- 
-- TABLE: STATUS_BECARIO 
--

CREATE TABLE STATUS_BECARIO(
    STATUS_ID      NUMBER(2, 0)     NOT NULL,
    CLAVE          VARCHAR2(40)     NOT NULL,
    DESCRIPCION    VARCHAR2(40)     NOT NULL,
    EMPLEADO_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT STATUS_BECARIO_PK PRIMARY KEY (STATUS_ID), 
    CONSTRAINT STATUS_BECARIO_EMPLEADO_ID_FK FOREIGN KEY (EMPLEADO_ID)
    REFERENCES BECARIO(EMPLEADO_ID)
)
;


-- 
-- TABLE: TEMPORAL 
--

CREATE TABLE TEMPORAL(
    EMPLEADO_ID     NUMBER(10, 0)    NOT NULL,
    FECHA_INICIO    DATE             NOT NULL,
    FECHA_FIN       VARCHAR2(40)     NOT NULL,
    CONSTRAINT TEMPORAL_PK PRIMARY KEY (EMPLEADO_ID), 
    CONSTRAINT RefEMPLEADO1 FOREIGN KEY (EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
)
;







