SET client_encoding = 'UTF8';

BEGIN;

-- Tabla clientes (no tiene claves foráneas)
CREATE TABLE clientes (
	clienteid integer NOT NULL,
	nombre text NOT NULL,
	apellido text NOT NULL,
	email text NOT NULL,
	telefono text NOT NULL,
	provincia text NOT NULL,
	CONSTRAINT clientes_pkey PRIMARY KEY (clienteid),
	CONSTRAINT email_unique UNIQUE (email),
	CONSTRAINT clientes_telefono_key UNIQUE (telefono)
);

-- Tabla vehículos (clave foránea a clientes)
CREATE TABLE vehiculos (
	vehiculoid integer NOT NULL,
	matricula text NOT NULL,
	marca text NOT NULL,
	modelo text NOT NULL,
	color text NOT NULL,
	clienteid_clientes integer,
	CONSTRAINT vehiculos_pkey PRIMARY KEY (vehiculoid),
	CONSTRAINT vehiculos_matricula_key UNIQUE (matricula),
	CONSTRAINT clientes_fk FOREIGN KEY (clienteid_clientes)
		REFERENCES clientes (clienteid)
		ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Tabla plazas (sin claves foráneas)
CREATE TABLE plazas (
	plazaid integer NOT NULL,
	numero integer NOT NULL,
	nivel integer NOT NULL,
	seccion text NOT NULL,
	CONSTRAINT plazas_pkey PRIMARY KEY (plazaid)
);

-- Tabla reservas (claves foráneas a vehículos, plazas y clientes)
CREATE TABLE reservas (
	reservaid integer NOT NULL,
	fechainicio timestamp NOT NULL,
	fechafin timestamp NOT NULL,
	vehiculoid_vehiculos integer,
	plazaid_plazas integer,
	clienteid_clientes integer,
	CONSTRAINT reservas_pkey PRIMARY KEY (reservaid),
	CONSTRAINT vehiculos_fk FOREIGN KEY (vehiculoid_vehiculos)
		REFERENCES vehiculos (vehiculoid)
		ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT clientes_fk FOREIGN KEY (clienteid_clientes)
		REFERENCES clientes (clienteid)
		ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT plazas_fk FOREIGN KEY (plazaid_plazas)
		REFERENCES plazas (plazaid)
		ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Tabla pagos (clave foránea a reservas)
CREATE TABLE pagos (
	pagoid integer NOT NULL,
	cantidad numeric(10,2) NOT NULL,
	fechapago timestamp NOT NULL,
	metodopago text NOT NULL,
	reservaid_reservas integer,
	CONSTRAINT pagos_pkey PRIMARY KEY (pagoid),
	CONSTRAINT reservas_fk FOREIGN KEY (reservaid_reservas)
		REFERENCES reservas (reservaid)
		ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Tabla incidencias (clave foránea a reservas)
CREATE TABLE incidencias (
	incidenciaid integer NOT NULL,
	descripcion text NOT NULL,
	fechaincidencia timestamp NOT NULL,
	estado text NOT NULL,
	reservaid_reservas integer,
	CONSTRAINT incidencias_pkey PRIMARY KEY (incidenciaid),
	CONSTRAINT reservas_fk FOREIGN KEY (reservaid_reservas)
		REFERENCES reservas (reservaid)
		ON DELETE RESTRICT ON UPDATE RESTRICT
);

COMMIT;
