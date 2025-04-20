


BEGIN;


CREATE INDEX IF NOT EXISTS idx_vehiculos_cleinteid_clientes ON vehiculos(clienteid_clientes);  
CREATE INDEX IF NOT EXISTS idx_reservas_vehiculoid_vehiculos ON reservas(vehiculoid_vehiculos); 
CREATE INDEX IF NOT EXISTS idx_reservas_plazaid_plazas ON reservas(plazaid_plazas); 
CREATE INDEX IF NOT EXISTS idx_reservas_clienteid_clientes ON reservas(clienteid_clientes); 
CREATE INDEX IF NOT EXISTS idx_incidencias_reservaid_reservas ON incidencias(reservaid_reservas);   
CREATE INDEX IF NOT EXISTS idx_pagos_reservaid_reservas ON pagos(reservaid_reservas);   


CREATE TEMP TABLE IF NOT EXISTS temp_clientes_a_borrar AS
    SELECT clienteid
    FROM clientes c 
    ORDER BY random()
    LIMIT (SELECT ceil(COUNT(*) * 0.3) FROM clientes);

CREATE TEMP TABLE IF NOT EXISTS temp_vehiculos_a_borrar AS
SELECT vehiculoid FROM vehiculos
WHERE clienteid_clientes IN (SELECT clienteid FROM temp_clientes_a_borrar);

CREATE TEMP TABLE IF NOT EXISTS temp_reservas_a_borrar AS
SELECT r.reservaid
FROM reservas r
WHERE r.clienteid_clientes IN (SELECT clienteid FROM temp_clientes_a_borrar)
   OR r.vehiculoid_vehiculos IN (SELECT vehiculoid FROM temp_vehiculos_a_borrar);


CREATE INDEX IF NOT EXISTS idx_temp_vehiculos_a_borrar ON temp_vehiculos_a_borrar(vehiculoid);
CREATE INDEX IF NOT EXISTS idx_temp_clientes_a_borrar ON temp_clientes_a_borrar(clienteid); 
CREATE INDEX IF NOT EXISTS idx_temp_reservas_a_borrar ON temp_reservas_a_borrar(reservaid); 


DELETE FROM pagos p
USING temp_reservas_a_borrar trb
WHERE p.reservaid_reservas = trb.reservaid;

DELETE FROM incidencias i
USING temp_reservas_a_borrar trb
WHERE i.reservaid_reservas = trb.reservaid;

DELETE FROM reservas r
USING temp_reservas_a_borrar trb
WHERE r.reservaid = trb.reservaid;

DELETE FROM vehiculos v
USING temp_vehiculos_a_borrar tvb
WHERE v.vehiculoid = tvb.vehiculoid;

DELETE FROM clientes c
USING temp_clientes_a_borrar tcb
WHERE c.clienteid = tcb.clienteid;


COMMIT;