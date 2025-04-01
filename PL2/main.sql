\c investigar
\timing ON
\set pager off
set client_encoding ='UTF8';

BEGIN;


create table if not exists investigadores(
    codigo_investigador numeric,
    nombre text,
    apellido text,
    salatio numeric,
    PRIMARY KEY(codigo_investigador)
);

create table if not exists contratos(
    codigo_contrato numeric,
    nombre text,
    entidad text,
    coste numeric,
    PRIMARY KEY(codigo_contrato)
);

create table if not exists investigadores_contratos(
    codigo_investigador numeric, 
    codigo_contrato numeric, 
    soras numeric,
    FOREIGN KEY (codigo_investigador) REFERENCES investigadores(codigo_investigador)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    FOREIGN KEY (codigo_contrato) REFERENCES contratos(codigo_contrato)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    PRIMARY KEY (codigo_investigador,codigo_contrato)
); 

\copy contratos from 'data_profe/datos_contratos.csv' WITH (FORMAT csv, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\copy investigadores from 'data_profe/datos_investigadores.csv' WITH (FORMAT csv, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\copy investigadores_contratos from 'data_profe/datos_investigadores_contratos.csv' WITH (FORMAT csv, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');




COMMIT;
