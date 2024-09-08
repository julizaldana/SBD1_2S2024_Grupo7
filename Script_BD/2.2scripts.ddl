-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-09-07 11:27:21 CST
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE adestino (
    destino            INTEGER NOT NULL,
    aeropuerto_id_iata VARCHAR2(50) NOT NULL
);

ALTER TABLE adestino ADD CONSTRAINT aeropuerto_destino_pk PRIMARY KEY ( destino );

CREATE TABLE aerolineas (
    id_oaci VARCHAR2(50) NOT NULL,
    nombre  VARCHAR2(50),
    pais    VARCHAR2(50),
    ciudad  VARCHAR2(50)
);

ALTER TABLE aerolineas ADD CONSTRAINT aerolineas_pk PRIMARY KEY ( id_oaci );

CREATE TABLE aeropuerto (
    id_iata            VARCHAR2(20) NOT NULL,
    nombre             VARCHAR2(50),
    pais               VARCHAR2(50),
    ciudad             VARCHAR2(50),
    pistasextendidas   NUMBER,
    serviciosaduaneros NUMBER
);

ALTER TABLE aeropuerto ADD CONSTRAINT aeropuero_pk PRIMARY KEY ( id_iata );

CREATE TABLE aorigen (
    origen             INTEGER NOT NULL,
    aeropuerto_id_iata VARCHAR2(50) NOT NULL
);

ALTER TABLE aorigen ADD CONSTRAINT aeropuerto_origen_pk PRIMARY KEY ( origen );

CREATE TABLE asiento (
    id_numero            INTEGER NOT NULL,
    tarifa_id_tarifa     INTEGER NOT NULL,
    estado               VARCHAR2(1),
    aviones_id_matricula VARCHAR2(20) NOT NULL,
    reserva_id_reserva   INTEGER NOT NULL
);


ALTER TABLE asiento ADD CONSTRAINT asiento_pk PRIMARY KEY ( id_numero );

CREATE TABLE aviones (
    aerolineas_id_oaci VARCHAR2(50) NOT NULL,
    id_matricula       VARCHAR2(20) NOT NULL,
    modelo             VARCHAR2(50),
    capacidad          INTEGER,
    alcancemax         NUMBER(10, 2)
);

ALTER TABLE aviones ADD CONSTRAINT aviones_pk PRIMARY KEY ( id_matricula );

CREATE TABLE empleado (
    id_empleado        INTEGER NOT NULL,
    nombre             VARCHAR2(50),
    apellidos          VARCHAR2(50),
    correo             VARCHAR2(50),
    telefono           VARCHAR2(8),
    salario            NUMBER(10, 2),
    aerolineas_id_oaci VARCHAR2(50) NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE equipaje (
    id_equipaje           INTEGER NOT NULL,
    peso                  NUMBER(10, 2),
    largo                 NUMBER(10, 2),
    alto                  NUMBER,
    ancho                 NUMBER(10, 2),
    estado                VARCHAR2(20),
    observacion           VARCHAR2(100),
    pasajeros_id_pasajero INTEGER NOT NULL
);

ALTER TABLE equipaje ADD CONSTRAINT equipaje_pk PRIMARY KEY ( id_equipaje );

CREATE TABLE historia_vp (
    id_historial          INTEGER NOT NULL,
    vuelo_id_vuelo        INTEGER NOT NULL,
    pasajeros_id_pasajero INTEGER NOT NULL
);

ALTER TABLE historia_vp ADD CONSTRAINT historia_vp_pk PRIMARY KEY ( id_historial );

CREATE TABLE mantenimiento (
    id_mantenimiento     INTEGER NOT NULL,
    descripcion          VARCHAR2(50),
    aviones_id_matricula VARCHAR2(20) NOT NULL
);

ALTER TABLE mantenimiento ADD CONSTRAINT mantenimiento_pk PRIMARY KEY ( id_mantenimiento );

CREATE TABLE pasajeros (
    id_pasajero     INTEGER NOT NULL,
    nombre          VARCHAR2(50),
    apellidos       VARCHAR2(50),
    correo          VARCHAR2(50),
    telefono        VARCHAR2(8),
    numeropasaporte VARCHAR2(20),
    visa            VARCHAR2(20)
);

ALTER TABLE pasajeros ADD CONSTRAINT pasajeros_pk PRIMARY KEY ( id_pasajero );

CREATE TABLE puerta (
    id_puerta                INTEGER NOT NULL,
    terminales_terminales_id NUMBER NOT NULL,
    id_terminal              INTEGER NOT NULL
);

ALTER TABLE puerta ADD CONSTRAINT puerta_pk PRIMARY KEY ( id_puerta );

CREATE TABLE puesto (
    id_puesto                  INTEGER NOT NULL,
    rol                        VARCHAR2(1),
    empleado_id_empleado       INTEGER NOT NULL,
    tripulacion_id_tripulacion INTEGER NOT NULL
);

CREATE UNIQUE INDEX puesto__idx ON
    puesto (
        empleado_id_empleado
    ASC );

ALTER TABLE puesto ADD CONSTRAINT puesto_pk PRIMARY KEY ( id_puesto );

CREATE TABLE reserva (
    id_reserva            INTEGER NOT NULL,
    fecha                 DATE,
    metodopago            VARCHAR2(1),
    estado                VARCHAR2(1),
    vuelo_id_vuelo        INTEGER NOT NULL,
    pasajeros_id_pasajero INTEGER NOT NULL
);

ALTER TABLE reserva ADD CONSTRAINT reserva_pk PRIMARY KEY ( id_reserva );

CREATE TABLE ruta (
    id_ruta          INTEGER NOT NULL,
    distancia        NUMBER(10, 2),
    duracion         NUMBER(10, 2),
    aorigen_origen   INTEGER NOT NULL,
    adestino_destino INTEGER NOT NULL
);

CREATE UNIQUE INDEX ruta__idx ON
    ruta (
        aorigen_origen
    ASC );

CREATE UNIQUE INDEX ruta__idxv1 ON
    ruta (
        adestino_destino
    ASC );

ALTER TABLE ruta ADD CONSTRAINT ruta_pk PRIMARY KEY ( id_ruta );

CREATE TABLE tarifa (
    id_tarifa INTEGER NOT NULL,
    precio    NUMBER(10, 2),
    clase     VARCHAR2(1)
);

ALTER TABLE tarifa ADD CONSTRAINT tarifa_pk PRIMARY KEY ( id_tarifa );

CREATE TABLE terminales (
    id_terminal        INTEGER NOT NULL,
    aeropuerto_id_iata VARCHAR2(50) NOT NULL,
    terminales_id      NUMBER NOT NULL
);

ALTER TABLE terminales ADD CONSTRAINT terminales_pkv1 PRIMARY KEY ( id_terminal );

ALTER TABLE terminales ADD CONSTRAINT terminales_pk UNIQUE ( terminales_id );

CREATE TABLE tripulacion (
    id_tripulacion INTEGER NOT NULL
);

ALTER TABLE tripulacion ADD CONSTRAINT tripulacion_pk PRIMARY KEY ( id_tripulacion );

CREATE TABLE vuelo (
    id_vuelo                   INTEGER NOT NULL,
    fecha_llegada              DATE,
    fecha_salida               DATE,
    ruta_id_ruta               INTEGER NOT NULL,
    tripulacion_id_tripulacion INTEGER NOT NULL,
    aerolineas_id_oaci         VARCHAR2(50) NOT NULL,
    aviones_id_matricula       VARCHAR2(20) NOT NULL,
    puerta_id_puerta           INTEGER NOT NULL,
    estado                     VARCHAR2(1)
);


ALTER TABLE vuelo ADD CONSTRAINT vuelo_pk PRIMARY KEY ( id_vuelo );

ALTER TABLE adestino
    ADD CONSTRAINT adestino_aeropuerto_fk FOREIGN KEY ( aeropuerto_id_iata )
        REFERENCES aeropuerto ( id_iata );

ALTER TABLE aorigen
    ADD CONSTRAINT aorigen_aeropuerto_fk FOREIGN KEY ( aeropuerto_id_iata )
        REFERENCES aeropuerto ( id_iata );

ALTER TABLE asiento
    ADD CONSTRAINT asiento_aviones_fk FOREIGN KEY ( aviones_id_matricula )
        REFERENCES aviones ( id_matricula );

ALTER TABLE asiento
    ADD CONSTRAINT asiento_reserva_fk FOREIGN KEY ( reserva_id_reserva )
        REFERENCES reserva ( id_reserva );

ALTER TABLE asiento
    ADD CONSTRAINT asiento_tarifa_fk FOREIGN KEY ( tarifa_id_tarifa )
        REFERENCES tarifa ( id_tarifa );

ALTER TABLE aviones
    ADD CONSTRAINT aviones_aerolineas_fk FOREIGN KEY ( aerolineas_id_oaci )
        REFERENCES aerolineas ( id_oaci );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_aerolineas_fk FOREIGN KEY ( aerolineas_id_oaci )
        REFERENCES aerolineas ( id_oaci );

ALTER TABLE equipaje
    ADD CONSTRAINT equipaje_pasajeros_fk FOREIGN KEY ( pasajeros_id_pasajero )
        REFERENCES pasajeros ( id_pasajero );

ALTER TABLE historia_vp
    ADD CONSTRAINT historia_vp_pasajeros_fk FOREIGN KEY ( pasajeros_id_pasajero )
        REFERENCES pasajeros ( id_pasajero );

ALTER TABLE historia_vp
    ADD CONSTRAINT historia_vp_vuelo_fk FOREIGN KEY ( vuelo_id_vuelo )
        REFERENCES vuelo ( id_vuelo );

ALTER TABLE mantenimiento
    ADD CONSTRAINT mantenimiento_aviones_fk FOREIGN KEY ( aviones_id_matricula )
        REFERENCES aviones ( id_matricula );

ALTER TABLE puerta
    ADD CONSTRAINT puerta_terminales_fk FOREIGN KEY ( id_terminal )
        REFERENCES terminales ( terminales_id );

ALTER TABLE puesto
    ADD CONSTRAINT puesto_empleado_fk FOREIGN KEY ( empleado_id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE puesto
    ADD CONSTRAINT puesto_tripulacion_fk FOREIGN KEY ( tripulacion_id_tripulacion )
        REFERENCES tripulacion ( id_tripulacion );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_pasajeros_fk FOREIGN KEY ( pasajeros_id_pasajero )
        REFERENCES pasajeros ( id_pasajero );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_vuelo_fk FOREIGN KEY ( vuelo_id_vuelo )
        REFERENCES vuelo ( id_vuelo );

ALTER TABLE ruta
    ADD CONSTRAINT ruta_adestino_fk FOREIGN KEY ( adestino_destino )
        REFERENCES adestino ( destino );

ALTER TABLE ruta
    ADD CONSTRAINT ruta_aorigen_fk FOREIGN KEY ( aorigen_origen )
        REFERENCES aorigen ( origen );

ALTER TABLE terminales
    ADD CONSTRAINT terminales_aeropuerto_fk FOREIGN KEY ( aeropuerto_id_iata )
        REFERENCES aeropuerto ( id_iata );

ALTER TABLE vuelo
    ADD CONSTRAINT vuelo_aerolineas_fk FOREIGN KEY ( aerolineas_id_oaci )
        REFERENCES aerolineas ( id_oaci );

ALTER TABLE vuelo
    ADD CONSTRAINT vuelo_aviones_fk FOREIGN KEY ( aviones_id_matricula )
        REFERENCES aviones ( id_matricula );

ALTER TABLE vuelo
    ADD CONSTRAINT vuelo_puerta_fk FOREIGN KEY ( puerta_id_puerta )
        REFERENCES puerta ( id_puerta );

ALTER TABLE vuelo
    ADD CONSTRAINT vuelo_ruta_fk FOREIGN KEY ( ruta_id_ruta )
        REFERENCES ruta ( id_ruta );

ALTER TABLE vuelo
    ADD CONSTRAINT vuelo_tripulacion_fk FOREIGN KEY ( tripulacion_id_tripulacion )
        REFERENCES tripulacion ( id_tripulacion );

CREATE SEQUENCE terminales_terminales_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER terminales_terminales_id_trg BEFORE
    INSERT ON terminales
    FOR EACH ROW
    WHEN ( new.terminales_id IS NULL )
BEGIN
    :new.terminales_id := terminales_terminales_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            19
-- CREATE INDEX                             7
-- ALTER TABLE                             44
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
