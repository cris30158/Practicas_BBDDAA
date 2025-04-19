

-- drop database pl2;
-- create database pl2;
-- \c pl2
-- \i datapark2.sql
-- \timing

-- \copy clientes(clienteid, nombre, apellido, email, telefono, provincia) FROM 'ej7/clientes.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- \copy vehiculos(vehiculoid, matricula, marca, modelo, color, clienteid_clientes) FROM 'ej7/vehiculos.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- \copy plazas(plazaid, numero, seccion, nivel) FROM 'ej7/plazas.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- \copy reservas(reservaid, vehiculoid_vehiculos, plazaid_plazas, clienteid_clientes, fechainicio, fechafin) FROM 'ej7/reservas_final.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- \copy pagos(pagoid, cantidad, fechapago, metodopago, reservaid_reservas) FROM 'ej7/pagos.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- \copy incidencias(incidenciaid, reservaid_reservas, estado, fechaincidencia, descripcion)  FROM 'ej7/incidencias.csv' DELIMITER ',' CSV HEADER NULL 'NULL';






-- --9:
SELECT  (COUNT(DISTINCT selClientes) * 100.0 / 3000000) AS porcentaje_clientes
FROM (
    (SELECT c.clienteid
    FROM clientes c 
    JOIN reservas r ON c.clienteid = r.clienteid_clientes
    JOIN pagos p ON r.reservaid = p.reservaid_reservas
    JOIN plazas pl ON r.plazaid_plazas = pl.plazaid
    WHERE 
        c.provincia IN ('Almería','Cádiz','Córdoba','Granada','Huelva','Jaén','Málaga','Sevilla')
        AND (EXTRACT(MONTH FROM r.fechainicio) IN (6,7,8) OR EXTRACT(MONTH FROM r.fechafin) IN (6,7,8))
        AND p.cantidad > 150
        AND pl.nivel < -4
    )
    EXCEPT
    (
    SELECT r2.clienteid_clientes 
    FROM incidencias i
    JOIN reservas r2 ON i.reservaid_reservas = r2.reservaid
    JOIN vehiculos v2 ON r2.vehiculoid_vehiculos = v2.vehiculoid
    WHERE 
        i.estado = 'cerrada'
        AND v2.color = 'Negro'
    )
    ) AS selClientes;





-- --11:
-- CREATE TEMP TABLE clientes_a_borrar AS
-- SELECT clienteid
-- FROM clientes
-- ORDER BY RANDOM()
-- LIMIT (SELECT ROUND(COUNT(*) * 0.3) FROM clientes);

-- DELETE FROM clientes
-- WHERE clienteid IN (SELECT clienteid FROM clientes_a_borrar);



-- --11 sin on delete
-- CREATE TEMP TABLE clientes_a_borrar AS
-- SELECT clienteid
-- FROM clientes
-- ORDER BY RANDOM()
-- LIMIT (SELECT ROUND(COUNT(*) * 0.3) FROM clientes);

-- DELETE FROM incidencias
-- WHERE reservaid_reservas IN (
--     SELECT reservaid FROM reservas WHERE clienteid_clientes IN (SELECT clienteid FROM clientes_a_borrar) );

-- DELETE FROM pagos
-- WHERE reservaid_reservas IN ( SELECT reservaid FROM reservas WHERE clienteid_clientes IN (SELECT clienteid FROM clientes_a_borrar) );

-- DELETE FROM reservas
-- WHERE clienteid_clientes IN (SELECT clienteid FROM clientes_a_borrar);

-- DELETE FROM vehiculos
-- WHERE clienteid_clientes IN (SELECT clienteid FROM clientes_a_borrar);

-- DELETE FROM clientes
-- WHERE clienteid IN (SELECT clienteid FROM clientes_a_borrar);
