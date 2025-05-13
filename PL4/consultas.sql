Begin;
--para p = 32
INSERT INTO clientes (clienteid, nombre, apellido, email, telefono, provincia)
VALUES (1, 'Cristina', 'Pedroche', 'cristinapedroche@gmail.com', 600000001, 'Madrid');
INSERT INTO clientes (clienteid, nombre, apellido, email, telefono, provincia)
VALUES (2, 'Alonso', 'Fernández', 'alonsofernandez23@hotmail.com', 600000002, 'La Rioja');

-- para 
INSERT INTO clientes (clienteid, nombre, apellido, email, telefono, provincia)
VALUES (3, 'Fernando', 'Gutierrez', 'fernandogutierrez@gmail.com', 600000003, 'Sevilla');
INSERT INTO clientes (clienteid, nombre, apellido, email, telefono, provincia)
VALUES (4, 'Gabriel', 'Sanchez', 'gabrielsanchez@yahoo.com', 600000004, 'Toledo');

-- Insertar vehículo asociado al cliente con ID 0
-- para p = 32
INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes)
VALUES (0, '0000CDV', 'marca_1', 'modelo_2', 'Rojo', 50000000);
VALUES (0, '0001CDV', 'marca_8', 'modelo_5', 'Rosa', 50000001);
VALUES (0, '0002CDV', 'marca_6', 'modelo_3', 'Amarillo', 50000001);

-- para p = 33
VALUES (0, '0003CDV', 'marca_4', 'modelo_7', 'Negro', 50000003);
VALUES (0, '0004CDV', 'marca_5', 'modelo_1', 'Pastel', 50000002);

Commit;