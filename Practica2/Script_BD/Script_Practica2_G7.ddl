-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-09-24 10:13:03 CST
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE categoria (
    id_categoria INTEGER NOT NULL,
    nombre       VARCHAR2(100) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE cliente (
    id_cliente       INTEGER NOT NULL,
    nombre           VARCHAR2(50) NOT NULL,
    apellido         VARCHAR2(100) NOT NULL,
    direccion        VARCHAR2(250) NOT NULL,
    telefono         VARCHAR2(15) NOT NULL,
    tarjeta          VARCHAR2(30) NOT NULL,
    edad             INTEGER NOT NULL,
    genero_id_genero INTEGER NOT NULL,
    pais_id_pais     INTEGER NOT NULL
);


ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE detalle_orden (
    id_detalle           INTEGER NOT NULL,
    linea_orden          INTEGER NOT NULL,
    orden_id_orden       INTEGER NOT NULL,
    vendedor_id_vendedor INTEGER NOT NULL,
    cantidad             INTEGER NOT NULL,
    producto_id_producto INTEGER NOT NULL
);

ALTER TABLE detalle_orden ADD CONSTRAINT detalle_orden_pk PRIMARY KEY ( id_detalle );

CREATE TABLE genero (
    id_genero INTEGER NOT NULL,
    nombre    VARCHAR2(1) NOT NULL
);

ALTER TABLE genero ADD CONSTRAINT genero_pk PRIMARY KEY ( id_genero );

CREATE TABLE orden (
    id_orden           INTEGER NOT NULL,
    cliente_id_cliente INTEGER NOT NULL,
    fecha_orden        DATE NOT NULL
);

ALTER TABLE orden ADD CONSTRAINT orden_pk PRIMARY KEY ( id_orden );

CREATE TABLE pais (
    id_pais INTEGER NOT NULL,
    nombre  VARCHAR2(100) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE producto (
    id_producto            INTEGER NOT NULL,
    nombre                 VARCHAR2(150) NOT NULL,
    precio                 NUMBER(10, 2) NOT NULL,
    categoria_id_categoria INTEGER NOT NULL
);


ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE vendedor (
    id_vendedor  INTEGER NOT NULL,
    nombre       VARCHAR2(50) NOT NULL,
    apellido     VARCHAR2(100) NOT NULL,
    pais_id_pais INTEGER NOT NULL
);


ALTER TABLE vendedor ADD CONSTRAINT vendedor_pk PRIMARY KEY ( id_vendedor );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_genero_fk FOREIGN KEY ( genero_id_genero )
        REFERENCES genero ( id_genero );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE detalle_orden
    ADD CONSTRAINT detalle_orden_orden_fk FOREIGN KEY ( orden_id_orden )
        REFERENCES orden ( id_orden );

ALTER TABLE detalle_orden
    ADD CONSTRAINT detalle_orden_producto_fk FOREIGN KEY ( producto_id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE detalle_orden
    ADD CONSTRAINT detalle_orden_vendedor_fk FOREIGN KEY ( vendedor_id_vendedor )
        REFERENCES vendedor ( id_vendedor );

ALTER TABLE orden
    ADD CONSTRAINT orden_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE vendedor
    ADD CONSTRAINT vendedor_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             4
-- ALTER TABLE                             16
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
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
-- CREATE SEQUENCE                          0
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
