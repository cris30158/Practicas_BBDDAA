
\set pager off
set client_encoding ='UTF8';

BEGIN;


-- create table if not exists productos1(
--     id_producto int,
--     nombre varchar(18),
--     stock int,
--     precio int,
--     constraint ID primary key(id_producto)
-- );
-- \COPY  productos1 FROM 'PL1.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

-- create table if not exists productos2(
--     id_producto2 int,
--     nombre2 varchar(18),
--     stock2 int,
--     precio2 int,
--     constraint ID2 primary key(id_producto2)
-- );
-- insert into productos2(id_producto2, nombre2, stock2, precio2)
-- select * from productos1 order by precio asc;

-- CREATE TABLE IF NOT EXISTS productos3 (
--     id_producto3 INT,
--     nombre3 VARCHAR(18),
--     stock3 INT,
--     precio3 INT,
--     CONSTRAINT ID3 PRIMARY KEY(id_producto3, precio3)
-- ) PARTITION BY RANGE (precio3);

-- CREATE TABLE productos3_10_510 PARTITION OF productos3 FOR VALUES FROM (10) TO (510);
-- CREATE TABLE productos3_510_1010 PARTITION OF productos3 FOR VALUES FROM (510) TO (1010);
-- CREATE TABLE productos3_1010_1510 PARTITION OF productos3 FOR VALUES FROM (1010) TO (1510);
-- CREATE TABLE productos3_1510_2010 PARTITION OF productos3 FOR VALUES FROM (1510) TO (2010);
-- CREATE TABLE productos3_2010_2510 PARTITION OF productos3 FOR VALUES FROM (2010) TO (2510);
-- CREATE TABLE productos3_2510_3010 PARTITION OF productos3 FOR VALUES FROM (2510) TO (3010);
-- CREATE TABLE productos3_3010_3510 PARTITION OF productos3 FOR VALUES FROM (3010) TO (3510);
-- CREATE TABLE productos3_3510_4010 PARTITION OF productos3 FOR VALUES FROM (3510) TO (4010);
-- CREATE TABLE productos3_4010_4510 PARTITION OF productos3 FOR VALUES FROM (4010) TO (4510);
-- CREATE TABLE productos3_4510_5001 PARTITION OF productos3 FOR VALUES FROM (4510) TO (5001);

-- \COPY  productos3 FROM 'PL1.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');


-- create table if not exists productos(
--     id_producto int,
--     nombre varchar(18),
--     stock int,
--     precio int,
--     constraint ID primary key(id_producto)
-- );
-- CREATE INDEX idb_id_producto ON productos(id_producto);
-- CREATE INDEX idh_id_producto ON productos using hash(id_producto);
-- CREATE INDEX idb_id_precio ON productos(precio);
-- CREATE INDEX idh_id_precio ON productos using hash(precio);
-- \COPY  productos FROM 'PL1.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
COMMIT;
