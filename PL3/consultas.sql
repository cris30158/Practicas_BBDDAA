-- Insertar cliente
BEGIN;
INSERT INTO clientes (clienteid, nombre, apellido, email, telefono, provincia)
VALUES (0, 'Cristina', 'Martínez', 'cyberquartzsl@gmail.com', 635526538, 'Madrid');

-- Insertar vehículo asociado al cliente con ID 0
INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes)
VALUES (0, '0000CDV', 'marca_0', 'modelo_0', 'Rojo', 0);

COMMIT;