-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: "PL2" | type: DATABASE --
-- DROP DATABASE IF EXISTS "PL2";
CREATE DATABASE "PL2"
	ENCODING = 'UTF8'
	LC_COLLATE = 'Spanish_Spain.1252'
	LC_CTYPE = 'Spanish_Spain.1252'
	TABLESPACE = pg_default
	OWNER = postgres;
-- ddl-end --


-- object: public.vehiculos | type: TABLE --
-- DROP TABLE IF EXISTS public.vehiculos CASCADE;
CREATE TABLE public.vehiculos (
	vehiculoid integer NOT NULL,
	matricula text NOT NULL,
	marca text NOT NULL,
	modelo text NOT NULL,
	color text NOT NULL,
	clienteid_clientes integer,
	CONSTRAINT vehiculos_pkey PRIMARY KEY (vehiculoid),
	CONSTRAINT vehiculos_matricula_key UNIQUE (matricula)
);
-- ddl-end --
ALTER TABLE public.vehiculos OWNER TO postgres;
-- ddl-end --

-- object: public.clientes | type: TABLE --
-- DROP TABLE IF EXISTS public.clientes CASCADE;
CREATE TABLE public.clientes (
	clienteid integer NOT NULL,
	nombre text NOT NULL,
	apellido text NOT NULL,
	email text NOT NULL,
	telefono integer NOT NULL,
	provincia text NOT NULL,
	CONSTRAINT clientes_pkey PRIMARY KEY (clienteid),
	CONSTRAINT clientes_telefono_key UNIQUE (telefono),
	CONSTRAINT email_unique UNIQUE (email)
);
-- ddl-end --
ALTER TABLE public.clientes OWNER TO postgres;
-- ddl-end --

-- object: public.plazas | type: TABLE --
-- DROP TABLE IF EXISTS public.plazas CASCADE;
CREATE TABLE public.plazas (
	plazaid integer NOT NULL,
	numero integer NOT NULL,
	nivel integer NOT NULL,
	seccion text NOT NULL,
	CONSTRAINT plazas_pkey PRIMARY KEY (plazaid)
);
-- ddl-end --
ALTER TABLE public.plazas OWNER TO postgres;
-- ddl-end --

-- object: public.reservas | type: TABLE --
-- DROP TABLE IF EXISTS public.reservas CASCADE;
CREATE TABLE public.reservas (
	reservaid integer NOT NULL,
	fechainicio timestamp NOT NULL,
	fechafin timestamp NOT NULL,
	vehiculoid_vehiculos integer,
	plazaid_plazas integer,
	clienteid_clientes integer,
	CONSTRAINT reservas_pkey PRIMARY KEY (reservaid)
);
-- ddl-end --
ALTER TABLE public.reservas OWNER TO postgres;
-- ddl-end --

-- object: public.pagos | type: TABLE --
-- DROP TABLE IF EXISTS public.pagos CASCADE;
CREATE TABLE public.pagos (
	pagoid integer NOT NULL,
	cantidad numeric(10,2) NOT NULL,
	fechapago timestamp NOT NULL,
	metodopago text NOT NULL,
	reservaid_reservas integer,
	CONSTRAINT pagos_pkey PRIMARY KEY (pagoid)
);
-- ddl-end --
ALTER TABLE public.pagos OWNER TO postgres;
-- ddl-end --

-- object: public.incidencias | type: TABLE --
-- DROP TABLE IF EXISTS public.incidencias CASCADE;
CREATE TABLE public.incidencias (
	incidenciaid integer NOT NULL,
	descripcion text NOT NULL,
	fechaincidencia timestamp NOT NULL,
	estado text NOT NULL,
	reservaid_reservas integer,
	CONSTRAINT incidencias_pkey PRIMARY KEY (incidenciaid)
);
-- ddl-end --
ALTER TABLE public.incidencias OWNER TO postgres;
-- ddl-end --

-- object: vehiculos_fk | type: CONSTRAINT --
-- ALTER TABLE public.reservas DROP CONSTRAINT IF EXISTS vehiculos_fk CASCADE;
ALTER TABLE public.reservas ADD CONSTRAINT vehiculos_fk FOREIGN KEY (vehiculoid_vehiculos)
REFERENCES public.vehiculos (vehiculoid) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: reservas_fk | type: CONSTRAINT --
-- ALTER TABLE public.incidencias DROP CONSTRAINT IF EXISTS reservas_fk CASCADE;
ALTER TABLE public.incidencias ADD CONSTRAINT reservas_fk FOREIGN KEY (reservaid_reservas)
REFERENCES public.reservas (reservaid) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: clientes_fk | type: CONSTRAINT --
-- ALTER TABLE public.vehiculos DROP CONSTRAINT IF EXISTS clientes_fk CASCADE;
ALTER TABLE public.vehiculos ADD CONSTRAINT clientes_fk FOREIGN KEY (clienteid_clientes)
REFERENCES public.clientes (clienteid) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: reservas_fk | type: CONSTRAINT --
-- ALTER TABLE public.pagos DROP CONSTRAINT IF EXISTS reservas_fk CASCADE;
ALTER TABLE public.pagos ADD CONSTRAINT reservas_fk FOREIGN KEY (reservaid_reservas)
REFERENCES public.reservas (reservaid) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: plazas_fk | type: CONSTRAINT --
-- ALTER TABLE public.reservas DROP CONSTRAINT IF EXISTS plazas_fk CASCADE;
ALTER TABLE public.reservas ADD CONSTRAINT plazas_fk FOREIGN KEY (plazaid_plazas)
REFERENCES public.plazas (plazaid) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: clientes_fk | type: CONSTRAINT --
-- ALTER TABLE public.reservas DROP CONSTRAINT IF EXISTS clientes_fk CASCADE;
ALTER TABLE public.reservas ADD CONSTRAINT clientes_fk FOREIGN KEY (clienteid_clientes)
REFERENCES public.clientes (clienteid) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: "grant_CU_eb94f049ac" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO postgres;
-- ddl-end --

-- object: "grant_CU_cd8e46e7b6" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO PUBLIC;
-- ddl-end --


