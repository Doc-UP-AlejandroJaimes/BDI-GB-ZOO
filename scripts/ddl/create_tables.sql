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

CREATE TABLE animals.ANIMALES (
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

CREATE TABLE animals.CUIDADOR (
  ID SERIAL PRIMARY KEY,         -- Identificador único del cuidador
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del cuidador (obligatorio)
  FechaContratacion DATE NOT NULL, -- Fecha de contratación del cuidador
  Salario NUMERIC(10, 2) NOT NULL, -- Salario en COP del Cuidador.
  IDEspecialidad SERIAL          -- Identificador de la especialidad (clave foránea)
);

-- Tabla ESPECIALIDAD:
-- Define las especialidades de los cuidadores, como manejo de reptiles o mamíferos.

CREATE TABLE animals.ESPECIALIDAD (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la especialidad
  Nombre VARCHAR(50) NOT NULL    -- Nombre de la especialidad (obligatorio)
);

-- Tabla ESPECIE:
-- Representa las especies a las que pertenecen los animales, con referencias a la familia
-- taxonómica y al estado de conservación.

CREATE TABLE animals.ESPECIE (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la especie
  Nombre VARCHAR(50) NOT NULL,   -- Nombre de la especie (obligatorio)
  IDFamilia SERIAL,              -- Identificador de la familia (clave foránea)
  IDEstadoConservacion SERIAL    -- Identificador del estado de conservación (clave foránea)
);

-- Tabla FAMILIA:
-- Almacena las familias taxonómicas de las especies, permitiendo su clasificación.

CREATE TABLE animals.FAMILIA (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la familia taxonómica
  NombreCientifico VARCHAR(50) NOT NULL, -- Nombre científico de la familia
  NombreComun VARCHAR(50) NOT NULL       -- Nombre común de la familia
);

-- Tabla ESTADO_CONSERVACION:
-- Define el estado de conservación de las especies, como en peligro o extinto.

CREATE TABLE animals.ESTADO_CONSERVACION (
  ID SERIAL PRIMARY KEY,         -- Identificador único del estado de conservación
  Codigo VARCHAR(2) NOT NULL,    -- Código breve del estado (obligatorio)
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del estado de conservación
  Descripcion VARCHAR(50) NOT NULL -- Descripción adicional del estado
);

-- Tabla HABITAT:
-- Representa los hábitats del zoológico, incluyendo su ubicación y clima.

CREATE TABLE animals.HABITAT (
  ID SERIAL PRIMARY KEY,         -- Identificador único del hábitat
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del hábitat (obligatorio)
  IDUbicacion SERIAL,            -- Identificador de la ubicación (clave foránea)
  CostoBase NUMERIC(10, 2) NOT NULL, -- Tarifa base del habitat COP.
  IDClima SERIAL                 -- Identificador del tipo de clima (clave foránea)
);

-- Tabla UBICACION:
-- Almacena las ubicaciones dentro del zoológico, donde se encuentran los hábitats.

CREATE TABLE animals.UBICACION (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la ubicación
  Nombre VARCHAR(50) NOT NULL    -- Nombre de la ubicación (obligatorio)
);

-- Tabla CLIMA:
-- Define los diferentes tipos de clima asociados a los hábitats.

CREATE TABLE animals.CLIMA (
  ID SERIAL PRIMARY KEY,         -- Identificador único del tipo de clima
  Nombre VARCHAR(50) NOT NULL    -- Nombre del tipo de clima (obligatorio)
);

-- Tabla TIPO_VISITANTES
-- Define los tipos de visitantes y sus descuentos asociados
CREATE TABLE animals.TIPO_VISITANTES (
    ID SERIAL PRIMARY KEY, -- Identificador único para cada tipo de visitante
    Nombre VARCHAR(50) NOT NULL, -- Nombre del tipo de visitante (e.g., Adulto, Menor de edad)
    Descuento NUMERIC(5, 2) NOT NULL CHECK (Descuento BETWEEN 0 AND 100) -- Porcentaje de descuento aplicable a este tipo de visitante
);

-- Tabla VISITANTES:
-- Almacena los datos de los visitantes, permitiendo registrar sus visitas al zoológico.

CREATE TABLE animals.VISITANTES (
  ID SERIAL PRIMARY KEY,         -- Identificador único del visitante
  Nombre VARCHAR(50) NOT NULL,   -- Nombre del visitante (obligatorio)
  IDTipoVisitante SERIAL
);

-- Tabla HABITAT_VISITANTES:
-- Tabla intermedia para registrar las visitas de los visitantes a los hábitats.

CREATE TABLE animals.HABITAT_VISITANTES (
  ID SERIAL PRIMARY KEY,         -- Identificador único de la visita
  IDHabitat SERIAL,              -- Identificador del hábitat visitado (clave foránea)
  IDVisitantes SERIAL,            -- Identificador del visitante (clave foránea)
  CostoFinal NUMERIC(10, 2) NOT NULL, -- Costo final, obtenido con la funcion calcular costo.
  FechaVisita DATE               -- Fecha de la visita al zoológico
);

-- #################################################
-- #            DEFINICIÓN DE RELACIONES           #
-- #################################################

-- Relaciones de la tabla ANIMALES
ALTER TABLE animals.ANIMALES ADD FOREIGN KEY (IDCuidador) REFERENCES animals.CUIDADOR (ID);
ALTER TABLE animals.ANIMALES ADD FOREIGN KEY (IDHabitat) REFERENCES animals.HABITAT (ID);
ALTER TABLE animals.ANIMALES ADD FOREIGN KEY (IDEspecie) REFERENCES animals.ESPECIE (ID);

-- Relación de la tabla CUIDADOR
ALTER TABLE animals.CUIDADOR ADD FOREIGN KEY (IDEspecialidad) REFERENCES animals.ESPECIALIDAD (ID);

-- Relaciones de la tabla ESPECIE
ALTER TABLE animals.ESPECIE ADD FOREIGN KEY (IDFamilia) REFERENCES animals.FAMILIA (ID);
ALTER TABLE animals.ESPECIE ADD FOREIGN KEY (IDEstadoConservacion) REFERENCES animals.ESTADO_CONSERVACION (ID);

-- Relaciones de la tabla HABITAT
ALTER TABLE animals.HABITAT ADD FOREIGN KEY (IDUbicacion) REFERENCES animals.UBICACION (ID);
ALTER TABLE animals.HABITAT ADD FOREIGN KEY (IDClima) REFERENCES animals.CLIMA (ID);

-- Relaciones de la tabla TIPO_VISITANTES
ALTER TABLE animals.VISITANTES ADD FOREIGN KEY (IDTipoVisitante) REFERENCES animals.TIPO_VISITANTES (ID);

-- Relaciones de la tabla intermedia HABITAT_VISITANTES
ALTER TABLE animals.HABITAT_VISITANTES ADD FOREIGN KEY (IDHabitat) REFERENCES animals.HABITAT (ID);
ALTER TABLE animals.HABITAT_VISITANTES ADD FOREIGN KEY (IDVisitantes) REFERENCES animals.VISITANTES (ID);

-- #################################################
-- #               FIN DE LA DOCUMENTACIÓN         #
-- #################################################