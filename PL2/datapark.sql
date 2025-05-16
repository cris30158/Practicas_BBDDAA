
SET client_encoding = 'UTF8';

BEGIN;

-- Crear tabla de clientes
CREATE TABLE clientes (

	clienteid integer NOT NULL,
	nombre text NOT NULL,
	apellido text NOT NULL,
	email text NOT NULL,
	telefono integer NOT NULL, 
	provincia text NOT NULL,
	CONSTRAINT clientes_pkey PRIMARY KEY (clienteid),
	CONSTRAINT email_unique UNIQUE (email),
	CONSTRAINT clientes_telefono_key UNIQUE (telefono)
	
);

-- Crear tabla de vehículos (depende de clientes)
CREATE TABLE vehiculos (
	vehiculoid integer NOT NULL,
	matricula text NOT NULL,
	marca text NOT NULL,
	modelo text NOT NULL,
	color text NOT NULL,
	clienteid_clientes integer,
	CONSTRAINT vehiculos_pkey PRIMARY KEY (vehiculoid),
	CONSTRAINT vehiculos_matricula_key UNIQUE (matricula),
    CONSTRAINT clientes_fk FOREIGN KEY (clienteid_clientes) REFERENCES clientes (clienteid) MATCH FULL ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Crear tabla de plazas (independiente)
CREATE TABLE plazas (
	plazaid integer NOT NULL,
	numero integer NOT NULL,
	nivel integer NOT NULL,
	seccion text NOT NULL,
	CONSTRAINT plazas_pkey PRIMARY KEY (plazaid)
);

-- Crear tabla de reservas (depende de vehiculos, plazas y clientes)
CREATE TABLE reservas (
	reservaid integer NOT NULL,
	fechainicio timestamp NOT NULL,
	fechafin timestamp NOT NULL,
	vehiculoid_vehiculos integer,
	plazaid_plazas integer,
	clienteid_clientes integer,

	CONSTRAINT reservas_pkey PRIMARY KEY (reservaid),
    CONSTRAINT vehiculos_fk FOREIGN KEY (vehiculoid_vehiculos) REFERENCES vehiculos (vehiculoid) MATCH FULL ON DELETE RESTRICT ON UPDATE RESTRICT,   
    CONSTRAINT clientes_fk FOREIGN KEY (clienteid_clientes) REFERENCES clientes (clienteid) MATCH FULL ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT plazas_fk FOREIGN KEY (plazaid_plazas) REFERENCES plazas (plazaid) MATCH FULL ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Crear tabla de pagos (depende de reservas)
CREATE TABLE pagos (
	pagoid integer NOT NULL,
	cantidad numeric(10,2) NOT NULL,
	fechapago timestamp NOT NULL,
	metodopago text NOT NULL,
	reservaid_reservas integer,
	CONSTRAINT pagos_pkey PRIMARY KEY (pagoid),
    CONSTRAINT reservas_fk FOREIGN KEY (reservaid_reservas) REFERENCES reservas (reservaid) MATCH FULL ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Crear tabla de incidencias (depende de reservas)
CREATE TABLE incidencias (
	incidenciaid integer NOT NULL,
	descripcion text NOT NULL,
	fechaincidencia timestamp NOT NULL,
	estado text NOT NULL,
	reservaid_reservas integer,
	CONSTRAINT incidencias_pkey PRIMARY KEY (incidenciaid),
    CONSTRAINT reservas_fk FOREIGN KEY (reservaid_reservas) REFERENCES reservas (reservaid) MATCH FULL ON DELETE RESTRICT ON UPDATE RESTRICT
);


-- COMMIT;


-- \i datapark.sql
 \timing

\copy clientes(clienteid, nombre, apellido, email, telefono, provincia) FROM 'ej7/clientes.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

\copy vehiculos(vehiculoid, matricula, marca, modelo, color, clienteid_clientes) FROM 'ej7/vehiculos.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

\copy plazas(plazaid, numero, seccion, nivel) FROM 'ej7/plazas.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

\copy reservas(reservaid, vehiculoid_vehiculos, plazaid_plazas, clienteid_clientes, fechainicio, fechafin) FROM 'ej7/reservas_final.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

\copy pagos(pagoid, cantidad, fechapago, metodopago, reservaid_reservas) FROM 'ej7/pagos.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

\copy incidencias(incidenciaid, reservaid_reservas, estado, fechaincidencia, descripcion)  FROM 'ej7/incidencias.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

Commit;