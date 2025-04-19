\c pl2
BEGIN;

CREATE TEMP TABLE IF NOT EXISTS temp_clientes AS
    SELECT clienteid
    FROM clientes c 
    ORDER BY random()
    LIMIT (SELECT ceil(COUNT(*) * 0.3) FROM clientes);

CREATE TEMP TABLE IF NOT EXISTS temp_vehiculos AS
SELECT vehiculoid FROM vehiculos
WHERE clienteid_clientes IN (SELECT clienteid FROM temp_clientes);

CREATE TEMP TABLE IF NOT EXISTS temp_reservas AS
SELECT r.reservaid
FROM reservas r
WHERE r.clienteid_clientes IN (SELECT clienteid FROM temp_clientes)
   OR r.vehiculoid_vehiculos IN (SELECT vehiculoid FROM temp_vehiculos);

CREATE INDEX IF NOT EXISTS idb_temp_vehiculos ON temp_vehiculos(vehiculoid);
CREATE INDEX IF NOT EXISTS idb_temp_clientes ON temp_clientes(clienteid); 
CREATE INDEX IF NOT EXISTS idb_temp_reservas ON temp_reservas(reservaid); 

CREATE INDEX IF NOT EXISTS idb_vehiculos_con_cleinteid ON vehiculos(clienteid_clientes);  
CREATE INDEX IF NOT EXISTS idb_reservas_con_vehiculoid ON reservas(vehiculoid_vehiculos); 
CREATE INDEX IF NOT EXISTS idb_reservas_con_ ON reservas(plazaid_plazas); 
CREATE INDEX IF NOT EXISTS idb_reservas_con_clienteid ON reservas(clienteid_clientes); 
CREATE INDEX IF NOT EXISTS idb_incidencias_con_reservaid ON incidencias(reservaid_reservas);   
CREATE INDEX IF NOT EXISTS idb_pagos_con_reservaid ON pagos(reservaid_reservas);   

DELETE FROM pagos p
USING temp_reservas trb
WHERE p.reservaid_reservas = trb.reservaid;

DELETE FROM incidencias i
USING temp_reservas trb
WHERE i.reservaid_reservas = trb.reservaid;

DELETE FROM reservas r
USING temp_reservas trb
WHERE r.reservaid = trb.reservaid;

DELETE FROM vehiculos v
USING temp_vehiculos tvb
WHERE v.vehiculoid = tvb.vehiculoid;

DELETE FROM clientes c
USING temp_clientes tcb
WHERE c.clienteid = tcb.clienteid;

COMMIT;
