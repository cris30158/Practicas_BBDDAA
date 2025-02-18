
\set pager off
set client_encoding ='UTF8';

BEGIN;


create table if not exists tabla25M(
    id_producto int,
    nombre varchar(18),
    stock int,
    precio int,
    constraint ID primary key(id_producto)
);
\COPY  tabla25M FROM 'PL1.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

COMMIT;
