Begin;

--Coipamos la nueva BBDD de telpark (tiene menos datos para un manejo mas rapido) 
--Se copieran en las tablas de M1 y M2 segun se ejecute en la consola con el puerto (32 o 33) correspondiente
-- \copy clientes(clienteid, nombre, apellido, email, telefono, provincia) FROM 'NWTLPK/clientes.csv' DELIMITER ',' CSV HEADER NULL 'NULL';
-- \copy vehiculos(vehiculoid, matricula, marca, modelo, color, clienteid_clientes) FROM 'NWTLPK/vehiculos.csv' DELIMITER ',' CSV HEADER NULL 'NULL';
-- \copy plazas(plazaid, numero, seccion, nivel) FROM 'NWTLPK/plazas.csv' DELIMITER ',' CSV HEADER NULL 'NULL';
-- \copy reservas(reservaid, vehiculoid_vehiculos, plazaid_plazas, clienteid_clientes, fechainicio, fechafin) FROM 'NWTLPK/reservas.csv' DELIMITER ',' CSV HEADER NULL 'NULL';
-- \copy pagos(pagoid, cantidad, fechapago, metodopago, reservaid_reservas) FROM 'NWTLPK/pagos.csv' DELIMITER ',' CSV HEADER NULL 'NULL';
-- \copy incidencias(incidenciaid, reservaid_reservas, estado, fechaincidencia, descripcion)  FROM 'NWTLPK/incidencias.csv' DELIMITER ',' CSV HEADER NULL 'NULL';



Commit;