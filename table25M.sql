
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

create table if not exists productos2(
    id_producto1 int,
    nombre1 varchar(18),
    stock1 int,
    precio1 int,
    constraint ID1 primary key(id_producto1)
);

insert into productos2(id_producto1, nombre1, stock1, precio1)
select * from tabla25M order by precio asc;


COMMIT;
