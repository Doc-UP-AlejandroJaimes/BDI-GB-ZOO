--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: animals; Type: SCHEMA; Schema: -; Owner: adminzoo
--

CREATE SCHEMA animals;


ALTER SCHEMA animals OWNER TO adminzoo;

--
-- Name: calcular_costo_final(); Type: FUNCTION; Schema: animals; Owner: postgres
--

CREATE FUNCTION animals.calcular_costo_final() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.CostoFinal := (
        SELECT h.CostoBase * (1 - (tv.Descuento / 100))
        FROM animals.HABITAT h, animals.TIPO_VISITANTES tv
        WHERE h.ID = NEW.IDHabitat AND tv.ID = (SELECT IDTipoVisitante FROM animals.VISITANTES WHERE ID = NEW.IDVisitantes)
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION animals.calcular_costo_final() OWNER TO postgres;

--
-- Name: calcular_descuento(numeric, numeric); Type: FUNCTION; Schema: animals; Owner: adminzoo
--

CREATE FUNCTION animals.calcular_descuento(p_costo_base numeric, p_descuento numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_costo_final NUMERIC;
BEGIN
    -- Calcular el costo final aplicando el descuento
    v_costo_final := p_costo_base * (1 - p_descuento / 100);
    RETURN v_costo_final;
END;
$$;


ALTER FUNCTION animals.calcular_descuento(p_costo_base numeric, p_descuento numeric) OWNER TO adminzoo;

--
-- Name: contar_visitas_habitat(character varying); Type: FUNCTION; Schema: animals; Owner: adminzoo
--

CREATE FUNCTION animals.contar_visitas_habitat(habitat_q character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- DECLARE
    contador_visitantes INT;
BEGIN
    -- BODY FUNCTION
    -- 1. Query statement
    SELECT
    COUNT(HV.*) AS VISITAS_HABITAT
    INTO contador_visitantes
    FROM HABITAT_VISITANTES HV
    INNER JOIN HABITAT H ON HV.IdHabitat = H.ID
    -- 2. Apply condition statement
    WHERE H.nombre = habitat_q;
    -- 2. storage value into declare variable.
    -- 3. returns value;
    RETURN contador_visitantes;
END;
$$;


ALTER FUNCTION animals.contar_visitas_habitat(habitat_q character varying) OWNER TO adminzoo;

--
-- Name: count_assistants_habitat(character varying); Type: FUNCTION; Schema: animals; Owner: adminzoo
--

CREATE FUNCTION animals.count_assistants_habitat(habitat_q character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
   assitants_count INT;
BEGIN
   -- 1. Query to search assistants by specific habitat
   SELECT COUNT(HV.*) total_assistants
   -- 2. save result in variable asssitants_count
   into assitants_count
   FROM HABITAT_VISITANTES HV
   INNER JOIN HABITAT H ON HV.IdHabitat = H.ID
   WHERE H.NOMBRE = habitat_q;
   -- 3. return result
   RETURN assitants_count;
END;
$$;


ALTER FUNCTION animals.count_assistants_habitat(habitat_q character varying) OWNER TO adminzoo;

--
-- Name: registrar_cambios_animales(); Type: FUNCTION; Schema: animals; Owner: postgres
--

CREATE FUNCTION animals.registrar_cambios_animales() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO animals.AUDITORIA_ANIMALES (IDAnimal, NombreAnterior, NombreNuevo, FechaNacAnterior, FechaNacNueva, ActualizadoPor)
    VALUES (
        OLD.ID,
        OLD.Nombre, --Nombre antes del cambio.
        NEW.Nombre, -- Nombre despúes del cambio.
        CASE WHEN OLD.FechaNac IS DISTINCT FROM New.FechaNac 
        THEN OLD.FechaNac ELSE NULL END, -- Fecha de nacimiento anterior si cambia
        CASE WHEN OLD.FechaNac IS DISTINCT FROM New.FechaNac 
        THEN NEW.FechaNac ELSE NULL END,  -- Fecha de nacimiento nueva si cambia
        SESSION_USER -- Usuario que realiza la actualización.
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION animals.registrar_cambios_animales() OWNER TO postgres;

--
-- Name: registrar_visita(integer, integer, date); Type: PROCEDURE; Schema: animals; Owner: adminzoo
--

CREATE PROCEDURE animals.registrar_visita(IN p_id_habitat integer, IN p_id_visitante integer, IN p_fecha_visita date)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_costo_base NUMERIC;
    v_descuento NUMERIC;
    v_costo_final NUMERIC;
BEGIN
    -- Obtener el costo base del hÃ¡bitat
    SELECT CostoBase 
    INTO v_costo_base 
    FROM animals.Habitat 
    WHERE ID = p_id_habitat;

    -- Obtener el descuento del tipo de visitante
    SELECT 
            Descuento 
    INTO    v_descuento 
    FROM animals.TIPO_VISITANTES TV
    JOIN animals.VISITANTES V ON V.IDTipoVisitante = TV.ID
    WHERE V.ID = p_id_visitante;

    -- Llamar a la funciÃ³n para calcular el costo final
    v_costo_final := animals.calcular_descuento(v_costo_base, v_descuento);

    -- Insertar la visita en la tabla Habitat_Visitantes con el costo calculado
    INSERT INTO animals.HABITAT_VISITANTES (IDHabitat, IDVisitantes, FechaVisita, CostoFinal)
    VALUES (p_id_habitat, p_id_visitante, p_fecha_visita, v_costo_final);
END;
$$;


ALTER PROCEDURE animals.registrar_visita(IN p_id_habitat integer, IN p_id_visitante integer, IN p_fecha_visita date) OWNER TO adminzoo;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: animales; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.animales (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fechanac date,
    idcuidador integer NOT NULL,
    idhabitat integer NOT NULL,
    idespecie integer NOT NULL
);


ALTER TABLE animals.animales OWNER TO adminzoo;

--
-- Name: animales_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.animales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.animales_id_seq OWNER TO adminzoo;

--
-- Name: animales_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.animales_id_seq OWNED BY animals.animales.id;


--
-- Name: animales_idcuidador_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.animales_idcuidador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.animales_idcuidador_seq OWNER TO adminzoo;

--
-- Name: animales_idcuidador_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.animales_idcuidador_seq OWNED BY animals.animales.idcuidador;


--
-- Name: animales_idespecie_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.animales_idespecie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.animales_idespecie_seq OWNER TO adminzoo;

--
-- Name: animales_idespecie_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.animales_idespecie_seq OWNED BY animals.animales.idespecie;


--
-- Name: animales_idhabitat_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.animales_idhabitat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.animales_idhabitat_seq OWNER TO adminzoo;

--
-- Name: animales_idhabitat_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.animales_idhabitat_seq OWNED BY animals.animales.idhabitat;


--
-- Name: auditoria_animales; Type: TABLE; Schema: animals; Owner: postgres
--

CREATE TABLE animals.auditoria_animales (
    id integer NOT NULL,
    idanimal integer,
    nombreanterior character varying(50),
    nombrenuevo character varying(50),
    fechanacanterior date,
    fechanacnueva date,
    actualizadopor character varying(50),
    fechacambio timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE animals.auditoria_animales OWNER TO postgres;

--
-- Name: auditoria_animales_id_seq; Type: SEQUENCE; Schema: animals; Owner: postgres
--

CREATE SEQUENCE animals.auditoria_animales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.auditoria_animales_id_seq OWNER TO postgres;

--
-- Name: auditoria_animales_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: postgres
--

ALTER SEQUENCE animals.auditoria_animales_id_seq OWNED BY animals.auditoria_animales.id;


--
-- Name: clima; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.clima (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE animals.clima OWNER TO adminzoo;

--
-- Name: clima_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.clima_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.clima_id_seq OWNER TO adminzoo;

--
-- Name: clima_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.clima_id_seq OWNED BY animals.clima.id;


--
-- Name: cuidador; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.cuidador (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fechacontratacion date NOT NULL,
    salario numeric(10,2) NOT NULL,
    idespecialidad integer NOT NULL
);


ALTER TABLE animals.cuidador OWNER TO adminzoo;

--
-- Name: cuidador_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.cuidador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.cuidador_id_seq OWNER TO adminzoo;

--
-- Name: cuidador_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.cuidador_id_seq OWNED BY animals.cuidador.id;


--
-- Name: cuidador_idespecialidad_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.cuidador_idespecialidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.cuidador_idespecialidad_seq OWNER TO adminzoo;

--
-- Name: cuidador_idespecialidad_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.cuidador_idespecialidad_seq OWNED BY animals.cuidador.idespecialidad;


--
-- Name: especialidad; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.especialidad (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE animals.especialidad OWNER TO adminzoo;

--
-- Name: especialidad_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.especialidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.especialidad_id_seq OWNER TO adminzoo;

--
-- Name: especialidad_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.especialidad_id_seq OWNED BY animals.especialidad.id;


--
-- Name: especie; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.especie (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    idfamilia integer NOT NULL,
    idestadoconservacion integer NOT NULL
);


ALTER TABLE animals.especie OWNER TO adminzoo;

--
-- Name: especie_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.especie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.especie_id_seq OWNER TO adminzoo;

--
-- Name: especie_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.especie_id_seq OWNED BY animals.especie.id;


--
-- Name: especie_idestadoconservacion_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.especie_idestadoconservacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.especie_idestadoconservacion_seq OWNER TO adminzoo;

--
-- Name: especie_idestadoconservacion_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.especie_idestadoconservacion_seq OWNED BY animals.especie.idestadoconservacion;


--
-- Name: especie_idfamilia_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.especie_idfamilia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.especie_idfamilia_seq OWNER TO adminzoo;

--
-- Name: especie_idfamilia_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.especie_idfamilia_seq OWNED BY animals.especie.idfamilia;


--
-- Name: estado_conservacion; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.estado_conservacion (
    id integer NOT NULL,
    codigo character varying(2) NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE animals.estado_conservacion OWNER TO adminzoo;

--
-- Name: estado_conservacion_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.estado_conservacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.estado_conservacion_id_seq OWNER TO adminzoo;

--
-- Name: estado_conservacion_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.estado_conservacion_id_seq OWNED BY animals.estado_conservacion.id;


--
-- Name: familia; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.familia (
    id integer NOT NULL,
    nombrecientifico character varying(50) NOT NULL,
    nombrecomun character varying(50) NOT NULL
);


ALTER TABLE animals.familia OWNER TO adminzoo;

--
-- Name: familia_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.familia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.familia_id_seq OWNER TO adminzoo;

--
-- Name: familia_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.familia_id_seq OWNED BY animals.familia.id;


--
-- Name: habitat; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.habitat (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    idubicacion integer NOT NULL,
    costobase numeric(10,2) NOT NULL,
    idclima integer NOT NULL
);


ALTER TABLE animals.habitat OWNER TO adminzoo;

--
-- Name: habitat_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.habitat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.habitat_id_seq OWNER TO adminzoo;

--
-- Name: habitat_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.habitat_id_seq OWNED BY animals.habitat.id;


--
-- Name: habitat_idclima_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.habitat_idclima_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.habitat_idclima_seq OWNER TO adminzoo;

--
-- Name: habitat_idclima_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.habitat_idclima_seq OWNED BY animals.habitat.idclima;


--
-- Name: habitat_idubicacion_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.habitat_idubicacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.habitat_idubicacion_seq OWNER TO adminzoo;

--
-- Name: habitat_idubicacion_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.habitat_idubicacion_seq OWNED BY animals.habitat.idubicacion;


--
-- Name: habitat_visitantes; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.habitat_visitantes (
    id integer NOT NULL,
    idhabitat integer NOT NULL,
    idvisitantes integer NOT NULL,
    costofinal numeric(10,2) NOT NULL,
    fechavisita date
);


ALTER TABLE animals.habitat_visitantes OWNER TO adminzoo;

--
-- Name: habitat_visitantes_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.habitat_visitantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.habitat_visitantes_id_seq OWNER TO adminzoo;

--
-- Name: habitat_visitantes_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.habitat_visitantes_id_seq OWNED BY animals.habitat_visitantes.id;


--
-- Name: habitat_visitantes_idhabitat_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.habitat_visitantes_idhabitat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.habitat_visitantes_idhabitat_seq OWNER TO adminzoo;

--
-- Name: habitat_visitantes_idhabitat_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.habitat_visitantes_idhabitat_seq OWNED BY animals.habitat_visitantes.idhabitat;


--
-- Name: habitat_visitantes_idvisitantes_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.habitat_visitantes_idvisitantes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.habitat_visitantes_idvisitantes_seq OWNER TO adminzoo;

--
-- Name: habitat_visitantes_idvisitantes_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.habitat_visitantes_idvisitantes_seq OWNED BY animals.habitat_visitantes.idvisitantes;


--
-- Name: tipo_visitantes; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.tipo_visitantes (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descuento numeric(5,2) NOT NULL,
    CONSTRAINT tipo_visitantes_descuento_check CHECK (((descuento >= (0)::numeric) AND (descuento <= (100)::numeric)))
);


ALTER TABLE animals.tipo_visitantes OWNER TO adminzoo;

--
-- Name: tipo_visitantes_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.tipo_visitantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.tipo_visitantes_id_seq OWNER TO adminzoo;

--
-- Name: tipo_visitantes_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.tipo_visitantes_id_seq OWNED BY animals.tipo_visitantes.id;


--
-- Name: ubicacion; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.ubicacion (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE animals.ubicacion OWNER TO adminzoo;

--
-- Name: ubicacion_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.ubicacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.ubicacion_id_seq OWNER TO adminzoo;

--
-- Name: ubicacion_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.ubicacion_id_seq OWNED BY animals.ubicacion.id;


--
-- Name: visitantes; Type: TABLE; Schema: animals; Owner: adminzoo
--

CREATE TABLE animals.visitantes (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    idtipovisitante integer NOT NULL
);


ALTER TABLE animals.visitantes OWNER TO adminzoo;

--
-- Name: visitantes_id_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.visitantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.visitantes_id_seq OWNER TO adminzoo;

--
-- Name: visitantes_id_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.visitantes_id_seq OWNED BY animals.visitantes.id;


--
-- Name: visitantes_idtipovisitante_seq; Type: SEQUENCE; Schema: animals; Owner: adminzoo
--

CREATE SEQUENCE animals.visitantes_idtipovisitante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE animals.visitantes_idtipovisitante_seq OWNER TO adminzoo;

--
-- Name: visitantes_idtipovisitante_seq; Type: SEQUENCE OWNED BY; Schema: animals; Owner: adminzoo
--

ALTER SEQUENCE animals.visitantes_idtipovisitante_seq OWNED BY animals.visitantes.idtipovisitante;


--
-- Name: animales id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales ALTER COLUMN id SET DEFAULT nextval('animals.animales_id_seq'::regclass);


--
-- Name: animales idcuidador; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales ALTER COLUMN idcuidador SET DEFAULT nextval('animals.animales_idcuidador_seq'::regclass);


--
-- Name: animales idhabitat; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales ALTER COLUMN idhabitat SET DEFAULT nextval('animals.animales_idhabitat_seq'::regclass);


--
-- Name: animales idespecie; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales ALTER COLUMN idespecie SET DEFAULT nextval('animals.animales_idespecie_seq'::regclass);


--
-- Name: auditoria_animales id; Type: DEFAULT; Schema: animals; Owner: postgres
--

ALTER TABLE ONLY animals.auditoria_animales ALTER COLUMN id SET DEFAULT nextval('animals.auditoria_animales_id_seq'::regclass);


--
-- Name: clima id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.clima ALTER COLUMN id SET DEFAULT nextval('animals.clima_id_seq'::regclass);


--
-- Name: cuidador id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.cuidador ALTER COLUMN id SET DEFAULT nextval('animals.cuidador_id_seq'::regclass);


--
-- Name: cuidador idespecialidad; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.cuidador ALTER COLUMN idespecialidad SET DEFAULT nextval('animals.cuidador_idespecialidad_seq'::regclass);


--
-- Name: especialidad id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especialidad ALTER COLUMN id SET DEFAULT nextval('animals.especialidad_id_seq'::regclass);


--
-- Name: especie id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especie ALTER COLUMN id SET DEFAULT nextval('animals.especie_id_seq'::regclass);


--
-- Name: especie idfamilia; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especie ALTER COLUMN idfamilia SET DEFAULT nextval('animals.especie_idfamilia_seq'::regclass);


--
-- Name: especie idestadoconservacion; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especie ALTER COLUMN idestadoconservacion SET DEFAULT nextval('animals.especie_idestadoconservacion_seq'::regclass);


--
-- Name: estado_conservacion id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.estado_conservacion ALTER COLUMN id SET DEFAULT nextval('animals.estado_conservacion_id_seq'::regclass);


--
-- Name: familia id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.familia ALTER COLUMN id SET DEFAULT nextval('animals.familia_id_seq'::regclass);


--
-- Name: habitat id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat ALTER COLUMN id SET DEFAULT nextval('animals.habitat_id_seq'::regclass);


--
-- Name: habitat idubicacion; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat ALTER COLUMN idubicacion SET DEFAULT nextval('animals.habitat_idubicacion_seq'::regclass);


--
-- Name: habitat idclima; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat ALTER COLUMN idclima SET DEFAULT nextval('animals.habitat_idclima_seq'::regclass);


--
-- Name: habitat_visitantes id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat_visitantes ALTER COLUMN id SET DEFAULT nextval('animals.habitat_visitantes_id_seq'::regclass);


--
-- Name: habitat_visitantes idhabitat; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat_visitantes ALTER COLUMN idhabitat SET DEFAULT nextval('animals.habitat_visitantes_idhabitat_seq'::regclass);


--
-- Name: habitat_visitantes idvisitantes; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat_visitantes ALTER COLUMN idvisitantes SET DEFAULT nextval('animals.habitat_visitantes_idvisitantes_seq'::regclass);


--
-- Name: tipo_visitantes id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.tipo_visitantes ALTER COLUMN id SET DEFAULT nextval('animals.tipo_visitantes_id_seq'::regclass);


--
-- Name: ubicacion id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.ubicacion ALTER COLUMN id SET DEFAULT nextval('animals.ubicacion_id_seq'::regclass);


--
-- Name: visitantes id; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.visitantes ALTER COLUMN id SET DEFAULT nextval('animals.visitantes_id_seq'::regclass);


--
-- Name: visitantes idtipovisitante; Type: DEFAULT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.visitantes ALTER COLUMN idtipovisitante SET DEFAULT nextval('animals.visitantes_idtipovisitante_seq'::regclass);


--
-- Data for Name: animales; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.animales (id, nombre, fechanac, idcuidador, idhabitat, idespecie) FROM stdin;
2	Saphira	2020-05-12	2	5	58
3	Mushu	2019-07-30	17	5	63
4	Kaa	2018-04-21	17	5	62
5	Scales	2017-09-11	17	5	61
6	Spike	2018-06-30	2	5	59
7	Rango	2019-03-01	2	5	58
8	Slither	2016-11-23	17	5	63
9	Snap	2020-02-14	2	5	62
10	Toothy	2021-05-06	17	5	60
11	Flipper	2015-08-15	4	8	40
12	Splash	2016-12-10	13	9	35
13	Blue	2017-11-22	4	8	40
14	Waves	2018-05-30	13	9	42
15	Pearl	2019-09-19	4	8	43
16	Oceana	2017-03-11	4	9	43
17	Finn	2018-08-25	13	8	40
18	Bubble	2016-04-09	13	9	41
19	Shelly	2019-06-13	4	8	43
20	Coral	2021-02-28	13	9	35
21	Polly	2021-04-11	3	10	33
22	Sky	2019-06-15	18	11	32
23	Feather	2018-08-08	3	10	31
24	Pico	2020-10-20	18	11	33
25	Echo	2017-12-30	3	10	30
26	Wings	2019-05-21	3	11	32
27	Chirp	2020-08-10	18	11	33
28	Beaky	2018-09-15	3	10	30
29	Whistle	2021-01-25	18	11	33
30	Plume	2016-07-18	18	11	30
31	Koko	2014-10-27	5	19	23
32	George	2015-02-03	20	19	22
33	Caesar	2016-02-28	5	19	26
34	Jumbo	2017-09-23	20	19	20
35	Bobo	2018-04-20	5	19	17
36	Momo	2019-11-15	5	19	20
37	Zuri	2016-07-10	5	19	22
38	Mufasa	2020-03-30	20	19	24
39	Lila	2021-05-12	20	19	20
40	Rafiki	2018-09-25	5	19	23
41	Ziggy	2023-04-15	11	21	48
42	Buzz	2023-05-18	11	21	46
43	Flutter	2021-09-23	11	21	48
44	Anty	2020-04-15	11	21	44
45	Cricket	2019-02-28	11	21	50
46	Beetle	2018-06-10	11	21	45
47	Bumble	2019-05-12	11	21	47
48	Butter	2021-08-21	11	21	49
49	Glow	2017-10-09	11	21	51
50	Sting	2020-01-20	11	21	52
51	Flick	2019-11-01	11	21	44
52	Kodiak	2018-01-17	6	13	12
53	Baloo	2017-03-17	6	13	12
54	Winnie	2018-08-25	6	13	14
55	Panda	2016-11-15	6	13	15
56	Grizzly	2015-05-28	6	13	12
57	Kodiak	2019-10-10	6	13	12
58	Teddy	2020-03-05	6	13	14
59	Ranger	2017-09-01	6	13	15
60	Yogi	2018-04-11	6	13	12
61	Bruno	2019-12-18	6	13	14
62	Grizz	2021-07-07	6	13	12
63	Twilight	2021-09-11	8	16	53
64	Luna	2019-12-25	8	16	54
65	Shadow	2020-10-31	8	16	53
66	Owliver	2018-06-14	8	16	55
67	Midnight	2017-08-18	8	16	54
68	Starlight	2020-01-10	8	16	56
69	Twilight	2019-09-11	8	16	53
70	Echo	2021-05-27	8	16	55
71	Noctis	2019-03-13	8	16	54
72	Nebula	2020-07-19	8	16	56
73	Shade	2018-11-04	8	16	53
74	Manny	2019-06-02	9	23	27
75	Dumbo	2018-08-08	15	23	28
76	Manny	2019-06-02	9	23	27
77	Babar	2017-09-09	9	23	27
78	Ella	2018-12-12	15	23	28
79	Hathi	2016-11-12	9	23	27
80	Jumbo	2021-03-15	15	23	28
81	Tusker	2019-04-14	9	23	27
82	Trunky	2020-02-22	9	23	28
83	Ellaine	2017-01-19	15	23	29
84	Tantor	2016-05-05	9	23	27
85	Simba	2018-06-12	1	20	1
86	Nala	2018-07-21	1	20	1
87	Raja	2019-04-22	16	20	2
88	Shere Khan	2017-12-25	16	20	2
89	Bagheera	2017-11-05	1	20	5
90	Leo	2020-01-15	1	20	1
91	Cleo	2019-03-29	1	20	4
92	Khan	2016-11-11	16	20	2
93	Pardo	2018-10-20	1	20	6
94	Panther	2017-08-03	16	20	3
95	Clareth	2004-10-07	6	12	13
1	Nagini	1980-03-18	2	5	57
\.


--
-- Data for Name: auditoria_animales; Type: TABLE DATA; Schema: animals; Owner: postgres
--

COPY animals.auditoria_animales (id, idanimal, nombreanterior, nombrenuevo, fechanacanterior, fechanacnueva, actualizadopor, fechacambio) FROM stdin;
1	1	Nagini	Nerón	\N	\N	postgres	2024-11-26 20:09:31.422907
2	1	Nerón	Nagini	2020-03-18	1980-03-18	postgres	2024-11-26 20:09:49.587615
\.


--
-- Data for Name: clima; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.clima (id, nombre) FROM stdin;
1	Tropical
2	Desertico
3	Templado
4	Mediterraneo
5	Polar
6	Continental
7	Subtropical
8	Monzonico
9	Arido
10	Humedo
11	Nuboso
12	Lluvioso
13	Seco
14	Marino
15	Alpino
\.


--
-- Data for Name: cuidador; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.cuidador (id, nombre, fechacontratacion, salario, idespecialidad) FROM stdin;
1	Juan Pérez	2021-05-10	2500000.00	1
2	María López	2019-03-15	3000000.00	2
3	Carlos Gómez	2020-08-01	2700000.00	3
4	Ana Rivas	2022-02-18	2800000.00	4
5	Pedro Sánchez	2018-12-22	3200000.00	5
6	Laura Torres	2023-06-11	2600000.00	6
7	Miguel Díaz	2020-09-03	2900000.00	7
8	Lucía Ortega	2017-11-28	3100000.00	8
9	Roberto Castro	2019-10-15	3300000.00	9
10	Carmen Suárez	2022-04-30	3400000.00	10
11	Elena Martínez	2018-01-09	2500000.00	11
12	Tomás Romero	2021-07-23	3000000.00	12
13	Daniela Méndez	2023-03-05	2750000.00	13
14	Javier Ruiz	2022-09-14	2900000.00	14
15	Sofía Morales	2019-06-27	2850000.00	15
16	Luis Fernández	2020-10-12	2950000.00	1
17	Patricia Navarro	2018-08-06	3100000.00	2
18	Francisco Herrera	2021-05-30	2600000.00	3
19	Clara Jiménez	2019-12-20	3250000.00	4
20	José García	2023-01-15	2700000.00	5
\.


--
-- Data for Name: especialidad; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.especialidad (id, nombre) FROM stdin;
1	Manejo de Grandes Felinos
2	Cuidados de Reptiles
3	Aves Exoticas
4	Mamiferos Marinos
5	Primates
6	Animales de Clima Frio
7	Animales en Peligro de Extincion
8	Animales Nocturnos
9	Grandes Herbivoros
10	Manejo de Veneno y Antidotos
11	Cuidados de Insectos
12	Animales del Desierto
13	Acuario
14	Animales Domesticos
15	Cria en Cautiverio
\.


--
-- Data for Name: especie; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.especie (id, nombre, idfamilia, idestadoconservacion) FROM stdin;
1	León	1	5
2	Tigre	1	4
3	Jaguar	1	6
4	Leopardo	1	5
5	Pantera	1	5
6	Guepardo	1	5
7	Lobo	2	7
8	Coyote	2	7
9	Zorro Rojo	2	7
10	Licaón	2	4
11	Perro Salvaje Africano	2	4
12	Oso Pardo	3	5
13	Oso Polar	3	5
14	Oso Negro Americano	3	7
15	Panda Gigante	3	4
16	Oso Perezoso	3	5
17	Babuino	4	7
18	Macaco Rhesus	4	7
19	Colobo Guereza	4	5
20	Mandril	4	5
21	Mono Gelada	4	6
22	Gorila de Montaña	5	3
23	Chimpancé	5	4
24	Orangután de Borneo	5	3
25	Ser Humano	5	7
26	Bonobo	5	4
27	Elefante Africano	6	5
28	Elefante Asiático	6	4
29	Elefante de Selva Africano	6	5
30	Guacamayo Rojo	7	4
31	Loro Amazónico	7	7
32	Kea	7	6
33	Loro Gris Africano	7	4
34	Periquito Común	7	7
35	Tortuga Gigante de Galápagos	8	3
36	Tortuga Sulcata	8	5
37	Tortuga Gigante de Aldabra	8	5
38	Tortuga de Gopher	8	6
39	Tortuga Estrellada de Madagascar	8	4
40	Delfín	10	5
41	Orca	10	5
42	Ballena	11	3
43	Foca	12	4
44	Hormiga Gigante	13	7
45	Escarabajo	14	7
46	Escarabajo Rinoceronte	14	5
47	Abejorro	15	6
48	Mariposa Monarca	16	4
49	Mariposa Azul	16	6
50	Grillo	19	7
51	Luciérnaga	17	7
52	Avispa	18	7
53	Murciélago Vampiro	20	7
54	Lince Boreal	1	5
55	Lechuza	21	7
56	Zorro Volador	22	5
57	Cocodrilo Marino	9	7
58	Cocodrilo del Nilo	9	7
59	Crocodylus niloticus	9	7
60	Crocodylus porosus	9	7
61	Aligátor Americano	9	7
62	Caimán de Anteojos	9	7
63	Gavial	9	4
\.


--
-- Data for Name: estado_conservacion; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.estado_conservacion (id, codigo, nombre, descripcion) FROM stdin;
1	EX	Extinto	La especie ya no existe
2	EW	Extinto en estado salvaje	Solo sobrevive en cautiverio
3	CR	En peligro critico	En peligro extremo de extinción
4	EN	En peligro	Alto riesgo de extincion
5	VU	Vulnerable	Riesgo elevado de extincion a mediano plazo
6	NT	Casi amenazado	En riesgo, pero no aun en peligro
7	LC	Preocupacion menor	Bajo riesgo de extincion
8	DD	Datos deficientes	No hay informacion suficiente
9	NE	No evaluado	Aun no se ha evaluado el estado de conservacion
\.


--
-- Data for Name: familia; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.familia (id, nombrecientifico, nombrecomun) FROM stdin;
1	Felidae	Felinos
2	Canidae	Canidos
3	Ursidae	Ursidos
4	Cercopithecidae	Monos del viejo mundo
5	Hominidae	Grandes simios
6	Elephantidae	Elefantes
7	Psittacidae	Loros
8	Testudinidae	Tortugas terrestres
9	Crocodylidae	Cocodrilos
10	Delphinidae	Delfín
11	Balaenopteridae	Ballena
12	Phocidae	Foca
13	Formicidae	Hormigas
14	Coleoptera	Escarabajos
15	Apidae	Abejorros
16	Nymphalidae	Mariposas
17	Lampyridae	Luciernagas
18	Vespidae	Avispas
19	Gryllidae	Grillos
20	Vespertilionidae	Murciélagos
21	Strigidae	Lechuzas
22	Pteropodidae	Zorros voladores
\.


--
-- Data for Name: habitat; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.habitat (id, nombre, idubicacion, costobase, idclima) FROM stdin;
1	Selva densa tropical	1	16226.08	1
2	Llanura africana	7	7663.32	1
3	Humedal tropical	8	13350.56	12
4	Desierto arenoso	2	19947.11	2
5	Cañón seco	6	9803.23	9
6	Pico nevado	3	16689.14	15
7	Bosque templado alto	3	7994.99	3
8	Reef coralino	5	9336.00	14
9	Manglares costeros	5	19703.82	10
10	Santuario de aves tropicales	4	18322.90	1
11	Páramo de aves rapaces	4	15134.96	13
12	Tundra ártica	14	11647.01	5
13	Bosque de coníferas	3	17211.45	5
14	Vivero tropical	17	17611.37	10
15	Estepa continental	13	12877.82	6
16	Refugio crepuscular	15	13332.48	11
17	Costa rocosa	18	9518.37	14
18	Exhibición de biomas	10	18507.38	3
19	Reserva de fauna	11	14005.16	3
20	Territorio felino	19	5851.57	1
21	Insectario tropical	16	18496.67	10
22	Valle de aves	12	6220.93	12
23	Llanura de mamíferos	9	8990.96	6
\.


--
-- Data for Name: habitat_visitantes; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.habitat_visitantes (id, idhabitat, idvisitantes, costofinal, fechavisita) FROM stdin;
1	10	713	14658.32	2021-10-05
2	10	732	18322.90	2023-06-28
3	12	594	8735.26	2023-10-09
4	20	21	4388.68	2023-02-10
5	23	136	8990.96	2021-12-10
6	15	666	12877.82	2023-05-30
7	13	200	13769.16	2021-09-22
8	15	257	12877.82	2020-03-04
9	23	28	8990.96	2023-10-23
10	15	846	11590.04	2022-01-15
11	13	915	15490.31	2020-09-11
12	12	347	11647.01	2020-10-14
13	15	585	10302.26	2022-12-28
14	16	566	9999.36	2021-03-07
15	18	80	13880.54	2023-02-26
16	23	814	7192.77	2023-04-04
17	6	475	13351.31	2021-12-23
18	23	232	7192.77	2023-05-20
19	4	257	19947.11	2022-05-04
20	12	603	8735.26	2022-01-23
21	13	233	17211.45	2022-02-06
22	23	274	7192.77	2022-08-29
23	6	912	15020.23	2021-05-01
24	23	406	8091.86	2021-03-10
25	11	46	12107.97	2023-12-03
26	2	685	5747.49	2019-12-04
27	9	870	19703.82	2022-01-17
28	1	166	12980.86	2022-06-19
29	13	194	13769.16	2023-03-19
30	23	764	7192.77	2021-12-19
31	8	769	8402.40	2023-02-06
32	13	938	15490.31	2022-04-16
33	9	659	14777.87	2023-01-09
34	4	81	17952.40	2023-09-12
35	23	851	8091.86	2021-09-14
36	5	545	8822.91	2023-05-21
37	11	272	15134.96	2022-04-21
38	21	753	13872.50	2022-05-11
39	13	466	17211.45	2020-05-04
40	18	485	14805.90	2023-07-20
41	6	862	15020.23	2023-01-07
42	19	387	12604.64	2023-05-12
43	9	256	14777.87	2021-08-21
44	22	761	6220.93	2022-07-25
45	5	898	7352.42	2023-01-02
46	9	203	16748.25	2023-05-04
47	10	475	14658.32	2020-06-13
48	16	167	11999.23	2021-12-12
49	12	631	9899.96	2020-03-22
50	13	200	13769.16	2023-07-17
51	19	564	12604.64	2023-01-02
52	1	184	14603.47	2023-03-17
53	9	320	19703.82	2023-09-18
54	13	302	14629.73	2022-02-16
55	15	462	9658.37	2021-02-03
56	14	702	13208.53	2020-05-19
57	13	932	15490.31	2022-07-31
58	2	669	5747.49	2023-04-23
59	22	532	6220.93	2022-05-16
60	9	707	15763.06	2023-09-12
61	21	540	13872.50	2023-12-20
62	8	762	8402.40	2019-11-02
63	13	340	14629.73	2022-11-25
64	9	304	14777.87	2021-03-01
65	5	239	7842.58	2023-04-06
66	11	981	11351.22	2022-11-06
67	2	212	6896.99	2021-06-30
68	19	435	12604.64	2020-05-31
69	16	215	11999.23	2020-08-29
70	12	21	8735.26	2023-10-14
71	10	212	16490.61	2021-07-15
72	13	576	12908.59	2023-07-15
73	8	166	7468.80	2020-11-03
74	14	654	14969.66	2020-09-23
75	22	983	5287.79	2020-03-19
76	12	761	11647.01	2022-04-15
77	18	802	14805.90	2020-11-21
78	6	533	14185.77	2021-04-28
79	3	860	12015.50	2023-01-22
80	11	95	11351.22	2023-06-08
81	3	9	10680.45	2022-08-12
82	7	358	6795.74	2023-01-02
83	11	835	11351.22	2022-03-14
84	1	569	14603.47	2023-07-02
85	22	99	4976.74	2023-06-22
86	23	173	8990.96	2021-10-08
87	6	223	13351.31	2023-06-20
88	18	434	13880.54	2023-10-09
89	3	866	12015.50	2021-04-23
90	14	253	13208.53	2023-09-09
91	8	575	7935.60	2021-03-20
92	23	765	8091.86	2021-11-27
93	5	915	8822.91	2019-11-15
94	8	660	8402.40	2021-01-17
95	14	107	13208.53	2023-09-05
96	17	163	9518.37	2020-02-20
97	4	71	17952.40	2023-09-09
98	10	888	13742.18	2020-09-19
99	19	683	11204.13	2020-09-11
100	9	913	17733.44	2023-04-06
101	18	436	18507.38	2023-10-18
102	23	500	7192.77	2023-10-30
103	23	991	7192.77	2023-05-04
104	17	865	8090.61	2020-03-17
105	1	96	12169.56	2021-10-07
106	8	36	7935.60	2023-04-23
107	8	277	7468.80	2022-12-16
108	21	636	15722.17	2022-01-29
109	12	400	11647.01	2021-04-11
110	22	675	4665.70	2021-05-14
111	17	122	8566.53	2023-05-03
112	22	238	4665.70	2023-08-05
113	10	548	15574.47	2021-08-01
114	23	40	8091.86	2020-06-19
115	23	197	8091.86	2022-08-29
116	19	523	12604.64	2023-04-10
117	8	192	7002.00	2023-09-26
118	12	417	9317.61	2023-08-20
119	18	469	18507.38	2023-04-13
120	2	820	6130.66	2020-06-01
121	20	875	5851.57	2022-11-11
122	4	160	14960.33	2020-06-06
123	21	305	15722.17	2020-09-27
124	11	832	15134.96	2020-07-04
125	11	489	15134.96	2022-05-16
126	14	928	13208.53	2020-09-11
127	9	921	16748.25	2021-12-27
128	23	446	7192.77	2021-10-05
129	1	388	16226.08	2023-08-23
130	7	389	6795.74	2023-01-04
131	15	201	10302.26	2020-11-17
132	23	253	6743.22	2020-10-05
133	5	282	7842.58	2019-11-28
134	4	253	14960.33	2021-03-28
135	17	725	7138.78	2023-09-08
136	6	974	14185.77	2021-01-16
137	15	202	9658.37	2023-08-01
138	8	685	7002.00	2023-09-01
139	6	55	16689.14	2022-11-09
140	4	79	16955.04	2023-04-11
141	9	230	15763.06	2020-07-20
142	5	595	8332.75	2022-10-05
143	19	236	14005.16	2023-03-15
144	1	838	16226.08	2023-03-03
145	9	709	15763.06	2020-03-05
146	12	879	8735.26	2023-05-16
147	13	941	17211.45	2023-06-08
148	11	19	11351.22	2020-06-06
149	20	369	5851.57	2020-03-19
150	15	928	9658.37	2023-06-02
151	13	420	17211.45	2021-03-13
152	16	928	9999.36	2021-03-01
153	20	231	4388.68	2022-03-12
154	23	115	6743.22	2023-03-10
155	22	2	4976.74	2022-07-13
156	16	911	10665.98	2022-01-06
157	11	779	11351.22	2023-04-14
158	17	891	8566.53	2022-09-26
159	20	330	4388.68	2023-10-21
160	18	237	18507.38	2020-02-26
161	9	296	14777.87	2023-01-12
162	13	813	15490.31	2023-05-08
163	14	406	15850.23	2023-11-09
164	7	845	7994.99	2021-04-08
165	5	347	9803.23	2023-09-29
166	1	618	12980.86	2020-01-20
167	11	847	12864.72	2023-06-09
168	23	52	7192.77	2023-08-23
169	2	416	7663.32	2021-08-16
170	6	952	15020.23	2023-03-31
171	14	783	14969.66	2021-09-13
172	22	600	5598.84	2023-11-02
173	5	177	9803.23	2023-08-20
174	6	427	14185.77	2020-03-06
175	13	536	14629.73	2021-05-10
176	8	735	7935.60	2020-08-19
177	13	116	13769.16	2022-04-04
178	20	383	4681.26	2021-10-22
179	23	779	6743.22	2020-05-20
180	16	429	11332.61	2023-09-16
181	9	593	17733.44	2023-01-26
182	4	833	16955.04	2022-05-15
183	17	122	8566.53	2023-04-10
184	20	573	4388.68	2021-03-09
185	17	571	8566.53	2023-06-18
186	5	542	8822.91	2023-12-06
187	12	258	11647.01	2020-11-09
188	2	178	5747.49	2022-07-10
189	2	556	5747.49	2021-11-17
190	19	495	10503.87	2020-09-16
191	21	827	18496.67	2020-08-14
192	11	87	11351.22	2022-07-28
193	3	223	10680.45	2023-07-31
194	12	922	10482.31	2023-03-12
195	5	144	7842.58	2023-09-07
196	6	925	12516.86	2023-08-12
197	23	740	7192.77	2019-11-23
198	4	670	19947.11	2020-12-25
199	15	13	12877.82	2022-01-28
200	22	884	4976.74	2020-05-14
201	13	870	17211.45	2023-12-19
202	21	719	18496.67	2021-09-02
203	13	711	14629.73	2020-10-18
204	15	772	9658.37	2020-07-02
205	9	461	14777.87	2023-02-04
206	10	766	15574.47	2021-11-13
207	17	510	8090.61	2023-10-31
208	22	67	5287.79	2022-02-16
209	16	371	11999.23	2021-07-14
210	15	148	9658.37	2023-02-28
211	12	572	8735.26	2023-01-23
212	9	674	17733.44	2022-04-11
213	12	234	11647.01	2021-10-30
214	15	899	11590.04	2022-12-22
215	13	462	12908.59	2020-06-27
216	20	138	4681.26	2023-12-03
217	7	25	6795.74	2023-02-02
218	23	744	8091.86	2020-09-29
219	4	316	16955.04	2022-12-23
220	22	176	5598.84	2020-01-28
221	17	321	8566.53	2020-08-25
222	8	297	7468.80	2023-12-26
223	8	636	7935.60	2022-04-26
224	11	609	15134.96	2022-07-29
225	12	90	11647.01	2023-09-12
226	6	6	12516.86	2022-02-05
227	6	273	13351.31	2021-03-17
228	7	179	5996.24	2021-05-15
229	16	510	11332.61	2020-05-10
230	3	102	13350.56	2022-03-23
231	23	606	7642.32	2023-04-17
232	18	776	18507.38	2023-01-12
233	17	583	7138.78	2022-07-14
234	11	869	12864.72	2023-01-27
235	12	973	9317.61	2023-09-18
236	10	612	15574.47	2023-05-09
237	2	877	7663.32	2023-07-17
238	18	23	13880.54	2020-03-06
239	10	828	15574.47	2021-04-04
240	12	103	9899.96	2023-09-15
241	6	595	14185.77	2022-07-18
242	12	340	9899.96	2021-08-01
243	10	526	14658.32	2023-06-03
244	6	123	12516.86	2020-09-28
245	3	487	12015.50	2023-03-09
246	18	677	15731.27	2022-12-05
247	6	300	12516.86	2020-03-04
248	2	565	6513.82	2021-03-18
249	12	623	10482.31	2020-06-25
250	7	950	7994.99	2023-03-13
251	17	278	7614.70	2023-03-11
252	3	490	10680.45	2020-06-26
253	7	877	7994.99	2022-03-07
254	10	61	13742.18	2020-12-04
255	22	753	4665.70	2023-11-22
256	7	817	6795.74	2022-01-28
257	15	105	11590.04	2021-05-04
258	18	271	15731.27	2020-08-05
259	14	911	14089.10	2019-12-14
260	20	207	4388.68	2022-12-12
261	9	527	16748.25	2023-01-13
262	13	432	15490.31	2021-01-06
263	10	941	18322.90	2020-04-23
264	22	516	5287.79	2021-03-28
265	19	911	11204.13	2023-08-30
266	23	89	6743.22	2023-07-05
267	23	120	7192.77	2020-09-08
268	17	771	7138.78	2020-08-12
269	18	264	16656.64	2023-01-29
270	23	5	6743.22	2019-11-21
271	7	962	7994.99	2019-12-23
272	4	432	17952.40	2019-12-02
273	10	330	13742.18	2022-03-23
274	1	804	12169.56	2022-05-07
275	12	335	8735.26	2022-09-11
276	23	593	8091.86	2023-03-31
277	23	902	8091.86	2021-08-06
278	12	35	9317.61	2023-03-31
279	21	723	18496.67	2023-04-19
280	16	942	13332.48	2023-01-23
281	15	255	10302.26	2020-05-13
282	11	800	13621.46	2023-05-23
283	11	816	15134.96	2023-07-20
284	2	519	6130.66	2021-05-30
285	7	32	5996.24	2023-08-25
286	9	872	15763.06	2023-12-17
287	13	182	14629.73	2021-03-30
288	1	677	13792.17	2022-03-20
289	10	797	13742.18	2023-04-08
290	8	613	7468.80	2022-08-10
291	16	28	13332.48	2022-07-06
292	8	383	7468.80	2023-03-29
293	11	921	12864.72	2022-03-19
294	16	866	11999.23	2023-03-03
295	8	395	7935.60	2022-11-01
296	4	787	15957.69	2020-04-21
297	13	118	15490.31	2021-10-04
298	20	911	4681.26	2023-06-21
299	16	829	13332.48	2023-05-04
300	18	323	13880.54	2021-05-03
301	8	578	8402.40	2021-03-25
302	2	217	6130.66	2023-09-02
303	16	531	9999.36	2020-10-16
304	22	815	6220.93	2023-04-27
305	9	749	15763.06	2020-09-16
306	9	286	16748.25	2022-11-27
307	18	584	13880.54	2023-03-21
308	12	1000	11647.01	2023-01-07
309	4	392	17952.40	2023-08-08
310	6	925	12516.86	2022-04-13
311	14	216	17611.37	2020-06-04
312	23	361	7642.32	2022-02-18
313	12	502	8735.26	2021-05-16
314	20	365	4973.83	2022-11-23
315	8	290	7935.60	2020-10-19
316	11	36	12864.72	2023-07-27
317	4	7	17952.40	2023-07-30
318	14	981	13208.53	2023-10-16
319	9	734	16748.25	2023-08-10
320	8	359	7002.00	2020-07-06
321	2	216	7663.32	2023-09-27
322	8	926	7468.80	2023-07-23
323	11	104	13621.46	2023-09-25
324	12	744	10482.31	2022-04-21
325	2	982	5747.49	2023-08-28
326	23	406	8091.86	2023-07-04
327	19	556	10503.87	2021-08-06
328	4	29	19947.11	2021-11-09
329	5	89	7352.42	2023-03-06
330	16	496	10665.98	2020-08-22
331	20	11	5851.57	2022-06-19
332	17	99	7614.70	2023-04-18
333	21	903	15722.17	2022-09-17
334	23	935	7192.77	2023-06-13
335	17	713	7614.70	2021-01-23
336	17	112	7614.70	2021-02-22
337	13	266	15490.31	2022-12-23
338	11	955	11351.22	2023-06-12
339	7	398	6795.74	2020-08-21
340	3	53	10680.45	2023-06-30
341	21	293	18496.67	2020-01-03
342	13	394	17211.45	2022-07-22
343	14	631	14969.66	2023-03-02
344	13	432	15490.31	2021-05-10
345	2	229	6513.82	2023-10-16
346	19	337	14005.16	2023-09-03
347	4	550	17952.40	2022-12-31
348	23	715	8091.86	2023-07-09
349	6	148	12516.86	2020-10-23
350	22	911	4976.74	2021-09-27
351	23	895	8990.96	2022-10-11
352	14	661	13208.53	2020-04-13
353	8	457	9336.00	2021-03-18
354	17	299	7138.78	2020-01-12
355	13	804	12908.59	2021-10-06
356	14	558	14969.66	2022-01-03
357	4	556	14960.33	2022-05-14
358	21	637	13872.50	2022-01-15
359	21	818	15722.17	2022-02-19
360	5	452	8332.75	2022-12-13
361	8	73	7935.60	2023-03-10
362	7	33	5996.24	2023-09-26
363	10	465	15574.47	2022-11-03
364	1	863	13792.17	2020-04-19
365	20	811	4681.26	2021-03-12
366	13	121	15490.31	2023-09-14
367	2	194	6130.66	2022-07-06
368	1	527	13792.17	2023-09-25
369	20	361	4973.83	2020-04-21
370	9	641	19703.82	2022-08-02
371	17	238	7138.78	2020-02-03
372	17	916	8566.53	2020-06-28
373	15	432	11590.04	2023-07-06
374	7	44	7195.49	2022-09-17
375	17	971	9518.37	2023-11-19
376	22	691	6220.93	2021-09-23
377	7	688	7195.49	2021-10-31
378	10	750	15574.47	2023-08-06
379	6	796	14185.77	2023-09-13
380	17	615	8090.61	2021-05-05
381	7	744	7195.49	2020-11-22
382	16	581	11999.23	2021-04-07
383	2	734	6513.82	2020-06-18
384	8	517	7935.60	2023-05-25
385	16	420	13332.48	2021-01-13
386	2	421	5747.49	2023-04-10
387	10	260	14658.32	2023-05-02
388	14	182	14969.66	2023-10-07
389	1	25	13792.17	2020-12-03
390	23	782	7642.32	2020-12-22
391	18	961	13880.54	2022-03-27
392	2	866	6896.99	2023-05-13
393	1	864	12169.56	2022-11-26
394	1	325	14603.47	2023-10-04
395	2	126	6130.66	2022-08-14
396	22	952	5598.84	2022-12-23
397	9	709	15763.06	2021-02-04
398	2	238	5747.49	2022-11-29
399	21	284	14797.34	2020-12-20
400	19	703	10503.87	2020-12-26
401	19	909	14005.16	2023-02-20
402	7	554	6395.99	2022-02-15
403	19	826	10503.87	2023-07-23
404	14	971	17611.37	2021-04-05
405	17	992	7614.70	2021-07-17
406	15	20	12877.82	2023-12-04
407	2	390	6896.99	2023-12-25
408	7	787	6395.99	2022-05-21
409	1	691	16226.08	2022-03-16
410	23	416	8990.96	2020-06-15
411	20	217	4681.26	2023-05-27
412	12	992	9317.61	2022-09-23
413	13	612	14629.73	2023-06-30
414	3	348	12015.50	2020-05-09
415	21	297	14797.34	2021-05-02
416	14	806	15850.23	2023-09-02
417	13	270	15490.31	2020-06-15
418	2	389	6513.82	2021-02-21
419	1	231	12169.56	2023-08-03
420	14	156	17611.37	2022-05-25
421	2	135	6513.82	2021-07-02
422	23	999	7642.32	2023-05-16
423	23	668	7642.32	2020-03-26
424	7	170	7195.49	2022-07-02
425	15	72	12877.82	2020-06-28
426	16	10	9999.36	2023-02-04
427	11	342	15134.96	2023-03-29
428	13	936	12908.59	2023-07-25
429	17	580	8566.53	2022-03-31
430	7	811	6395.99	2020-04-20
431	8	930	9336.00	2022-07-06
432	14	857	13208.53	2023-09-25
433	19	263	14005.16	2020-05-05
434	10	207	13742.18	2022-08-09
435	17	956	8566.53	2022-03-19
436	18	81	16656.64	2020-01-06
437	14	643	14089.10	2023-12-01
438	15	106	10302.26	2020-04-19
439	8	513	7002.00	2020-12-21
440	12	794	10482.31	2021-10-15
441	2	128	6896.99	2023-07-13
442	14	205	14089.10	2020-03-12
443	22	267	6220.93	2020-11-29
444	12	354	11647.01	2023-07-29
445	17	594	7138.78	2019-12-22
446	12	699	10482.31	2023-03-19
447	23	366	6743.22	2022-03-09
448	8	404	9336.00	2019-11-09
449	16	162	13332.48	2021-04-18
450	17	767	7614.70	2021-03-30
451	20	485	4681.26	2023-03-20
452	19	709	11204.13	2021-01-31
453	23	390	8091.86	2023-08-23
454	11	592	12864.72	2022-08-11
455	2	714	5747.49	2022-08-12
456	10	895	18322.90	2023-01-04
457	10	874	16490.61	2022-01-17
458	14	676	17611.37	2023-01-31
459	21	558	15722.17	2021-05-07
460	1	130	12169.56	2023-04-29
461	22	15	5598.84	2023-02-08
462	19	68	11904.39	2023-07-17
463	20	732	5851.57	2021-09-02
464	17	795	8090.61	2023-10-07
465	8	465	7935.60	2020-08-13
466	2	88	6513.82	2022-04-27
467	2	237	7663.32	2023-04-12
468	9	261	17733.44	2022-04-03
469	23	561	7642.32	2023-07-29
470	1	80	12169.56	2023-02-07
471	22	845	6220.93	2023-04-09
472	1	542	14603.47	2021-12-23
473	15	174	12877.82	2020-10-02
474	9	128	17733.44	2023-06-27
475	3	181	11347.98	2023-06-21
476	23	114	8091.86	2023-06-04
477	7	28	7994.99	2021-03-07
478	16	720	11999.23	2021-03-14
479	9	864	14777.87	2022-06-23
480	12	176	10482.31	2020-02-15
481	8	228	8402.40	2021-02-05
482	4	864	14960.33	2020-04-02
483	13	526	13769.16	2020-09-01
484	2	872	6130.66	2020-10-06
485	14	38	14969.66	2021-06-17
486	5	750	8332.75	2023-02-05
487	13	826	12908.59	2022-06-22
488	13	277	13769.16	2023-10-07
489	18	314	16656.64	2021-11-21
490	23	92	8990.96	2022-09-03
491	7	975	5996.24	2022-10-28
492	10	351	15574.47	2023-11-03
493	20	917	4388.68	2023-09-16
494	18	580	16656.64	2020-05-23
495	14	563	13208.53	2020-04-28
496	10	157	16490.61	2020-12-30
497	13	593	15490.31	2021-04-28
498	19	738	11204.13	2023-01-30
499	7	212	7195.49	2021-12-06
500	1	707	12980.86	2020-05-19
501	6	260	13351.31	2020-02-22
502	18	200	14805.90	2020-08-17
503	19	120	11204.13	2023-10-07
504	17	957	9518.37	2023-06-26
505	19	36	11904.39	2023-05-31
506	4	559	14960.33	2020-09-29
507	6	759	16689.14	2023-10-23
508	12	960	8735.26	2021-11-02
509	22	184	5598.84	2021-01-03
510	21	214	18496.67	2021-06-09
511	22	88	5287.79	2023-07-25
512	9	692	15763.06	2023-10-30
513	17	990	7138.78	2022-08-03
514	12	757	10482.31	2020-11-30
515	10	504	15574.47	2019-12-29
516	18	618	14805.90	2023-04-23
517	12	791	9317.61	2023-10-05
518	6	781	12516.86	2022-01-09
519	2	74	5747.49	2022-06-16
520	2	449	6513.82	2023-07-01
521	21	582	13872.50	2022-02-08
522	13	986	15490.31	2023-04-10
523	4	979	14960.33	2022-02-03
524	2	552	6896.99	2023-02-04
525	18	271	15731.27	2021-12-14
526	10	357	15574.47	2020-11-28
527	16	135	11332.61	2023-12-21
528	10	405	15574.47	2021-10-12
529	22	605	5598.84	2021-10-20
530	13	356	17211.45	2023-03-21
531	22	763	5598.84	2021-03-23
532	17	587	7614.70	2021-02-09
533	12	704	11647.01	2020-04-20
534	13	464	13769.16	2022-05-30
535	17	384	7614.70	2021-03-10
536	22	166	4976.74	2023-09-28
537	9	532	19703.82	2020-11-19
538	21	32	13872.50	2021-03-06
539	18	551	15731.27	2021-12-16
540	22	769	5598.84	2022-10-05
541	9	821	16748.25	2023-02-03
542	7	960	5996.24	2023-03-13
543	5	469	9803.23	2021-04-23
544	12	445	9317.61	2022-05-20
545	6	135	14185.77	2022-04-25
546	20	199	5851.57	2023-06-16
547	12	185	8735.26	2022-12-11
548	4	708	19947.11	2022-08-30
549	19	453	10503.87	2023-09-05
550	9	178	14777.87	2020-04-11
551	15	11	12877.82	2023-10-09
552	7	455	7195.49	2023-08-08
553	22	27	4976.74	2020-06-05
554	11	301	11351.22	2020-02-06
555	23	672	6743.22	2022-06-13
556	22	266	5598.84	2021-04-28
557	14	938	15850.23	2023-11-02
558	1	283	16226.08	2020-08-19
559	11	203	12864.72	2021-05-15
560	2	421	5747.49	2020-02-18
561	3	617	10012.92	2023-04-14
562	19	714	10503.87	2022-09-06
563	8	222	8402.40	2021-09-22
564	5	557	7842.58	2022-07-28
565	8	692	7468.80	2020-08-27
566	2	455	6896.99	2023-05-18
567	17	811	7614.70	2023-11-01
568	18	866	16656.64	2020-09-29
569	3	478	12015.50	2020-03-25
570	5	86	8822.91	2022-08-13
571	13	307	14629.73	2021-06-19
572	23	106	7192.77	2022-12-08
573	18	421	13880.54	2023-09-08
574	22	686	4976.74	2022-03-21
575	15	982	9658.37	2021-01-01
576	3	213	11347.98	2023-07-30
577	20	311	4973.83	2021-04-07
578	6	423	12516.86	2019-12-17
579	11	153	11351.22	2023-02-11
580	9	449	16748.25	2022-05-13
581	13	646	17211.45	2021-08-05
582	12	483	10482.31	2023-03-18
583	8	238	7002.00	2023-02-19
584	21	162	18496.67	2020-03-03
585	21	542	16647.00	2023-02-18
586	21	958	13872.50	2021-12-15
587	6	618	13351.31	2021-09-25
588	20	762	5266.41	2020-12-07
589	23	208	8091.86	2023-03-19
590	21	388	18496.67	2023-02-01
591	3	893	11347.98	2023-03-30
592	1	954	12169.56	2020-09-08
593	16	833	11332.61	2020-11-12
594	2	749	6130.66	2022-04-15
595	12	957	11647.01	2022-01-11
596	23	113	6743.22	2021-10-02
597	11	889	12107.97	2022-11-25
598	6	508	12516.86	2023-08-07
599	5	811	7842.58	2023-06-21
600	3	35	10680.45	2020-11-07
601	7	748	6395.99	2023-10-23
602	17	858	7614.70	2020-03-20
603	15	335	9658.37	2020-05-28
604	23	882	6743.22	2023-05-05
605	16	805	11332.61	2020-12-01
606	17	208	8566.53	2020-05-01
607	14	899	15850.23	2022-03-29
608	13	448	15490.31	2021-08-05
609	13	559	12908.59	2023-07-22
610	21	740	14797.34	2023-08-05
611	4	16	15957.69	2023-05-26
612	12	218	9899.96	2023-08-25
613	21	7	16647.00	2020-12-12
614	3	619	10012.92	2021-10-11
615	11	127	12864.72	2020-03-20
616	23	235	8990.96	2020-11-29
617	21	150	15722.17	2021-03-03
618	14	828	14969.66	2023-10-30
619	20	814	4681.26	2022-12-29
620	18	995	13880.54	2020-11-19
621	15	177	12877.82	2023-09-17
622	8	547	7002.00	2021-05-01
623	12	843	11647.01	2022-12-05
624	9	360	19703.82	2022-06-17
625	21	518	14797.34	2020-10-10
626	13	826	12908.59	2023-10-25
627	10	340	15574.47	2020-12-03
628	14	728	14089.10	2021-06-27
629	23	35	7192.77	2022-02-01
630	16	409	11332.61	2020-05-09
631	9	85	19703.82	2023-02-16
632	4	56	16955.04	2020-05-15
633	21	693	16647.00	2019-12-20
634	11	507	15134.96	2020-01-13
635	21	369	18496.67	2020-04-19
636	5	715	8822.91	2022-05-19
637	14	785	17611.37	2022-01-04
638	14	227	14089.10	2022-12-29
639	23	587	7192.77	2022-11-28
640	4	891	17952.40	2020-04-15
641	9	514	15763.06	2020-08-22
642	10	86	16490.61	2023-08-07
643	11	873	13621.46	2021-09-22
644	18	223	14805.90	2023-05-04
645	14	370	15850.23	2020-09-13
646	12	917	8735.26	2021-02-25
647	14	227	14089.10	2022-12-25
648	19	611	12604.64	2022-07-06
649	18	99	14805.90	2020-03-31
650	8	435	8402.40	2023-03-31
651	17	857	7138.78	2023-06-12
652	12	19	8735.26	2023-05-10
653	18	35	14805.90	2020-03-20
654	23	799	8091.86	2019-11-18
655	22	47	5287.79	2022-07-16
656	6	310	14185.77	2023-01-12
657	12	95	8735.26	2022-08-14
658	1	999	13792.17	2021-12-08
659	4	361	16955.04	2022-12-22
660	23	781	6743.22	2020-01-07
661	23	653	8990.96	2022-02-16
662	10	954	13742.18	2019-11-29
663	1	216	16226.08	2021-02-03
664	2	305	6513.82	2022-02-13
665	10	161	13742.18	2023-02-11
666	13	618	13769.16	2023-03-07
667	8	850	7002.00	2023-12-10
668	19	727	14005.16	2021-05-08
669	16	717	13332.48	2021-03-25
670	9	489	19703.82	2023-07-08
671	23	718	6743.22	2022-04-21
672	15	910	9658.37	2019-11-28
673	6	52	13351.31	2022-03-07
674	3	863	11347.98	2020-11-10
675	9	604	14777.87	2021-10-14
676	10	701	18322.90	2020-02-15
677	18	272	18507.38	2021-05-07
678	22	176	5598.84	2020-12-17
679	23	508	6743.22	2020-10-22
680	17	305	8090.61	2022-02-02
681	1	795	13792.17	2020-07-26
682	18	264	16656.64	2023-03-04
683	13	807	17211.45	2023-06-19
684	14	712	17611.37	2022-03-10
685	8	966	7935.60	2023-09-11
686	14	934	17611.37	2023-05-03
687	1	903	13792.17	2021-08-23
688	13	47	14629.73	2022-03-22
689	2	509	6130.66	2023-06-18
690	9	209	14777.87	2023-03-04
691	3	813	12015.50	2022-11-10
692	15	623	11590.04	2023-07-13
693	15	475	10302.26	2023-10-08
694	14	23	13208.53	2023-03-21
695	17	889	7614.70	2019-12-21
696	20	956	5266.41	2021-12-19
697	12	448	10482.31	2023-06-29
698	5	764	7842.58	2020-04-28
699	12	425	10482.31	2021-09-17
700	23	609	8990.96	2023-09-03
701	3	927	10012.92	2021-07-23
702	10	743	16490.61	2020-09-01
703	19	923	14005.16	2020-09-04
704	2	558	6513.82	2020-03-05
705	13	287	13769.16	2021-09-01
706	17	318	8090.61	2022-09-30
707	13	761	17211.45	2021-01-29
708	2	329	5747.49	2021-07-28
709	13	496	13769.16	2022-03-13
710	3	969	10680.45	2023-03-02
711	20	935	4681.26	2023-08-12
712	18	749	14805.90	2023-05-19
713	23	649	8091.86	2021-11-27
714	13	345	13769.16	2023-03-05
715	18	746	16656.64	2023-11-28
716	2	789	7663.32	2023-04-18
717	12	1	11647.01	2020-05-28
718	1	442	12980.86	2023-07-12
719	6	427	14185.77	2022-02-06
720	9	479	17733.44	2021-07-08
721	21	182	15722.17	2020-04-23
722	17	175	9518.37	2022-02-23
723	14	372	14969.66	2022-09-17
724	12	569	10482.31	2022-05-08
725	5	511	8332.75	2022-05-18
726	11	230	12107.97	2020-05-11
727	2	648	6130.66	2022-02-13
728	17	591	8090.61	2022-02-03
729	7	552	7195.49	2022-02-28
730	16	61	9999.36	2023-03-15
731	22	231	4665.70	2020-07-09
732	12	992	9317.61	2023-09-04
733	4	582	14960.33	2020-06-06
734	1	381	16226.08	2022-08-13
735	22	114	5598.84	2020-05-14
736	16	623	11999.23	2023-09-27
737	4	402	17952.40	2023-08-08
738	18	974	15731.27	2023-07-08
739	23	372	7642.32	2021-06-30
740	3	548	11347.98	2023-04-05
741	11	260	12107.97	2020-06-02
742	21	31	18496.67	2021-11-07
743	19	961	10503.87	2023-09-11
744	6	412	15020.23	2021-11-25
745	2	822	6896.99	2021-12-22
746	3	256	10012.92	2020-08-05
747	12	523	10482.31	2023-08-31
748	19	414	14005.16	2022-02-09
749	23	505	8091.86	2020-11-10
750	12	594	8735.26	2023-12-27
751	16	740	10665.98	2023-01-10
752	22	794	5598.84	2022-03-08
753	15	407	9658.37	2023-06-06
754	23	152	7192.77	2023-09-12
755	10	403	16490.61	2023-06-09
756	11	371	13621.46	2023-09-20
757	16	750	11332.61	2019-11-10
758	22	415	4665.70	2021-08-04
759	16	589	11332.61	2021-11-06
760	15	475	10302.26	2023-07-06
761	1	78	12169.56	2021-12-31
762	10	836	18322.90	2023-05-09
763	22	430	4665.70	2021-09-09
764	23	950	8990.96	2019-12-19
765	14	260	14089.10	2023-10-20
766	22	344	5287.79	2021-06-29
767	2	784	5747.49	2021-04-23
768	8	861	7002.00	2021-02-18
769	18	581	16656.64	2023-10-11
770	10	833	15574.47	2020-03-31
771	16	955	9999.36	2020-02-09
772	8	658	7468.80	2020-12-28
773	20	289	5266.41	2019-11-21
774	1	14	12980.86	2023-10-14
775	16	95	9999.36	2023-06-28
776	6	365	14185.77	2021-12-15
777	3	129	10680.45	2021-02-03
778	19	346	12604.64	2023-10-28
779	17	482	7138.78	2023-04-26
780	23	403	8091.86	2023-03-29
781	14	363	13208.53	2023-07-01
782	15	428	11590.04	2023-04-17
783	20	112	4681.26	2021-09-03
784	7	635	6395.99	2023-02-17
785	16	823	10665.98	2019-11-29
786	11	797	11351.22	2023-04-14
787	3	853	10680.45	2021-05-11
788	20	13	5851.57	2020-12-25
789	18	642	15731.27	2023-03-03
790	23	893	7642.32	2020-06-25
791	21	908	16647.00	2023-08-26
792	22	526	4976.74	2022-06-12
793	19	787	11204.13	2021-12-12
794	20	701	5851.57	2022-07-20
795	8	362	9336.00	2022-01-04
796	15	991	10302.26	2022-06-08
797	9	92	19703.82	2022-05-30
798	4	523	17952.40	2020-06-25
799	11	625	15134.96	2020-07-02
800	1	634	16226.08	2020-03-30
801	9	891	17733.44	2023-12-23
802	2	172	6513.82	2020-03-30
803	19	19	10503.87	2019-12-21
804	4	232	15957.69	2020-04-05
805	7	475	6395.99	2019-11-10
806	20	314	5266.41	2021-11-14
807	21	829	18496.67	2023-08-17
808	23	685	6743.22	2022-06-23
809	22	477	6220.93	2023-08-19
810	12	534	10482.31	2023-05-07
811	12	703	8735.26	2023-01-12
812	21	125	15722.17	2022-02-13
813	23	982	6743.22	2022-08-12
814	4	395	16955.04	2023-10-22
815	17	782	8090.61	2023-03-23
816	17	981	7138.78	2023-12-23
817	15	549	10946.15	2020-07-13
818	11	80	11351.22	2023-09-16
819	15	939	10946.15	2020-12-18
820	7	936	5996.24	2023-05-28
821	6	708	16689.14	2021-10-07
822	1	951	13792.17	2023-03-11
823	1	407	12169.56	2023-09-18
824	13	718	12908.59	2022-05-27
825	3	56	11347.98	2020-08-08
826	13	454	15490.31	2021-11-11
827	1	500	12980.86	2023-03-07
828	3	71	12015.50	2023-03-19
829	23	956	8091.86	2021-09-29
830	13	487	15490.31	2021-07-21
831	5	195	7352.42	2021-06-02
832	21	787	14797.34	2022-02-05
833	19	866	12604.64	2023-12-25
834	10	931	16490.61	2022-12-02
835	21	745	15722.17	2023-08-17
836	12	415	8735.26	2023-07-19
837	21	455	16647.00	2020-10-18
838	3	589	11347.98	2022-04-30
839	11	485	12107.97	2023-08-26
840	3	886	10012.92	2023-04-21
841	23	711	7642.32	2021-09-04
842	23	375	7642.32	2023-04-26
843	14	707	14089.10	2020-09-09
844	8	30	9336.00	2023-01-03
845	17	281	7138.78	2019-12-26
846	5	34	9803.23	2022-04-07
847	11	55	15134.96	2020-04-29
848	10	493	16490.61	2022-04-25
849	23	207	6743.22	2021-10-27
850	21	117	13872.50	2023-04-29
851	4	157	17952.40	2021-09-03
852	2	596	6896.99	2023-01-18
853	23	445	7192.77	2022-01-29
854	4	59	16955.04	2023-02-17
855	12	552	10482.31	2023-12-27
856	11	551	12864.72	2022-06-23
857	17	259	7614.70	2019-12-26
858	1	941	16226.08	2020-05-04
859	15	469	12877.82	2022-01-26
860	17	853	7614.70	2023-11-03
861	18	607	14805.90	2022-06-26
862	10	666	18322.90	2020-04-06
863	17	971	9518.37	2023-01-23
864	16	410	13332.48	2020-09-25
865	2	445	6130.66	2022-11-03
866	6	88	14185.77	2020-01-09
867	2	346	6896.99	2020-08-05
868	1	591	13792.17	2022-02-25
869	11	703	11351.22	2022-02-05
870	22	29	6220.93	2023-04-20
871	23	40	8091.86	2020-05-13
872	22	909	6220.93	2023-04-09
873	12	484	11647.01	2020-06-05
874	1	372	13792.17	2023-03-03
875	21	126	14797.34	2023-01-27
876	10	770	16490.61	2022-10-18
877	9	437	17733.44	2023-08-17
878	6	780	14185.77	2022-06-09
879	11	934	15134.96	2023-02-08
880	10	215	16490.61	2023-08-21
881	21	542	16647.00	2022-12-11
882	9	520	17733.44	2022-03-15
883	1	533	13792.17	2021-11-05
884	4	774	15957.69	2023-11-30
885	9	808	19703.82	2022-06-30
886	20	758	5266.41	2021-01-10
887	9	940	15763.06	2023-11-30
888	2	355	7663.32	2020-07-10
889	21	448	16647.00	2023-06-10
890	5	495	7352.42	2021-07-17
891	5	420	9803.23	2022-10-25
892	8	341	7002.00	2022-01-09
893	21	531	13872.50	2020-09-21
894	15	376	10302.26	2021-05-05
895	19	553	10503.87	2020-03-05
896	15	68	10946.15	2022-08-12
897	21	990	13872.50	2023-06-07
898	12	876	10482.31	2023-02-26
899	7	776	7994.99	2022-07-02
900	11	211	11351.22	2022-10-15
901	23	87	6743.22	2022-02-12
902	6	330	12516.86	2023-06-19
903	3	817	11347.98	2023-04-08
904	12	361	9899.96	2023-04-03
905	3	651	12015.50	2021-02-25
906	6	37	13351.31	2023-06-02
907	9	705	14777.87	2021-08-06
908	23	279	6743.22	2023-03-29
909	14	674	15850.23	2022-06-30
910	12	607	9317.61	2023-05-06
911	1	519	12980.86	2022-11-01
912	12	893	9899.96	2023-10-09
913	9	652	16748.25	2023-09-26
914	20	145	4681.26	2023-08-13
915	3	713	10680.45	2023-07-17
916	6	331	12516.86	2023-02-04
917	23	238	6743.22	2023-04-02
918	20	495	4388.68	2021-12-05
919	14	999	14969.66	2022-11-03
920	8	356	9336.00	2022-12-10
921	19	118	12604.64	2020-11-09
922	14	851	15850.23	2022-10-23
923	2	392	6896.99	2023-12-09
924	11	234	15134.96	2020-05-04
925	13	848	15490.31	2019-12-25
926	5	710	8822.91	2020-09-16
927	3	318	11347.98	2020-12-29
928	9	127	16748.25	2022-03-09
929	11	150	12864.72	2021-12-11
930	3	496	10680.45	2023-04-07
931	10	894	16490.61	2022-05-10
932	9	973	15763.06	2023-12-19
933	10	160	13742.18	2019-11-17
934	6	343	12516.86	2020-02-01
935	22	236	6220.93	2020-11-01
936	8	844	7468.80	2022-03-01
937	2	553	5747.49	2023-09-09
938	18	34	18507.38	2020-01-04
939	10	238	13742.18	2023-06-21
940	9	917	14777.87	2022-08-18
941	22	471	4665.70	2023-02-19
942	2	744	6896.99	2020-07-17
943	16	120	10665.98	2023-09-10
944	13	771	12908.59	2023-02-03
945	13	618	13769.16	2021-01-20
946	6	574	14185.77	2020-07-22
947	16	975	9999.36	2022-01-09
948	7	445	6395.99	2021-02-18
949	23	408	6743.22	2022-11-17
950	20	578	5266.41	2020-07-18
951	9	719	19703.82	2020-10-27
952	6	420	16689.14	2020-10-03
953	16	716	11332.61	2023-06-06
954	22	984	4976.74	2020-11-22
955	6	205	13351.31	2020-02-06
956	18	332	13880.54	2021-07-22
957	14	928	13208.53	2021-10-10
958	8	749	7468.80	2023-02-10
959	9	108	17733.44	2021-05-30
960	11	222	13621.46	2021-12-01
961	14	236	17611.37	2022-07-25
962	8	676	9336.00	2023-02-07
963	12	228	10482.31	2022-02-21
964	7	205	6395.99	2022-11-20
965	6	651	15020.23	2023-01-05
966	22	456	4665.70	2022-04-04
967	21	492	14797.34	2021-02-15
968	13	731	13769.16	2021-11-05
969	2	988	6130.66	2022-03-10
970	9	606	16748.25	2023-06-28
971	17	945	7138.78	2023-04-21
972	13	134	12908.59	2020-07-04
973	12	135	9899.96	2022-02-17
974	14	558	14969.66	2023-08-23
975	11	414	15134.96	2023-05-15
976	23	633	7192.77	2023-10-12
977	15	85	12877.82	2020-06-03
978	9	806	17733.44	2023-06-06
979	19	239	11204.13	2023-08-14
980	8	294	7002.00	2021-07-23
981	17	93	7138.78	2023-02-05
982	23	5	6743.22	2020-09-05
983	17	276	7614.70	2022-05-19
984	4	53	15957.69	2023-06-21
985	7	186	5996.24	2021-01-28
986	8	311	7935.60	2022-12-19
987	15	945	9658.37	2020-07-23
988	11	640	12864.72	2023-11-02
989	8	253	7002.00	2019-11-25
990	1	923	16226.08	2021-07-15
991	4	677	16955.04	2023-10-09
992	21	179	13872.50	2020-04-11
993	23	332	6743.22	2023-10-31
994	13	687	12908.59	2020-01-05
995	18	98	16656.64	2021-04-21
996	4	180	14960.33	2019-11-20
997	7	204	5996.24	2023-02-06
998	14	449	14969.66	2023-05-21
999	10	191	16490.61	2022-08-10
1000	4	345	15957.69	2023-05-05
1001	4	251	19947.11	2024-11-26
1002	10	681	15574.47	2024-11-26
1003	14	285	17611.37	2024-11-26
1004	1	887	14603.47	2024-11-26
1005	2	664	6513.82	2024-11-26
1006	11	601	15134.96	2024-11-26
1007	8	647	9336.00	2024-11-26
1008	9	497	17733.44	2024-11-26
1009	3	630	10680.45	2024-11-26
1010	2	665	6896.99	2024-11-26
1011	12	577	9899.96	2024-11-26
\.


--
-- Data for Name: tipo_visitantes; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.tipo_visitantes (id, nombre, descuento) FROM stdin;
1	Adulto	0.00
2	Menor de edad	10.00
3	Estudiante	20.00
4	Adulto mayor	15.00
5	Persona con discapacidad	25.00
\.


--
-- Data for Name: ubicacion; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.ubicacion (id, nombre) FROM stdin;
1	Zona Tropical
2	Zona Desertica
3	Zona de Montaña
4	Aviario
5	Acuario
6	Zona de Reptiles
7	Sabana Africana
8	Bosque Lluvioso
9	Zona de Mamiferos
10	Area de Exhibicion
11	Centro de Conservacion
12	Zona de Aves
13	Pradera
14	Habitat Artico
15	Habitat Nocturno
16	Zona de Insectos
17	Jardin Botanico
18	Playa Artificial
19	Recinto de Grandes Felinos
20	Zona de Alimentacion
\.


--
-- Data for Name: visitantes; Type: TABLE DATA; Schema: animals; Owner: adminzoo
--

COPY animals.visitantes (id, nombre, idtipovisitante) FROM stdin;
1	Priscila Botella Batalla	1
2	Encarnación Alicia Pont Amorós	3
3	Gertrudis Reina	5
4	Serafina Gargallo Urrutia	4
5	Alejandro Bayona Fabra	5
6	Edelmira del Grau	5
7	Azeneth Lillo Ledesma	2
8	Anastasia Viana Pintor	1
9	Augusto Codina Manzanares	3
10	Victoria Fernández Fuentes	5
11	Cintia Chelo Lastra Roselló	1
12	Pili de Jaume	1
13	María Manuela Rosalva Chacón Torrecilla	1
14	Angelita Terrón Ramirez	3
15	Ale Saez Girona	2
16	Luz Soledad Guillen Ramirez	3
17	Jonatan de Viana	1
18	Odalys Plana	3
19	Lucila Torrijos Blanch	5
20	Vanesa Hoz Carrasco	1
21	Belen Martí Carbó	5
22	Manu de Muñoz	3
23	Zacarías Bautista Vicens	5
24	Luciana Solana Maldonado	5
25	Felisa Garcés Aller	4
26	Florinda Villalobos	2
27	Eva Roman-Sastre	3
28	Heliodoro Tomás-Bernad	1
29	Pascuala del Fernandez	1
30	Carmelo Pavón Torrecilla	1
31	Raquel Sanz Iriarte	1
32	Ismael Mosquera Ortiz	5
33	Gastón de Cañas	5
34	Inmaculada Duarte Fernandez	1
35	Eufemia Jover-Olivares	3
36	Ulises Plaza Abellán	4
37	Rubén Busquets Arribas	3
38	Josué de Sevilla	4
39	África Pablo Royo	2
40	Eugenia Gras Bauzà	2
41	Abel Frutos Nieto	4
42	Bernardita Cuevas Casal	2
43	Olimpia Vazquez	5
44	Guadalupe Ramos Poza	2
45	Emperatriz Pinto-Campoy	3
46	Felicidad del Castellanos	3
47	Glauco Victoriano Rivas Zabaleta	4
48	Dorita Neira Alegria	2
49	Manolo Javi Ricart Guitart	3
50	Reinaldo Hoyos Puig	5
51	Lorenzo Ávila-Taboada	4
52	Eliseo Mendoza	3
53	José del Gutierrez	3
54	Encarna Esperanza Téllez Marti	5
55	Felicidad Casals Abascal	1
56	Rosenda Busquets Bueno	4
57	Martirio Tovar Arellano	1
58	Adoración Perales Buendía	1
59	Clemente Flavio Sierra Puig	4
60	Gervasio Casanovas-Tejera	1
61	Renato Martin Folch Girón	5
62	Claudio Navarrete Jove	5
63	Jordi del Ruiz	4
64	Jose Miguel Checa Benet	1
65	Dolores Figueras-Olmo	4
66	Hernán Bolaños Vallejo	1
67	Cruz Isern Cánovas	4
68	Asdrubal Guerrero Luís	4
69	Lisandro Cabrera Recio	5
70	Rocío Eufemia Calvet Batalla	1
71	Vinicio Daza Almazán	2
72	Constanza Catalina Romeu Roca	1
73	Isa Torrens Blanch	4
74	Teodoro Carmona Sanjuan	5
75	Jeremías Samuel Morcillo Gutiérrez	3
76	Jordán Aguiló Rueda	2
77	Danilo Aller Valderrama	1
78	Felicia Vargas Segura	5
79	Dan Arnau-Muñoz	4
80	Ismael Miró Cerdán	5
81	Jenny Berrocal Casas	2
82	Teófilo Romeu Lorenzo	2
83	Eulalia del Armengol	4
84	Rodolfo Pepe Llobet Aguiló	4
85	Nico Clemente-Madrid	1
86	Leonor Emperatriz Alcalde Uriarte	2
87	Bautista Avilés Ibarra	5
88	Goyo Ferrández	4
89	Ernesto Villalba	5
90	Mario Ramirez	1
91	Víctor Blanca Carreras	2
92	Marisa Gárate Miguel	1
93	Santiago Segura Uría	5
94	Amparo Arranz Falcó	1
95	Amalia de Palomino	5
96	Pastor Galvez Lillo	5
97	Carlito Pacheco Carranza	2
98	Toni Alba Bermúdez	2
99	Isaías Tejedor-Mir	3
100	Marino Villalba Galán	1
101	Bernardino Marco Cisneros	5
102	América Celestina García Durán	1
103	Eustaquio Gilabert-Aramburu	4
104	Néstor Pina	2
105	Araceli Rojas Canals	2
106	Melisa de Pellicer	3
107	Benjamín de Solana	5
108	Irene del Llabrés	2
109	Tadeo Muñoz Ramis	2
110	Galo Olivera	4
111	Claudia Sastre Peinado	3
112	Cecilia Coello Prieto	3
113	Fabio Alcalá	5
114	Josefina de Nogués	2
115	Martín Cruz Fabregat Gomila	5
116	Maximino Alemany-Berenguer	3
117	Fabricio Puga Cabrera	5
118	Salomé Arteaga Duque	2
119	Martin Lupe Estévez Jaume	5
120	Florentina del Anguita	3
121	Milagros Moya-Bustamante	2
122	Leticia Portero Porras	2
123	Chita Aguirre Valbuena	5
124	Débora Marí Zurita	3
125	Benita Gabriela Vilar Becerra	4
126	Nicodemo Perelló Sureda	3
127	Jafet Domingo Coca	4
128	Pastora Nebot Amador	2
129	Roque Benavente	3
130	Constanza Ripoll-Company	5
131	Mohamed Páez Cánovas	3
132	Luciana Angelina Prat Barragán	1
133	Cesar Verdejo Tomás	1
134	Maite del Carpio	5
135	Albano Figueras Oliva	4
136	Ricardo Zamorano Sancho	1
137	Estrella Montenegro	1
138	Fabiana Llabrés Pedro	3
139	Clara del Antúnez	3
140	Arcelia Ferrándiz Castrillo	3
141	Valeria del Mata	3
142	Macaria Díaz Arce	5
143	Pepe Sancho Navarro Bernat	2
144	Bernarda Romero Vara	3
145	Anastasio Vigil	3
146	Eloy Pou Gallardo	3
147	Fernando Casanovas Aguiló	3
148	Carmelo Alcántara Castell	5
149	Esteban Exposito Gascón	1
150	Pili Almudena Escobar Morera	4
151	Loida Villanueva Egea	3
152	Ester Villanueva-Marco	3
153	Nayara Saura Carpio	5
154	Rogelio Criado-Pedro	3
155	Dimas Alfredo Sanchez Porta	4
156	Fabio Fabra Velasco	1
157	Delfina Felicia Guillen Esparza	2
158	Carlota Blanco Bárcena	1
159	Anastasia de Pujol	1
160	Fernanda de Bilbao	5
161	Pascuala Mármol	5
162	Imelda Martina Pons Grande	1
163	Teobaldo Berenguer Andreu	1
164	Mónica Fabiola Carrillo Luís	3
165	Camilo Fajardo Gisbert	1
166	Ramona Carpio Fonseca	3
167	Luis de Gelabert	2
168	Norberto Dueñas	1
169	Desiderio Cruz Solsona	4
170	Rosa María del Seguí	2
171	Ruy Esparza Diez	3
172	Moisés Marti-Mateu	4
173	Cipriano Alemán Barco	1
174	Máxima Castañeda Casals	1
175	Celestina Blanes Leal	1
176	Rita del Bellido	2
177	Josefa Marti-Antón	1
178	Albina Lopez Girón	5
179	Yago Gámez Cortes	5
180	Azucena Benítez Pinto	5
181	Dorita del Rozas	4
182	Primitiva Durán-Granados	4
183	Atilio Moliner Diéguez	2
184	Andrea Tejera Cortina	2
185	Timoteo Badía Zaragoza	5
186	Carolina Bermudez	5
187	Celso Murillo Llanos	5
188	Ernesto de Ávila	4
189	Ileana Araceli Hierro Egea	4
190	Estela Marco	1
191	Guiomar Rosario Galindo Maldonado	2
192	José Cayetana Ibarra Vera	5
193	María Jesús del Barceló	5
194	Alicia Almagro Tejada	3
195	Mireia Pérez Giménez	5
196	Flora Bibiana Ricart Mate	1
197	Glauco Cueto Benavent	2
198	María Del Carmen Zabala Grau	4
199	Amalia Camacho Gibert	1
200	Candelas García Canet	3
201	Odalys Gómez Expósito	3
202	Gonzalo Vargas Ballesteros	5
203	Severino Báez Sosa	4
204	Maricruz Sobrino-Aller	5
205	Valerio Suárez-Verdejo	3
206	Gabriel Riera	3
207	Arsenio Villena Blanch	5
208	Loreto Viña Gordillo	2
209	Gala Soriano Vilalta	5
210	Emma Miriam Elorza Castell	1
211	Ramón Company Cuesta	5
212	Margarita Pozuelo Rocha	2
213	Inocencio Batlle Muro	4
214	Juana del Villena	1
215	Calixto Adán Torrecilla	2
216	Ovidio Moliner Figueras	1
217	Ámbar del Ferrando	3
218	Cristóbal Castañeda-Abril	4
219	Iris Mosquera Vilar	5
220	Samu Almazán	3
221	Emiliano Campos-Mas	2
222	Juan Bautista Portillo Bernat	2
223	Casemiro del Vizcaíno	3
224	Renata Romeu Montenegro	1
225	Esteban Gilberto Céspedes Anaya	1
226	Haroldo Sans Giralt	2
227	Azeneth Comas-Pavón	3
228	Cruz Quirós-Hierro	2
229	Iker Barceló Noguera	4
230	Yésica Barriga	3
231	Eliseo Acedo Aguirre	5
232	Claudia Baquero Perelló	3
233	Rosenda del Cabo	1
234	Sergio Gras Coello	1
235	Victoria Gaya Alfonso	1
236	Débora Angelita Cervantes Lumbreras	1
237	Alejandro Berenguer Pintor	1
238	Gregorio Sales	5
239	Dorotea Gargallo Barroso	3
240	Lupe Jaume-Cabrera	5
241	Claudia Piña Mur	5
242	Ibán Verdugo Varela	1
243	Amando Agullo Grau	2
244	Adán Mendizábal	1
245	Ibán de Mateos	1
246	Socorro Prat Palomares	4
247	Andrés Felipe Ledesma Lumbreras	3
248	Morena Cuevas	4
249	Emperatriz Lamas Alonso	4
250	Reina Escrivá Murillo	3
251	Itziar Rosselló Espada	1
252	Ángeles Olivera Marquez	2
253	Marcela Tomas-Duran	5
254	Ricardo Adán Suárez	4
255	Dafne del Suarez	3
256	Benigna Ramos Bas	5
257	Fernanda del Villena	1
258	Ibán Moya Ibarra	1
259	Ale Cabanillas Peinado	3
260	Federico Quintero Calvo	3
261	Maximiliano Bou Rius	2
262	Ibán Pinto Esteban	1
263	Eufemia Rivas Collado	1
264	Ligia Quevedo Font	2
265	Federico Acero	5
266	Hortensia Posada Viana	2
267	Jaime Moreno Larrañaga	1
268	Norberto Guardia Egea	3
269	Jordi Durán Fuente	1
270	Sara Corral Céspedes	2
271	Ceferino Francisco Cantón	4
272	Francisco Jose Joaquín Duran Verdú	1
273	Clara Roca-Quintana	3
274	Manuel Villanueva Pino	3
275	Jose Ignacio del Porras	1
276	Hernando Teruel Elorza	3
277	Lilia del Río	3
278	Encarnacion Obdulia Chamorro Mariño	3
279	Ale Luque Villanueva	5
280	Dolores Guerrero	4
281	Remedios Bosch Patiño	5
282	Paca Cuadrado	3
283	Norberto del Montero	1
284	Domingo Villena Mendoza	3
285	Manuel del Estrada	1
286	Efraín Marín Montesinos	4
287	Juan Pablo Morcillo Andrés	3
288	Emelina del Solís	4
289	Reyes Sánchez Atienza	2
290	Carmen Carbajo Acero	4
291	Maura Aguilar Oliva	1
292	Luisa Nuria Valls Pintor	1
293	Ana Garmendia Pino	1
294	Ignacio Tena Angulo	5
295	Apolonia Amaya Viña	2
296	Régulo Márquez Mármol	5
297	Flor Castells Pujol	3
298	Amaro Ramos Montaña	3
299	Leyre Tapia-Sanmiguel	5
300	Carmelo Ramirez Carlos	5
301	Consuela Albero-Peralta	5
302	Ofelia Pedraza	4
303	Feliciana Arrieta	5
304	Yéssica del Llano	5
305	Vera Cabeza Burgos	4
306	Teodora Oliver Ripoll	2
307	Leopoldo Belmonte Matas	4
308	Régulo Porcel Cornejo	5
309	Chucho Benjamín Villalonga Mateos	4
310	Rosario Quiroga Roman	4
311	Cebrián del Blanch	4
312	Valerio del Múgica	4
313	Elodia Santamaria Malo	2
314	Armando Torre Larrañaga	2
315	Elvira Rovira-Briones	3
316	Maximiano de Querol	4
317	Martirio Navarrete Barranco	1
318	Felipe Iborra Jódar	4
319	Nidia Puerta Otero	5
320	Silvio Juárez-Suarez	1
321	María Pilar Neira Rivas	2
322	Agapito Mesa Gras	1
323	Blanca de Bustos	5
324	Guiomar Pedrero Padilla	5
325	Encarnacion Pedrosa Aramburu	2
326	Josué Morell Gelabert	1
327	Nazaret Catalá	2
328	Sabina Corominas Prat	4
329	Carmelo Bruno Fajardo Conde	5
330	Heraclio Zamorano	5
331	Emigdio Sáez Real	5
332	Cebrián de Arnau	5
333	Rafa Edu Bas Albero	1
334	Octavio Barco Galván	3
335	Herberto de Lerma	5
336	Zaida de Ramón	1
337	Cloe Dominguez	1
338	Francisco Javier Naranjo Rueda	1
339	Paulina Morata Mínguez	4
340	Adora Vélez	4
341	Carlota Castelló Priego	5
342	Graciela Iriarte-Sevillano	1
343	Hernán Reina Salcedo	5
344	Herminio Rius	4
345	Jose Luis Giménez Castilla	3
346	Ulises Belmonte Baños	2
347	Aníbal Espinosa Mesa	1
348	Cristian de Morante	2
349	Olivia Benavente Izaguirre	2
350	Lidia Valdés-Caparrós	3
351	Delia Menendez Villanueva	4
352	Inés Galvez Valcárcel	3
353	Francisca Acero Coca	1
354	Elisa Tamara Cadenas Girón	1
355	Martín Mayoral Dueñas	1
356	Vidal Alejo Blanch Sarabia	1
357	Adrián Boix Albero	4
358	Lázaro Amo Palacios	4
359	Abilio Carpio Peralta	5
360	Rosenda de Zorrilla	1
361	Nilda Guijarro Armengol	4
362	Eustaquio Trujillo Suárez	1
363	Valero Rodríguez Palomino	5
364	Ariel Franco Villaverde	3
365	Teodosio Carbajo Cabo	4
366	Bienvenida Alsina Coronado	5
367	Patricio Merino-Giner	5
368	Elisabet Cortina Bellido	5
369	Juan Luis Tudela Guijarro	1
370	Nando Priego Buendía	2
371	Ligia Navarrete Sevillano	2
372	René Armengol	4
373	Cruz Mármol Milla	4
374	Josefa del Murillo	1
375	Bárbara Naranjo-Gascón	4
376	Inmaculada Paz Peláez	3
377	Adelardo Ariza Pi	3
378	Lina Piñol-Villa	2
379	Candelas de Gutiérrez	2
380	Paulino Carrasco	2
381	Jordi Simó Lamas	1
382	Hernando Rueda-Roma	1
383	Amalia Lamas	3
384	Marcos Rocha Saura	3
385	Magdalena del Rosado	2
386	Jonatan Blanes Mesa	2
387	Fausto Marin Narváez	2
388	Esperanza Regina Farré Gordillo	1
389	Demetrio Canals Adadia	4
390	Anita Ani Escamilla Ugarte	2
391	Paco Arteaga-Casas	5
392	Vasco Mayo Jordán	2
393	Julie Fortuny-Blazquez	1
394	Poncio Pineda Cabanillas	1
395	Cintia del Higueras	4
396	Ascensión Serra-Fábregas	1
397	Lino Belda	1
398	Marisa Riquelme Borrell	4
399	Sandalio Portillo Alvarez	1
400	Matías Bernat Alvarado	1
401	Paola Rincón Montalbán	4
402	Arturo Porta	2
403	Purificación Mur-Peña	2
404	María Luisa Mata-Pareja	1
405	Roque Alemán Lara	4
406	Beatriz Heredia Cabrera	2
407	Melisa Sosa Téllez	5
408	Sergio Higueras Machado	5
409	Yago del Pujol	4
410	Juan Carlos Raya Barón	1
411	Buenaventura Aguado Espejo	2
412	Morena Sarabia	2
413	Domitila Almeida Gomis	2
414	Ema Ibáñez Solé	1
415	Daniela Rubio	5
416	Pánfilo Piñeiro-Mármol	1
417	Poncio Guardiola Solano	3
418	Dionisio del Garcés	3
419	Virgilio Ribera Quiroga	2
420	Marianela Ropero-Cobo	1
421	Pánfilo Blanca Campoy	5
422	Leonel Farré-Barragán	3
423	Rocío Llano-Aliaga	5
424	Rodolfo Merino Royo	3
425	Abraham Maldonado-Guardia	2
426	Miguel Ángel Serra Arias	1
427	Aura Losa Mármol	4
428	León Marciano Andrade Espinosa	2
429	Rosaura Fernandez Castellanos	4
430	Griselda Amelia Dávila Llobet	5
431	Telmo Torres Roca	3
432	Albert Lázaro Jerez Huguet	2
433	Liliana Vila-Enríquez	1
434	Carmelita Sainz Noguera	5
435	Mar Magdalena Pardo Palomino	2
436	Bárbara Barroso Abad	1
437	Soraya Amador Sacristán	2
438	Vilma Rubio	2
439	Daniela Morales Solís	5
440	Yolanda Mateo Báez	3
441	Georgina del Lastra	5
442	Nacio Zabala Portillo	3
443	Ruth Isaura Muñoz Bernat	4
444	Elpidio Bermudez Torralba	1
445	Mar de Guijarro	3
446	Amelia de Avilés	3
447	Haydée Quirós Zabala	3
448	Ezequiel Aliaga	2
449	Felicidad Toledo Gabaldón	4
450	Cristóbal Barrios Barberá	3
451	Crescencia Cabrero Naranjo	5
452	Jose Ignacio Iniesta Palomino	4
453	Desiderio Soler Rovira	5
454	Nayara Nereida Salas Arteaga	2
455	Jacobo Batlle Morán	2
456	Ricardo Escobar Donoso	5
457	Roxana Gabaldón Bustos	1
458	Natalio Humberto Gallo Amorós	5
459	Albert Pacheco Sevilla	3
460	Fernando Alberdi	1
461	Narciso Macias Barrio	5
462	Epifanio Jover Benito	5
463	Godofredo Reguera Valera	5
464	Palmira Lobo-Calderon	3
465	Encarnita Aguiló-Cruz	4
466	Cándida Roig	1
467	Ángeles Contreras Carrera	2
468	Áurea Mateu Duarte	2
469	Primitivo Quevedo Raya	1
470	Roberto Sainz-Palmer	4
471	Francisco Javier Pol Franco	5
472	Octavia Adán Perales	4
473	Marc Hoz	2
474	Fortunata de Quero	5
475	Heliodoro Valderrama	3
476	Odalys Llorens Arjona	1
477	Xavier Riba Cano	1
478	Zaida Giralt Elías	2
479	Otilia Andres Cózar	2
480	Angelina Moraleda Giralt	2
481	Plinio Alex Ros Jódar	5
482	Ana Sofía del Bosch	5
483	Teodora Arias	2
484	Araceli Quintana Santamaria	1
485	Severo Palomo	3
486	Milagros Prado	4
487	Luciana Vidal Planas	2
488	Amaro del Macías	4
489	Eva Riba Piñeiro	1
490	Jenny Manzanares Soria	3
491	Abraham Lledó	5
492	Clementina del Bas	3
493	Yaiza Tapia Alarcón	2
494	Régulo de Diaz	3
495	Pili Luz Herranz Zamorano	5
496	José Manuel Nacho Soto Hervia	3
497	René Velasco	2
498	Quirino del Garriga	3
499	Luz Patiño Merino	5
500	Artemio Matas Juárez	3
501	Jose Antonio Soler Rocha	1
502	Margarita Vilar-Bellido	5
503	María Jesús Jurado Carrión	5
504	Poncio Llopis Yuste	4
505	Daniel Sancho Cazorla	2
506	Glauco Solé	5
507	Jose Francisco Delgado Maldonado	1
508	Marc Lobato Pinedo	5
509	Alejo Villalobos Pons	3
510	Cleto Naranjo Olmo	4
511	Rita Montesinos Llano	4
512	Etelvina Marín Molina	2
513	Adoración Adela Jara Domingo	5
514	Rolando Pinto Echeverría	3
515	Manu Torrent Cardona	4
516	Eloy Cervantes	4
517	Lalo Castillo	4
518	Octavio Gimeno Pinto	3
519	Samuel Salvador-Terrón	3
520	Juanita Campo Meléndez	2
521	Edgardo Arrieta Carnero	2
522	Amado Barón Sobrino	5
523	Reyna Novoa	2
524	Maricela Morera Alcázar	2
525	Amanda Cerdán Tello	2
526	Toribio Mancebo	3
527	Claudio Tolosa-Palomar	4
528	Prudencia Zaida Torrijos Ribera	1
529	Ariel del Somoza	1
530	Eduardo Rebollo	2
531	Maricela Gonzalo Seguí	5
532	Luis Ángel del Alfaro	1
533	Herminio Guadalupe Núñez Miguel	4
534	Heraclio Garriga-Bayona	2
535	Isidoro Morell Acero	5
536	Odalys de Barberá	4
537	Rubén Piñol-Saavedra	2
538	Isabel de Carnero	5
539	María Del Carmen Hilda Navarro Galvez	5
540	Geraldo Vilanova-Montoya	5
541	Paula Escribano	2
542	Dani Felix Gallo Tejero	2
543	Teodora Tomas-Armengol	5
544	Leandra Osorio-Ibáñez	5
545	Iván Luciano Morante Álamo	2
546	Lisandro Cerdán Iriarte	4
547	Elena Borja Benavides	5
548	Carmina Gascón Jaén	4
549	Juan Carlos Buendía	4
550	Joaquín Aragonés-Zapata	2
551	Carmela Cid Sarmiento	4
552	Osvaldo del Alonso	2
553	Basilio Alemany-Lorenzo	5
554	Ale Estévez Godoy	3
555	Josué Tormo-Rey	4
556	Miguela Canet	5
557	Maristela Iborra Crespi	3
558	Amílcar Samper Peláez	4
559	Héctor Cortina Franco	5
560	Teresita Álvaro Mendizábal	5
561	Ágata Alegria Valdés	4
562	Manuelita Mariscal Riquelme	3
563	Ema Rebeca Bermúdez Pont	5
564	Aurelio Alegre Bárcena	2
565	Eusebio Echeverría Asensio	4
566	Paloma Cobos	5
567	Salvador Paz Mayol	3
568	Felicidad Pomares	5
569	Angelina Gómez Benet	2
570	Eladio Cabello	3
571	Lorenza Quirós Manuel	2
572	Marcos Águila Antón	5
573	Nicolás Giner Valenciano	5
574	Clarisa Crescencia Lloret Pallarès	4
575	Alberto Palmer Diaz	4
576	Fernando Merino	5
577	Delia Valentín	4
578	Eligia Morillo Iniesta	2
579	Delfina Alexandra Segarra Muñoz	3
580	Óscar Tormo Calvo	2
581	Eva Peralta	2
582	Verónica Robles-Neira	5
583	Lupita de Álvaro	5
584	Teo Pazos Guitart	5
585	Máximo Losada Blanes	3
586	Araceli Llorente Arnal	5
587	Sabas Barberá Ortega	3
588	Rómulo Rey Zaragoza	1
589	Crescencia Blanes Alcántara	4
590	Piedad Cuevas Zaragoza	3
591	Salud Araujo Sanchez	4
592	Jesusa Morcillo-Barreda	4
593	Cesar Juan Francisco Fabregat Hoyos	2
594	Conrado Nuñez Solana	5
595	Cesar Peralta Requena	4
596	Luis Ángel Rivas Pedrosa	2
597	María del Cabezas	4
598	Rosario Sastre Peiró	3
599	Bernarda Macias	3
600	Aránzazu Vigil Botella	2
601	Baltasar Figueroa Escrivá	1
602	Griselda Marín-Medina	2
603	Ana Figuerola Sastre	5
604	Bruno Vall Peinado	5
605	Cebrián Varela-Ballesteros	2
606	Encarnacion Cortes Manzano	4
607	Olalla del Crespo	3
608	Ale Sandoval Diez	3
609	Rolando Quevedo-Andrés	1
610	Angelina Doménech Pou	5
611	Teodoro Figuerola Ricart	2
612	Pedro Valero-Elías	4
613	Heraclio Vicente Vara Figuerola	3
614	Joan Pastor Gallo	3
615	Arturo Perea Francisco	4
616	Gilberto Solera	1
617	Teófila Beltran Feliu	5
618	Gabriela Ródenas Hernández	3
619	José Ángel Cabañas Polo	5
620	Felicidad Isaura Vera Grau	3
621	Flavia Gabaldón Bermúdez	4
622	Angelino Jimenez Franch	2
623	Humberto Zamorano Ordóñez	2
624	Ignacia Carmela Vives Daza	3
625	Domingo Vega Tamayo	1
626	León Guzman Gimeno	3
627	Pepita Sierra Hoz	2
628	Calista Cid Mínguez	1
629	Fabiola del Millán	4
630	Gema Castejón Sebastián	3
631	Manuel Arévalo Arenas	4
632	Virgilio de Agustín	4
633	Corona Heredia Castrillo	3
634	Narcisa Feijoo-Luz	1
635	Amarilis del Ayllón	3
636	Modesta del Reig	4
637	Rómulo Oliva Montero	5
638	Leonardo Segarra	1
639	Amaro Diez Montero	2
640	Tatiana Sevilla Cisneros	4
641	Eliana Paca Sacristán Contreras	1
642	Marcial Nicolás Machado	4
643	Judith Molins	3
644	Reyes Sandoval Duran	2
645	Sarita Campoy-Ramón	5
646	Pili Melisa Alonso Ferrándiz	1
647	Duilio Segovia Vilar	1
648	Manu del Plana	3
649	Griselda Bustamante	2
650	Dolores Pla Acevedo	3
651	Evangelina Mendez Oliver	2
652	Inocencio Lladó Reguera	4
653	Venceslás Rebollo Baquero	1
654	Urbano del Martínez	4
655	Heraclio Font Belda	5
656	Melisa Lozano Gimeno	2
657	Lina Francisca Espejo Alegre	3
658	Ileana Borrell-Sanjuan	3
659	Lola de Rueda	5
660	Julio César Agullo Madrid	2
661	Prudencia Briones Hoyos	5
662	Dominga Cuervo Domingo	5
663	Corona Coca-Manso	2
664	Guiomar Salvador Corominas	4
665	Tecla Asensio Nadal	2
666	Martin Andres	1
667	Duilio Villegas Adán	3
668	Cayetano Agustín Torre	4
669	Buenaventura Marti Martinez	5
670	Lilia Burgos Olivera	1
671	Antonia Ainara Mulet Marqués	4
672	Valeria Elías Escudero	5
673	Severo Samper-Camacho	2
674	Ema Cerro Matas	2
675	Eutropio Palomar Navarro	5
676	Celso Céspedes Peña	1
677	Hugo Mínguez Gallo	4
678	Miguel Galan-Cózar	4
679	Fausto del Asenjo	1
680	Jovita Huertas Nevado	1
681	Oriana Juan Mateo	4
682	Casemiro Bautista Rodríguez Alemany	2
683	Ariadna Bayo	3
684	Dafne Cámara-Mur	4
685	Flora Marina Abascal Ruano	5
686	Nicanor Cuéllar Sarmiento	3
687	Mohamed de Velázquez	5
688	Flora Berrocal Lobato	2
689	Jordi Calvet Carmona	2
690	Luz del Cid	5
691	Ramona Velasco Zorrilla	1
692	Fátima de Cases	3
693	Herminio del Villena	2
694	Alexandra Carmina Riquelme Delgado	5
695	Guiomar Córdoba-Quiroga	3
696	Camilo de Sarmiento	5
697	Alex de Aragón	5
698	Amarilis del Ferrer	1
699	Lorenza Gallart Capdevila	2
700	Cosme Diego Dominguez Bárcena	3
701	Rosario Segura Mendoza	1
702	Ruben Barral Agullo	5
703	Ana Belén Ileana Peral Santiago	5
704	Emelina Puga Donoso	1
705	Baldomero Castilla Lucena	5
706	Itziar Mateu Bejarano	4
707	Rafaela Peñas-Piquer	3
708	Nazaret Pozo-Cervantes	1
709	Noa Madrigal Higueras	3
710	Patricio Arce	2
711	Gastón Pinto Cordero	4
712	Merche del Fabregat	1
713	Íñigo Figueras Carreño	3
714	Marc Chaves-Checa	5
715	Manuel Guardiola Palacios	2
716	Jacinta del Sanmiguel	4
717	Desiderio Gilberto Varela Albero	1
718	Concepción Dueñas Quintero	5
719	Alma de Cal	1
720	Manu Oller Bertrán	2
721	Carina Valentina Valbuena Leon	1
722	Ximena Casado Rueda	2
723	Jacinto Valcárcel Diéguez	1
724	Marcelino Marin-Alegria	4
725	Raquel del Llano	5
726	Marciano Sanchez	3
727	Andrea Beltrán Losa	1
728	Rosalva Olivera Ibañez	3
729	Eufemia Juliana Cervantes Naranjo	1
730	Celestina Uría-Chamorro	5
731	Custodio Pinedo Sastre	3
732	Dorita Alarcón Andres	1
733	Domingo Morell Guerra	2
734	Ema Sáez Vall	4
735	Vicente del Guzmán	4
736	Cebrián Baños Pons	4
737	Pablo Anguita Chaves	1
738	Elvira Rivero Ferrán	3
739	Artemio Cámara Carlos	2
740	Maxi Medina-Ortuño	3
741	Guiomar Doménech Luna	5
742	Horacio Jódar Blazquez	4
743	Bernardo Berto Doménech Pol	2
744	Luis Ángel Vinicio Bustamante Quintana	2
745	Rosalva Amo	4
746	Román Vergara Alcolea	2
747	Emelina Uría Teruel	1
748	Yéssica Manzanares	3
749	Marisa Amaya Lozano Tovar	3
750	Adolfo del Arévalo	4
751	Mónica Salgado Cortina	4
752	Sebastián Ricart Chacón	5
753	Visitación Redondo Huguet	5
754	Casandra Blanch Barrio	1
755	Marcelino Marco Grau	2
756	Rogelio Infante Fabra	1
757	Ascensión Nicolás Frías	2
758	Leocadio Almeida Luján	2
759	Fermín Pagès Buendía	1
760	Sandra Vera Hierro	4
761	Olimpia Sola Alba	1
762	Gerónimo Gabino Hervia Asensio	2
763	Amelia Casares-Marcos	2
764	Julia Paz Alba Meléndez	3
765	Bautista Guzman Uribe	2
766	Florina Celestina Miralles Riquelme	4
767	Jacobo Chico Calzada	3
768	Maxi Amigó-Téllez	4
769	Ariel Castañeda Barceló	2
770	Andrés Soria Quintana	2
771	Fermín Vendrell Fuente	5
772	Clementina Sabater-Salas	5
773	Clara Alcolea	2
774	Áurea de Haro	3
775	Rufino Casas Aparicio	3
776	Plácido Germán Guillen Barceló	1
777	Margarita Gámez Vicente	3
778	Estela Linares Palomino	5
779	Adán Saavedra Atienza	5
780	Nazaret Fábregas Castells	4
781	Pili Bustos-Caro	5
782	Elodia Cervera Lloret	4
783	Teodosio Ojeda Pinto	4
784	Estefanía Correa Díaz	5
785	Bibiana Rocha	1
786	Arsenio de Suárez	1
787	Artemio Esparza-Amaya	3
788	Dalila Esteban Pereira	3
789	Desiderio Rubio Ugarte	1
790	Adelia Camps-Godoy	4
791	Geraldo Garzón Baeza	3
792	Amanda Hierro Jiménez	2
793	Flavio Mateos Girona	4
794	Loreto Jimenez Salvà	2
795	Florina Ribas Morán	4
796	Baldomero Alemán Niño	4
797	Catalina Hervás Caballero	5
798	Ignacio Alcaraz-Capdevila	3
799	Leoncio Melero-Gimeno	2
800	Nicanor Donaire Catalán	2
801	Cebrián Canales Botella	5
802	Yolanda Marqués-Viña	3
803	Adelina Cañete Grau	5
804	Salomón Tolosa	5
805	María Pilar Roma Ibáñez	4
806	Aitana Páez	2
807	Maximiano Nebot Carlos	1
808	Gervasio Rueda	1
809	Bautista Bernat Tirado	4
810	Jose Francisco Buendía Ramirez	3
811	Aureliano del Vives	3
812	Natividad Mateos Laguna	2
813	Alfonso Real Morcillo	2
814	Eusebia Querol-Flores	3
815	Gabriel Céspedes Araujo	1
816	Horacio Viña Aguirre	1
817	Valerio Bárcena Torres	4
818	Eloísa Agustí Tamayo	4
819	Alejandra Amo Pinedo	5
820	Teodoro del Álvarez	3
821	Eloísa Carbó Galvez	4
822	Javi Navarro Diego	2
823	Federico Soriano Ávila	3
824	Lisandro de Lucas	2
825	Jorge Amorós Armas	1
826	Wálter Canet	5
827	Azahara Luna Echeverría	1
828	Agapito Ugarte Gargallo	4
829	Guadalupe Herranz Alonso	1
830	Desiderio del Tirado	2
831	Loreto Esteban Morata	3
832	Nazario Narváez Balaguer	1
833	Rogelio Muñoz Alcázar	4
834	Luz del Varela	3
835	Andrés Felipe Blasco Rojas	5
836	Elena Amaya	1
837	Alfonso del Amaya	3
838	Jose Manuel Redondo-Jove	1
839	Piedad Lozano Royo	3
840	Graciela Redondo Valls	5
841	Fabricio Sánchez	3
842	Carmelita Sonia Olmedo Gomis	3
843	Luis Amo Ocaña	1
844	Patricia del Pons	3
845	Jacinta Torre Amor	1
846	Sebastián Robles Alvarez	2
847	Luisina Pellicer-Medina	4
848	Amador Mascaró Conesa	2
849	Sol Navarrete Fuente	2
850	Luciano de Alberto	5
851	Rocío del Cobos	2
852	Jennifer del Zorrilla	4
853	Casemiro Pujol	3
854	Olga Adadia Gracia	5
855	Rogelio Vega Gomis	2
856	Pascuala Torrijos Carrión	5
857	Viviana Lola Crespi Lamas	5
858	Eufemia Mancebo Rosado	3
859	Begoña Sevilla Morán	2
860	Paula Castañeda Coca	2
861	Heraclio Che Folch Frías	5
862	Paloma Cordero Arcos	2
863	Piedad Albina Aguilera Plana	4
864	Jacinto de Anaya	5
865	Flora Vila Vega	4
866	Héctor Alarcón-Borrás	2
867	Calista Ramos Torrent	2
868	Benjamín Gallart Carreño	1
869	Aurelia Corominas	4
870	Dionisio Carmona Cantón	1
871	Vasco Boix Farré	3
872	Rosalía Marcia Valcárcel Díez	3
873	Ciro Figueroa-Alcázar	2
874	Natividad Flores-Sevilla	2
875	Jessica Parra Aramburu	1
876	Curro Tapia Cruz	2
877	Liliana Amaya Alberola	1
878	Arturo Prieto	5
879	Nieves Marco Higueras	5
880	Salomé Grande Gabaldón	4
881	Rosalía Portillo-Orozco	1
882	Consuelo de Carrera	5
883	María Jesús Cortina-Mariscal	2
884	Jennifer Felisa Peláez Sanmiguel	3
885	Nilda Nebot Perez	1
886	Primitivo Corbacho Pi	5
887	Fidela Somoza Luz	2
888	Teodoro Palma Escamilla	5
889	Mireia Pilar Ballesteros Palma	3
890	Pepito Hoyos Almansa	3
891	Remedios Catalán Roselló	2
892	Elena Correa-Asensio	1
893	Trinidad Luz Sánchez Tamayo	4
894	Merche Querol-Codina	2
895	Azahara Baeza Alberdi	1
896	Néstor Fortuny Cazorla	5
897	Eligia Santamaria Coll	5
898	Valero Fito Nevado Galán	5
899	Apolonia Arce Puente	2
900	Juanita del Fiol	1
901	Jorge Carro Juárez	4
902	Delia Ricarda Rodriguez Pastor	2
903	Mónica Lloret-Arnau	4
904	Juan Díez Barragán	4
905	Darío del Torrecilla	1
906	Ariel Mármol Folch	2
907	Benito Tena Coll	4
908	Remigio Arsenio Sanmiguel Cazorla	2
909	Dorita Viana	1
910	Celestina Beltrán-Arnaiz	5
911	Emilio Prudencio Teruel Gutierrez	3
912	Cintia Sarita Patiño Pino	2
913	María Carmen Chacón	2
914	Valentina Guerra-Roig	2
915	Candelario Cayetano Llobet Pallarès	2
916	Gerónimo Rivero Caparrós	2
917	Íñigo Parejo	5
918	Heraclio Jimenez Company	2
919	Paula Alvarez Juan	4
920	Rebeca Vera Donoso Garay	2
921	Pancho Barriga Expósito	4
922	Sonia Felipa Pozuelo Tomé	2
923	Baldomero Gutierrez Báez	1
924	Rómulo Falcó	4
925	Adalberto Granados	5
926	Adolfo Piquer Céspedes	3
927	Irene Baños Pardo	5
928	Hernando Ramírez Ortega	5
929	Pacífica Rodríguez Peralta	4
930	Nélida Niño Casanova	1
931	Manuelita Casado	2
932	Ignacia de Gámez	2
933	Edmundo Llorens Farré	3
934	Enrique Agustín Tapia	1
935	Tere de Calleja	3
936	Clemente Jordá Herrera	5
937	Melisa Marco-Frías	1
938	Nélida Calderón-Sanmartín	2
939	Sebastian Ribas Camps	4
940	Américo Herranz Río	3
941	Eloísa del Tomas	1
942	Sigfrido Antúnez Guzmán	1
943	Norberto de Solé	3
944	Rogelio Llorente Baena	2
945	Leoncio Bruno Bermudez Rosado	5
946	Sofía del Moya	4
947	Eligio de Losada	1
948	Melchor Catalá Echeverría	4
949	Edgardo Larrañaga Morcillo	1
950	Ciriaco Balduino Niño Solís	1
951	José Hurtado Madrid	4
952	Federico Montalbán Guardia	2
953	Pascual Tamarit Mosquera	2
954	Jennifer de Ocaña	5
955	Teo Marco Calderon	5
956	María Dolores Aguirre	2
957	Javiera Huertas Domingo	1
958	Édgar de Quintana	5
959	Natanael Huertas Segovia	3
960	Rosalía Urrutia Barros	5
961	Eva Calderon	5
962	Agapito Sanz Abascal	1
963	Andrés Felipe Cazorla	1
964	Maristela Lola Alfaro Durán	1
965	Vicenta Nuñez Barceló	1
966	Raúl del Conde	4
967	Eusebio Marqués Sacristán	2
968	Francisco Javier Recio Barral	3
969	Constanza Morales Verdejo	3
970	Andrés Felipe Bueno-Coello	2
971	Fulgencio Cañete Aliaga	1
972	Ángeles Morales Cerdá	4
973	Aroa Mendizábal Ariza	3
974	Montserrat Torrecilla	4
975	Marisa Cadenas-Lozano	5
976	Marcela Criado-Calderón	3
977	Pablo Marin Leiva	3
978	Miguel Ángel Parejo Mulet	1
979	Liliana Dávila Gonzalo	5
980	Gerónimo Amigó	1
981	Goyo Guerra Ureña	5
982	Crescencia Abella Priego	5
983	Serafina Pellicer	4
984	Mireia Falcó Mayo	3
985	Miriam Anselma Montenegro Toledo	3
986	Andrés Pla-Tamayo	2
987	Guadalupe Coello-Asenjo	5
988	Ovidio Castejón-Pulido	3
989	Marina Blanch Barriga	3
990	Carlota Pedrosa-Daza	5
991	Albano Sáenz	3
992	Joaquina Luna Pereira Ojeda	3
993	Ana Sofía Roura Ureña	5
994	Sandra Josefina Quintanilla Chaparro	5
995	Alexandra Porcel Lillo	5
996	Cristian Ambrosio Menéndez Mate	3
997	Evelia Ámbar Feliu Huertas	3
998	Lope Robles-Bartolomé	3
999	Paulino Salgado Lara	4
1000	Leonel Montero Alberdi	1
\.


--
-- Name: animales_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.animales_id_seq', 95, true);


--
-- Name: animales_idcuidador_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.animales_idcuidador_seq', 1, false);


--
-- Name: animales_idespecie_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.animales_idespecie_seq', 1, false);


--
-- Name: animales_idhabitat_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.animales_idhabitat_seq', 1, false);


--
-- Name: auditoria_animales_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: postgres
--

SELECT pg_catalog.setval('animals.auditoria_animales_id_seq', 2, true);


--
-- Name: clima_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.clima_id_seq', 15, true);


--
-- Name: cuidador_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.cuidador_id_seq', 20, true);


--
-- Name: cuidador_idespecialidad_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.cuidador_idespecialidad_seq', 1, false);


--
-- Name: especialidad_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.especialidad_id_seq', 15, true);


--
-- Name: especie_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.especie_id_seq', 63, true);


--
-- Name: especie_idestadoconservacion_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.especie_idestadoconservacion_seq', 1, false);


--
-- Name: especie_idfamilia_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.especie_idfamilia_seq', 1, false);


--
-- Name: estado_conservacion_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.estado_conservacion_id_seq', 9, true);


--
-- Name: familia_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.familia_id_seq', 22, true);


--
-- Name: habitat_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.habitat_id_seq', 23, true);


--
-- Name: habitat_idclima_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.habitat_idclima_seq', 1, false);


--
-- Name: habitat_idubicacion_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.habitat_idubicacion_seq', 1, false);


--
-- Name: habitat_visitantes_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.habitat_visitantes_id_seq', 1011, true);


--
-- Name: habitat_visitantes_idhabitat_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.habitat_visitantes_idhabitat_seq', 1, false);


--
-- Name: habitat_visitantes_idvisitantes_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.habitat_visitantes_idvisitantes_seq', 1, false);


--
-- Name: tipo_visitantes_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.tipo_visitantes_id_seq', 5, true);


--
-- Name: ubicacion_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.ubicacion_id_seq', 20, true);


--
-- Name: visitantes_id_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.visitantes_id_seq', 1000, true);


--
-- Name: visitantes_idtipovisitante_seq; Type: SEQUENCE SET; Schema: animals; Owner: adminzoo
--

SELECT pg_catalog.setval('animals.visitantes_idtipovisitante_seq', 1, false);


--
-- Name: animales animales_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_pkey PRIMARY KEY (id);


--
-- Name: auditoria_animales auditoria_animales_pkey; Type: CONSTRAINT; Schema: animals; Owner: postgres
--

ALTER TABLE ONLY animals.auditoria_animales
    ADD CONSTRAINT auditoria_animales_pkey PRIMARY KEY (id);


--
-- Name: clima clima_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.clima
    ADD CONSTRAINT clima_pkey PRIMARY KEY (id);


--
-- Name: cuidador cuidador_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.cuidador
    ADD CONSTRAINT cuidador_pkey PRIMARY KEY (id);


--
-- Name: especialidad especialidad_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id);


--
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (id);


--
-- Name: estado_conservacion estado_conservacion_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.estado_conservacion
    ADD CONSTRAINT estado_conservacion_pkey PRIMARY KEY (id);


--
-- Name: familia familia_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.familia
    ADD CONSTRAINT familia_pkey PRIMARY KEY (id);


--
-- Name: habitat habitat_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat
    ADD CONSTRAINT habitat_pkey PRIMARY KEY (id);


--
-- Name: habitat_visitantes habitat_visitantes_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat_visitantes
    ADD CONSTRAINT habitat_visitantes_pkey PRIMARY KEY (id);


--
-- Name: tipo_visitantes tipo_visitantes_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.tipo_visitantes
    ADD CONSTRAINT tipo_visitantes_pkey PRIMARY KEY (id);


--
-- Name: ubicacion ubicacion_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.ubicacion
    ADD CONSTRAINT ubicacion_pkey PRIMARY KEY (id);


--
-- Name: visitantes visitantes_pkey; Type: CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.visitantes
    ADD CONSTRAINT visitantes_pkey PRIMARY KEY (id);


--
-- Name: idx_habitat_visitantes; Type: INDEX; Schema: animals; Owner: adminzoo
--

CREATE INDEX idx_habitat_visitantes ON animals.habitat_visitantes USING btree (id);


--
-- Name: idx_habitat_visitantes_habitat_id; Type: INDEX; Schema: animals; Owner: adminzoo
--

CREATE INDEX idx_habitat_visitantes_habitat_id ON animals.habitat_visitantes USING btree (idhabitat);


--
-- Name: animales trigger_auditoria_animales; Type: TRIGGER; Schema: animals; Owner: adminzoo
--

CREATE TRIGGER trigger_auditoria_animales AFTER UPDATE ON animals.animales FOR EACH ROW EXECUTE FUNCTION animals.registrar_cambios_animales();


--
-- Name: habitat_visitantes trigger_calculo_costo; Type: TRIGGER; Schema: animals; Owner: adminzoo
--

CREATE TRIGGER trigger_calculo_costo BEFORE INSERT ON animals.habitat_visitantes FOR EACH ROW EXECUTE FUNCTION animals.calcular_costo_final();


--
-- Name: animales animales_idcuidador_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_idcuidador_fkey FOREIGN KEY (idcuidador) REFERENCES animals.cuidador(id);


--
-- Name: animales animales_idespecie_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_idespecie_fkey FOREIGN KEY (idespecie) REFERENCES animals.especie(id);


--
-- Name: animales animales_idhabitat_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_idhabitat_fkey FOREIGN KEY (idhabitat) REFERENCES animals.habitat(id);


--
-- Name: cuidador cuidador_idespecialidad_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.cuidador
    ADD CONSTRAINT cuidador_idespecialidad_fkey FOREIGN KEY (idespecialidad) REFERENCES animals.especialidad(id);


--
-- Name: especie especie_idestadoconservacion_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especie
    ADD CONSTRAINT especie_idestadoconservacion_fkey FOREIGN KEY (idestadoconservacion) REFERENCES animals.estado_conservacion(id);


--
-- Name: especie especie_idfamilia_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.especie
    ADD CONSTRAINT especie_idfamilia_fkey FOREIGN KEY (idfamilia) REFERENCES animals.familia(id);


--
-- Name: habitat habitat_idclima_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat
    ADD CONSTRAINT habitat_idclima_fkey FOREIGN KEY (idclima) REFERENCES animals.clima(id);


--
-- Name: habitat habitat_idubicacion_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat
    ADD CONSTRAINT habitat_idubicacion_fkey FOREIGN KEY (idubicacion) REFERENCES animals.ubicacion(id);


--
-- Name: habitat_visitantes habitat_visitantes_idhabitat_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat_visitantes
    ADD CONSTRAINT habitat_visitantes_idhabitat_fkey FOREIGN KEY (idhabitat) REFERENCES animals.habitat(id);


--
-- Name: habitat_visitantes habitat_visitantes_idvisitantes_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.habitat_visitantes
    ADD CONSTRAINT habitat_visitantes_idvisitantes_fkey FOREIGN KEY (idvisitantes) REFERENCES animals.visitantes(id);


--
-- Name: visitantes visitantes_idtipovisitante_fkey; Type: FK CONSTRAINT; Schema: animals; Owner: adminzoo
--

ALTER TABLE ONLY animals.visitantes
    ADD CONSTRAINT visitantes_idtipovisitante_fkey FOREIGN KEY (idtipovisitante) REFERENCES animals.tipo_visitantes(id);


--
-- PostgreSQL database dump complete
--

