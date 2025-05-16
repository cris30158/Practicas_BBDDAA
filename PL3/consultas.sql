-- Insertar cliente
BEGIN;
-- INSERT INTO clientes (clienteid, nombre, apellido, email, telefono, provincia)
-- VALUES (30002, 'Cristina', 'Martínez', 'cyberquartzsl@gmail.com', 635526538, 'Madrid');

-- -- Insertar vehículo asociado al cliente con ID 0
-- INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes)
-- VALUES (50001, '0000CDV', 'marca_0', 'modelo_0', 'Rojo', 30002);

CREATE USER usuario1 WITH PASSWORD 'p1';
CREATE USER usuario2 WITH PASSWORD 'p2';
CREATE USER usuario3 WITH PASSWORD 'p3';

GRANT CONNECT ON DATABASE pl2 TO usuario1, usuario2, usuario3;
GRANT USAGE ON SCHEMA public TO usuario1, usuario2, usuario3;   
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO usuario1, usuario2, usuario3;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO usuario1, usuario2, usuario3;


COMMIT;