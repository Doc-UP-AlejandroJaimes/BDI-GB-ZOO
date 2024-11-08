// Modelo de Base de Datos para Gestión de Zoológico

/*
Este script define la estructura de una base de datos relacional diseñada para gestionar 
la información de un zoológico. Incluye detalles de animales, cuidadores, especies, hábitats, 
visitantes y otras entidades relacionadas. 

Cada tabla representa una entidad en el zoológico, con relaciones establecidas mediante 
claves foráneas que aseguran la integridad referencial y minimizan la redundancia de datos. 
La estructura sigue las reglas de la Cuarta Forma Normal (4FN) para optimizar la organización 
de los datos.

Tablas Principales:
  - ANIMALES: Almacena información específica de cada animal, incluyendo su cuidador, hábitat y especie.
  - CUIDADOR: Registra los datos de los cuidadores, así como su especialidad en el cuidado de animales.
  - ESPECIE: Define las especies animales, con información sobre su familia taxonómica y estado de conservación.
  - HABITAT: Describe los hábitats del zoológico, junto con su ubicación, tipo de clima y costo base.
  - VISITANTES: Registra la información de los visitantes al zoológico y su tipo.

Tablas de Referencia:
  - ESPECIALIDAD: Enumera las especialidades de los cuidadores.
  - FAMILIA: Clasifica las especies en diferentes familias taxonómicas.
  - ESTADO_CONSERVACION: Describe los posibles estados de conservación de las especies.
  - UBICACION: Define las diferentes ubicaciones físicas del zoológico.
  - CLIMA: Enumera los tipos de clima asociados a los hábitats.
  - TIPO_VISITANTES: Define los tipos de visitantes y los descuentos asociados.

Tabla Intermedia:
  - HABITAT_VISITANTES: Relaciona los hábitats y visitantes, permitiendo rastrear los hábitats visitados y el costo final calculado.

Este diseño facilita el seguimiento detallado y preciso de las operaciones en el zoológico, 
permitiendo, por ejemplo, asociar animales con sus respectivos cuidadores, hábitats y especies, 
así como analizar los patrones de visitas a cada hábitat. Las claves foráneas y las referencias 
en el script garantizan que los datos estén correctamente relacionados y que se mantenga 
la consistencia en el sistema.
*/
Table ANIMALES {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
  FechaNac DATE [null]
  IDCuidador SERIAL [ref: > CUIDADOR.ID]
  IDHabitat SERIAL [ref: > HABITAT.ID]
  IDEspecie SERIAL [ref: > ESPECIE.ID]
}

Table CUIDADOR {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
  FechaContratacion DATE [not null]
  Salario NUMERIC [not null]
  IDEspecialidad SERIAL [ref: > ESPECIALIDAD.ID]
}

Table ESPECIALIDAD {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
}

Table ESPECIE {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
  IDFamilia SERIAL [ref: > FAMILIA.ID]
  IDEstadoConservacion SERIAL [ref: > ESTADO_CONSERVACION.ID]
}

Table FAMILIA {
  ID SERIAL [pk]
  NombreCientifico VARCHAR [not null]
  NombreComun VARCHAR [not null]
}

Table ESTADO_CONSERVACION {
  ID SERIAL [pk]
  Codigo VARCHAR(2) [not null]
  Nombre VARCHAR [not null]
  Descripcion VARCHAR [not null]
}

Table HABITAT {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
  CostoBase NUMERIC [not null]
  IDUbicacion SERIAL [ref: > UBICACION.ID]
  IDClima SERIAL [ref: > CLIMA.ID]
}

Table UBICACION {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
}

Table CLIMA {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
}

Table TIPO_VISITANTES {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
  Descuento NUMERIC(5, 2) [not null] //CHECK (Descuento BETWEEN 0 AND 100)
}


Table VISITANTES {
  ID SERIAL [pk]
  Nombre VARCHAR [not null]
  IdTipoVisitantes  SERIAL [ref: > TIPO_VISITANTES.ID]
}

// Tabla intermedia
Table HABITAT_VISITANTES {
  ID SERIAL [pk]
  IDHabitat SERIAL [ref: > HABITAT.ID]
  IDVisitantes SERIAL [ref: > VISITANTES.ID]
  FechaVisita DATE [null] //DEFAULT CURRENT_DATE
  CostoFinal NUMERIC [not null]

}
