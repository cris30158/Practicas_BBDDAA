/*
CREATE INDEX IF NOT EXISTS idb_vehiculos_color ON vehiculos(color);
CREATE INDEX IF NOT EXISTS idb_incidencias_estado ON incidencias(estado);
CREATE INDEX IF NOT EXISTS idb_plazas_nivel ON plazas(nivel);
CREATE INDEX IF NOT EXISTS idb_pagos_cantidad ON pagos(cantidad);
CREATE INDEX IF NOT EXISTS idb_reservas_vehiculoid ON reservas(vehiculoid_vehiculos);
CREATE INDEX IF NOT EXISTS idb_reservas_fechainicio_month ON reservas ((EXTRACT(MONTH FROM fechainicio)));
CREATE INDEX IF NOT EXISTS idb_reservas_fechafin_month ON reservas ((EXTRACT(MONTH FROM fechafin)));
CREATE INDEX IF NOT EXISTS idb_clientes_provincia ON clientes(provincia);


CREATE INDEX IF NOT EXISTS idh_vehiculos_color ON vehiculos USING hash (color);
CREATE INDEX IF NOT EXISTS idh_incidencias_estado ON incidencias USING hash (estado);
CREATE INDEX IF NOT EXISTS idh_reservas_vehiculoid ON reservas USING hash (vehiculoid_vehiculos);
*/

--EXPLAIN
-- --9 y 10
-- SELECT  (COUNT(DISTINCT selClientes) * 100.0 / 3000000) AS porcentaje_clientes
-- FROM (
--     (SELECT  c.clienteid
--     FROM clientes c 
--     JOIN reservas r ON c.clienteid = r.clienteid_clientes
--     JOIN pagos p ON r.reservaid = p.reservaid_reservas
--     JOIN plazas pl ON r.plazaid_plazas = pl.plazaid
--     WHERE 
--         c.provincia IN ('Almería','Cádiz','Córdoba','Granada','Huelva','Jaén','Málaga','Sevilla')
--         AND (EXTRACT(MONTH FROM r.fechainicio) IN (6,7,8) OR EXTRACT(MONTH FROM r.fechafin) IN (6,7,8))
--         AND p.cantidad > 150
--         AND pl.nivel < -4
--     )
--     EXCEPT
--     (
--     SELECT r2.clienteid_clientes 
--     FROM incidencias i
--     JOIN reservas r2 ON i.reservaid_reservas = r2.reservaid
--     JOIN vehiculos v2 ON r2.vehiculoid_vehiculos = v2.vehiculoid
--     WHERE 
--         i.estado = 'cerrada'
--         AND v2.color = 'Negro'
--     )
--     ) AS selClientes;

-- --12 y 13
-- SELECT  (COUNT(DISTINCT selClientes) * 100.0 / 3000000) AS porcentaje_clientes
-- FROM (
--     (SELECT  c.clienteid
--     FROM clientes c 
--     JOIN reservas r ON c.clienteid = r.clienteid_clientes
--     JOIN pagos p ON r.reservaid = p.reservaid_reservas
--     JOIN plazas pl ON r.plazaid_plazas = pl.plazaid
--     WHERE 
--         c.provincia IN ('Almería','Cádiz','Córdoba','Granada','Huelva','Jaén','Málaga','Sevilla')
--         AND (EXTRACT(MONTH FROM r.fechainicio) IN (6,7,8) OR EXTRACT(MONTH FROM r.fechafin) IN (6,7,8))
--         AND p.cantidad > 150
--         AND pl.nivel < -4
--     )
--     EXCEPT
--     (
--     SELECT r2.clienteid_clientes 
--     FROM incidencias i
--     JOIN reservas r2 ON i.reservaid_reservas = r2.reservaid
--     JOIN vehiculos v2 ON r2.vehiculoid_vehiculos = v2.vehiculoid
--     WHERE 
--         i.estado = 'cerrada'
--         AND v2.color = 'Negro'
--     )
--     ) AS selClientes;

