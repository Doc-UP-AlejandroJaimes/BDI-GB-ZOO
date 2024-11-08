SET client_encoding = 'UTF8';

INSERT INTO animals.FAMILIA (NombreCientifico, NombreComun) VALUES
('Felidae', 'Felinos'),         -- Ejemplo: Tigres, leones, panteras.
('Canidae', 'Canidos'),         -- Ejemplo: Lobos, zorros.
('Ursidae', 'Ursidos'),         -- Ejemplo: Osos.
('Cercopithecidae', 'Monos del viejo mundo'), -- Ejemplo: Mandriles, babuinos.
('Hominidae', 'Grandes simios'), -- Ejemplo: Gorilas, chimpances.
('Elephantidae', 'Elefantes'),   -- Ejemplo: Elefantes.
('Psittacidae', 'Loros'),        -- Ejemplo: Guacamayos, cacatuas.
('Testudinidae', 'Tortugas terrestres'), -- Ejemplo: Tortugas gigantes.
('Crocodylidae', 'Cocodrilos'),  -- Ejemplo: Cocodrilos.
('Delphinidae', 'Delfín'),       -- Ejemplo: Delfines.
('Balaenopteridae', 'Ballena'),       -- Ejemplo: Delfines.
('Phocidae', 'Foca'),       -- Ejemplo: Delfines.
('Formicidae', 'Hormigas'),
('Coleoptera', 'Escarabajos'),
('Apidae', 'Abejorros'),
('Nymphalidae', 'Mariposas'),
('Lampyridae', 'Luciernagas'),
('Vespidae', 'Avispas'),
('Gryllidae', 'Grillos'),
('Vespertilionidae', 'Murciélagos'),
('Strigidae', 'Lechuzas'),
('Pteropodidae', 'Zorros voladores');

INSERT INTO animals.ESTADO_CONSERVACION (Codigo, Nombre, Descripcion) VALUES
('EX', 'Extinto', 'La especie ya no existe'),
('EW', 'Extinto en estado salvaje', 'Solo sobrevive en cautiverio'),
('CR', 'En peligro critico', 'En peligro extremo de extinción'),
('EN', 'En peligro', 'Alto riesgo de extincion'),
('VU', 'Vulnerable', 'Riesgo elevado de extincion a mediano plazo'),
('NT', 'Casi amenazado', 'En riesgo, pero no aun en peligro'),
('LC', 'Preocupacion menor', 'Bajo riesgo de extincion'),
('DD', 'Datos deficientes', 'No hay informacion suficiente'),
('NE', 'No evaluado', 'Aun no se ha evaluado el estado de conservacion');

INSERT INTO animals.UBICACION (Nombre) VALUES
('Zona Tropical'),         -- Area dedicada a animales de climas tropicales
('Zona Desertica'),        -- Area con habitats deserticos
('Zona de Montaña'),       -- Area para animales de zonas montañosas
('Aviario'),               -- Espacio para aves
('Acuario'),               -- Espacio para especies acuaticas
('Zona de Reptiles'),      -- Espacio dedicado a reptiles
('Sabana Africana'),       -- Area que imita el ambiente de la sabana
('Bosque Lluvioso'),       -- Area que representa un bosque tropical humedo
('Zona de Mamiferos'),     -- Area para diversos mamiferos
('Area de Exhibicion'),    -- Area de exhibicion general
('Centro de Conservacion'),-- Espacio para especies en programas de conservacion
('Zona de Aves'),          -- Area general para especies de aves
('Pradera'),               -- Area dedicada a especies de pradera
('Habitat Artico'),        -- Area recreada para animales de clima frio
('Habitat Nocturno'),      -- Espacio para especies nocturnas
('Zona de Insectos'),      -- Espacio para especies de insectos
('Jardin Botanico'),       -- Area con flora y fauna
('Playa Artificial'),      -- Espacio para especies costeras y marinas
('Recinto de Grandes Felinos'), -- Area dedicada a tigres, leones, etc.
('Zona de Alimentacion');  -- Area de alimentacion y observacion

INSERT INTO animals.CLIMA (Nombre) VALUES
('Tropical'),            -- Clima calido y humedo, tipico de zonas tropicales
('Desertico'),           -- Clima seco y caluroso, propio de desiertos
('Templado'),            -- Clima con variaciones moderadas de temperatura
('Mediterraneo'),        -- Clima calido y seco en verano, suave en invierno
('Polar'),               -- Clima extremadamente frio, propio de zonas articas
('Continental'),         -- Clima con veranos calidos e inviernos frios
('Subtropical'),         -- Clima calido y humedo, aunque menos que el tropical
('Monzonico'),           -- Clima caracterizado por lluvias intensas en una temporada
('Arido'),               -- Clima muy seco, con escasa precipitacion
('Humedo'),              -- Clima con alta humedad y frecuentes lluvias
('Nuboso'),              -- Clima caracterizado por cielos nublados la mayor parte del tiempo
('Lluvioso'),            -- Clima con lluvias constantes durante todo el año
('Seco'),                -- Clima con muy poca precipitacion
('Marino'),              -- Clima costero, con temperaturas moderadas y humedad alta
('Alpino');              -- Clima de montaña, con aire fresco y temperaturas bajas

INSERT INTO animals.ESPECIALIDAD (Nombre) VALUES
('Manejo de Grandes Felinos'),    -- Habilidad para cuidar y manejar tigres, leones, etc.
('Cuidados de Reptiles'),         -- Especializacion en reptiles como serpientes y cocodrilos
('Aves Exoticas'),                -- Habilidad en el cuidado de especies de aves exoticas
('Mamiferos Marinos'),            -- Especialista en delfines, focas, etc.
('Primates'),                     -- Habilidad en el manejo de monos y simios
('Animales de Clima Frio'),       -- Cuidado de especies de habitats frios como pinguinos y osos polares
('Animales en Peligro de Extincion'), -- Manejo y cuidado de especies en programas de conservacion
('Animales Nocturnos'),           -- Especializacion en animales que son activos durante la noche
('Grandes Herbivoros'),           -- Cuidado de elefantes, rinocerontes, etc.
('Manejo de Veneno y Antidotos'), -- Especialista en especies venenosas como serpientes y arañas
('Cuidados de Insectos'),         -- Especializacion en insectos, como mariposas y escarabajos
('Animales del Desierto'),        -- Cuidado de especies adaptadas a climas aridos
('Acuario'),                      -- Cuidado de especies acuaticas y peces
('Animales Domesticos'),          -- Manejo de especies domesticas en areas de contacto
('Cria en Cautiverio');           -- Habilidad en la reproduccion controlada de especies en zoologicos

INSERT INTO animals.TIPO_VISITANTES (Nombre, Descuento) VALUES 
('Adulto', 0.00),        -- Sin descuento
('Menor de edad', 10.00), -- 10% de descuento
('Estudiante', 20.00),   -- 20% de descuento
('Adulto mayor', 15.00),  -- 15% de descuento
('Persona con discapacidad', 25.00); -- 25% de descuento