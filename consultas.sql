begin;


-- SELECT relname AS table_name,
--        pg_relation_size(relid) AS total_size_bytes,
--        pg_relation_size(relid) / current_setting('block_size')::int AS total_blocks
-- FROM pg_catalog.pg_statio_user_tables
-- WHERE relname = 'tabla25M';

-- select relname AS table_name, relpages AS bloques
-- from pg_class
-- where relname = 'tabla25M';



-- -- Obtener el total de bloques utilizados por la tabla tabla25M
SELECT relname AS table_name,
       relpages AS bloques
FROM pg_class
WHERE relname = 'tabla25m';


Rollback;