-- #################################################
-- #         DOCUMENTACIÓN DEL SCRIPT DDL          #
-- #################################################

-- Descripción: Este script define la estructura de una base de datos para un zoológico,
--              incluyendo tablas para animales, cuidadores, especialidades, especies,
--              familias taxonómicas, estado de conservación, hábitats, ubicaciones,
--              climas y visitantes, con sus relaciones definidas mediante claves foráneas.
--              Este diseño garantiza la integridad referencial y organiza los datos
--              de manera normalizada para facilitar consultas y operaciones.

-- #################################################
-- #                 DEFINICIÓN DE TABLAS           #
-- #################################################

-- Tabla ANIMALES:
-- Almacena información sobre los animales del zoológico, incluyendo su nombre,
-- fecha de nacimiento, y referencias a su cuidador, hábitat y especie.

CREATE TABLE ANIMALES (
  ID SERIAL PRIMARY KEY,         -- Identificador único del animal
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del animal (obligatorio)
  FechaNac DATE,                 -- Fecha de nacimiento del animal
  IDCuidador SERIAL,              -- Identificador del cuidador (clave foránea)
  IDHabitat SERIAL,              -- Identificador del hábitat (clave foránea)
  IDEspecie SERIAL               -- Identificador de la especie (clave foránea)
);

-- Tabla CUIDADOR:
-- Almacena datos de los cuidadores del zoológico, incluyendo nombre y fecha de contratación.
-- Cada cuidador puede tener una especialidad en el manejo de animales.

CREATE TABLE CUIDADOR (
  ID SERIAL PRIMARY KEY,         -- Identificador único del cuidador
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del cuidador (obligatorio)
  FechaContratacion DATE NOT NULL, -- Fecha de contratación del cuidador
  IDEspecialidad SERIAL          -- Identificador de la especialidad (clave foránea)
);

-- Tabla ESPECIALIDAD:
-- Define las especialidades de los cuidadores, como manejo de reptiles o mamíferos.

CREATE TABLE ESPECIALIDAD (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la especialidad
  Nombre VARCHAR(50) NOT NULL    -- Nombre de la especialidad (obligatorio)
);

-- Tabla ESPECIE:
-- Representa las especies a las que pertenecen los animales, con referencias a la familia
-- taxonómica y al estado de conservación.

CREATE TABLE ESPECIE (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la especie
  Nombre VARCHAR(50) NOT NULL,   -- Nombre de la especie (obligatorio)
  IDFamilia SERIAL,              -- Identificador de la familia (clave foránea)
  IDEstadoConservacion SERIAL    -- Identificador del estado de conservación (clave foránea)
);

-- Tabla FAMILIA:
-- Almacena las familias taxonómicas de las especies, permitiendo su clasificación.

CREATE TABLE FAMILIA (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la familia taxonómica
  NombreCientifico VARCHAR(50) NOT NULL, -- Nombre científico de la familia
  NombreComun VARCHAR(50) NOT NULL       -- Nombre común de la familia
);

-- Tabla ESTADO_CONSERVACION:
-- Define el estado de conservación de las especies, como en peligro o extinto.

CREATE TABLE ESTADO_CONSERVACION (
  ID SERIAL PRIMARY KEY,         -- Identificador único del estado de conservación
  Codigo VARCHAR(2) NOT NULL,    -- Código breve del estado (obligatorio)
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del estado de conservación
  Descripcion VARCHAR(50) NOT NULL -- Descripción adicional del estado
);

-- Tabla HABITAT:
-- Representa los hábitats del zoológico, incluyendo su ubicación y clima.

CREATE TABLE HABITAT (
  ID SERIAL PRIMARY KEY,         -- Identificador único del hábitat
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del hábitat (obligatorio)
  IDUbicacion SERIAL,            -- Identificador de la ubicación (clave foránea)
  IDClima SERIAL                 -- Identificador del tipo de clima (clave foránea)
);

-- Tabla UBICACION:
-- Almacena las ubicaciones dentro del zoológico, donde se encuentran los hábitats.

CREATE TABLE UBICACION (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la ubicación
  Nombre VARCHAR(50) NOT NULL    -- Nombre de la ubicación (obligatorio)
);

-- Tabla CLIMA:
-- Define los diferentes tipos de clima asociados a los hábitats.

CREATE TABLE CLIMA (
  ID SERIAL PRIMARY KEY,         -- Identificador único del tipo de clima
  Nombre VARCHAR(50) NOT NULL    -- Nombre del tipo de clima (obligatorio)
);

-- Tabla VISITANTES:
-- Almacena los datos de los visitantes, permitiendo registrar sus visitas al zoológico.

CREATE TABLE VISITANTES (
  ID SERIAL PRIMARY KEY,         -- Identificador único del visitante
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del visitante (obligatorio)
  FechaVisita DATE               -- Fecha de la visita al zoológico
);

-- Tabla HABITAT_VISITANTES:
-- Tabla intermedia para registrar las visitas de los visitantes a los hábitats.

CREATE TABLE HABITAT_VISITANTES (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la visita
  IDHabitat SERIAL,              -- Identificador del hábitat visitado (clave foránea)
  IDVisitantes SERIAL            -- Identificador del visitante (clave foránea)
);

-- #################################################
-- #            DEFINICIÓN DE RELACIONES           #
-- #################################################

-- Relaciones de la tabla ANIMALES
ALTER TABLE ANIMALES ADD FOREIGN KEY (IDCuidador) REFERENCES CUIDADOR (ID);
ALTER TABLE ANIMALES ADD FOREIGN KEY (IDHabitat) REFERENCES HABITAT (ID);
ALTER TABLE ANIMALES ADD FOREIGN KEY (IDEspecie) REFERENCES ESPECIE (ID);

-- Relación de la tabla CUIDADOR
ALTER TABLE CUIDADOR ADD FOREIGN KEY (IDEspecialidad) REFERENCES ESPECIALIDAD (ID);

-- Relaciones de la tabla ESPECIE
ALTER TABLE ESPECIE ADD FOREIGN KEY (IDFamilia) REFERENCES FAMILIA (ID);
ALTER TABLE ESPECIE ADD FOREIGN KEY (IDEstadoConservacion) REFERENCES ESTADO_CONSERVACION (ID);

-- Relaciones de la tabla HABITAT
ALTER TABLE HABITAT ADD FOREIGN KEY (IDUbicacion) REFERENCES UBICACION (ID);
ALTER TABLE HABITAT ADD FOREIGN KEY (IDClima) REFERENCES CLIMA (ID);

-- Relaciones de la tabla intermedia HABITAT_VISITANTES
ALTER TABLE HABITAT_VISITANTES ADD FOREIGN KEY (IDHabitat) REFERENCES HABITAT (ID);
ALTER TABLE HABITAT_VISITANTES ADD FOREIGN KEY (IDVisitantes) REFERENCES VISITANTES (ID);

-- #################################################
-- #               FIN DE LA DOCUMENTACIÓN         #
-- #################################################