begin;


-- SELECT relname AS table_name,
--        pg_relation_size(relid) AS total_size_bytes,
--        pg_relation_size(relid) / current_setting('block_size')::int AS total_blocks
-- FROM pg_catalog.pg_statio_user_tables
-- WHERE relname = 'tabla25M';

-- select relname AS table_name, relpages AS bloques
-- from pg_class
-- where relname = 'tabla25M';



-- --Obtener el total de bloques utilizados por la tabla tabla25M
-- SELECT relname AS table_name,
--        relpages AS bloques
-- FROM pg_class
-- WHERE relname = 'tabla25m';

--Borrar 4 millones de registros de la tabla tabla25M
-- DELETE FROM tabla25M WHERE id IN (SELECT id FROM tabla25M ORDER BY random() LIMIT 4000000);
-- SELECT heap_blks_read, heap_blks_hit FROM pg_statio_user_tables WHERE relname = 'tabla25M';
-- SELECT heap_blks_read, heap_blks_hit FROM pg_statio_user_tables WHERE relname = 'productos2';


Rollback;