SET client_encoding = 'UTF8';

INSERT INTO animals.HABITAT (Nombre, IDUbicacion, IdClima) VALUES
-- Habitats tropicales
('Selva densa tropical', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona Tropical'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Tropical')),
('Llanura africana', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Sabana Africana'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Tropical')),
('Humedal tropical', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Bosque Lluvioso'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Lluvioso')),

-- Habitats deserticos
('Desierto arenoso', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona Desertica'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Desertico')),
('Cañón seco', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona de Reptiles'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Arido')),

-- Habitats montañosos
('Pico nevado', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona de Montaña'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Alpino')),
('Bosque templado alto', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona de Montaña'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Templado')),

-- Habitats acuaticos
('Reef coralino', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Acuario'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Marino')),
('Manglares costeros', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Acuario'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Humedo')),

-- Aviarios
('Santuario de aves tropicales', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Aviario'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Tropical')),
('Páramo de aves rapaces', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Aviario'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Seco')),

-- Habitats de animals.CLIMA frio
('Tundra ártica', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Habitat Artico'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Polar')),
('Bosque de coníferas', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona de Montaña'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Polar')),

-- Otros Habitats especificos
('Vivero tropical', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Jardin Botanico'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Humedo')),
('Estepa continental', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Pradera'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Continental')),
('Refugio crepuscular', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Habitat Nocturno'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Nuboso')),
('Costa rocosa', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Playa Artificial'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Marino')),

-- Zonas de exhibicion y conservacion
('Exhibición de biomas', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Area de Exhibicion'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Templado')),
('Reserva de fauna', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Centro de Conservacion'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Templado')),

-- Areas especificas para grupos de animales
('Territorio felino', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Recinto de Grandes Felinos'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Tropical')),
('Insectario tropical', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona de Insectos'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Humedo')),
('Valle de aves', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona de Aves'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Lluvioso')),
('Llanura de mamíferos', (SELECT ID FROM animals.UBICACION WHERE Nombre = 'Zona de Mamiferos'), (SELECT ID FROM animals.CLIMA WHERE Nombre = 'Continental'));
