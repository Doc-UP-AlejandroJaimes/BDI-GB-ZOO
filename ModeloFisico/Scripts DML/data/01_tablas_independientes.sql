SET client_encoding = 'UTF8';

INSERT INTO FAMILIA (NombreCientifico, NombreComun) VALUES
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

INSERT INTO ESTADO_CONSERVACION (Codigo, Nombre, Descripcion) VALUES
('EX', 'Extinto', 'La especie ya no existe'),
('EW', 'Extinto en estado salvaje', 'Solo sobrevive en cautiverio'),
('CR', 'En peligro critico', 'En peligro extremo de extinción'),
('EN', 'En peligro', 'Alto riesgo de extincion'),
('VU', 'Vulnerable', 'Riesgo elevado de extincion a mediano plazo'),
('NT', 'Casi amenazado', 'En riesgo, pero no aun en peligro'),
('LC', 'Preocupacion menor', 'Bajo riesgo de extincion'),
('DD', 'Datos deficientes', 'No hay informacion suficiente'),
('NE', 'No evaluado', 'Aun no se ha evaluado el estado de conservacion');

INSERT INTO UBICACION (Nombre) VALUES
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

INSERT INTO CLIMA (Nombre) VALUES
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

INSERT INTO ESPECIALIDAD (Nombre) VALUES
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

INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Godiva Silverlock', '2011-02-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jacquette Fagence', '2013-04-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Reube Cheverton', '2012-11-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Leelah Caldroni', '2022-08-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Rozina Vango', '2006-08-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ursala Abramin', '2010-10-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Honoria Kuhnhardt', '2017-07-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Oliver Machen', '2008-07-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Conant Goldberg', '2022-05-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jermaine Axelby', '2012-12-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Lynsey Seamarke', '2012-11-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chick Jobbins', '2009-12-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Dasie Creffield', '2008-04-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Rebe Brockton', '2023-08-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Adore Couzens', '2019-08-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Essie Forsard', '2018-07-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Minnie Bellew', '2011-12-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Pier Pawelski', '2011-08-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Philipa Junkison', '2009-08-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Nikita Dunning', '2019-01-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Annie Trytsman', '2012-02-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Baryram Edmeads', '2005-11-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Baryram McCrae', '2022-05-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Lek Gribbin', '2009-01-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Robert Okie', '2010-07-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cleon Colmer', '2019-01-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gerry Simkovich', '2006-03-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Bernice Rogge', '2006-10-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ludovika Bront', '2022-04-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cobbie Ivanenko', '2011-10-28');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Timmie McRae', '2021-02-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gena Tibbs', '2007-12-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Raquel Hapgood', '2021-08-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Krista Bartlam', '2023-08-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Stanford Bovingdon', '2014-02-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Bartolemo Lias', '2015-04-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kirsteni Gepson', '2008-11-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Fredericka Biggadyke', '2024-03-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Nev Freckingham', '2020-08-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Walden MacSharry', '2011-11-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Sacha Strangward', '2009-06-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Eberto Morrieson', '2022-06-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ronny Batham', '2017-02-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Krystal Bircher', '2008-08-30');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Roseann Tendahl', '2015-09-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Brand Waye', '2015-02-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Isabel Loutheane', '2009-05-06');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gilda Verecker', '2008-10-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Rycca Kerbler', '2020-04-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Allyce Pelos', '2015-03-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Bibby Winpenny', '2023-10-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Celisse Lee', '2010-06-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Dora Machans', '2014-04-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Beatriz Lowbridge', '2015-05-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Barri Janik', '2007-08-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Horace Bassil', '2012-08-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Neill Holberry', '2019-08-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gertruda Hardern', '2013-10-29');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Christan Risborough', '2019-01-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Aldon Gagie', '2013-04-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Peta Ferre', '2023-08-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Bard Johns', '2006-04-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Georgeanne Redwall', '2008-07-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Marcie Bearne', '2012-02-29');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cart Nipper', '2024-02-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kelsi Kiss', '2021-11-27');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Elva Cicccitti', '2007-04-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Charleen Cluckie', '2024-05-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Brady Codner', '2009-07-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Dionisio Fleisch', '2021-12-30');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Evvy Gravenall', '2021-06-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Fulton Schwandner', '2023-11-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Giacomo McCorrie', '2005-12-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Marielle Challinor', '2007-07-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Monti Gregon', '2011-01-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Pietra Mattersey', '2011-09-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Morgen Haestier', '2012-12-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jo ann Cowwell', '2015-01-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Petronella Deakes', '2007-05-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Curt Vignal', '2009-11-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Godart Hierro', '2005-11-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Celinka Peterson', '2024-09-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cloe Launder', '2014-11-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Erick Dhenin', '2009-11-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Osmund Stovold', '2018-04-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kleon Losebie', '2018-01-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Misty Dytham', '2019-06-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Augusta Gaunter', '2018-11-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mira McGinly', '2017-05-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Collen Woolger', '2018-09-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kial Barnardo', '2020-05-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Tome Sprionghall', '2021-02-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Carny Ianittello', '2005-11-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Halie Cure', '2007-08-06');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Xenia Delouch', '2023-10-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Dougy Bouller', '2022-03-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Florie Pietesch', '2008-12-06');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Holly-anne Brawn', '2009-03-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Demetris Fabri', '2017-08-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Balduin Di Biaggi', '2018-09-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Waiter Lanfranconi', '2017-12-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mill Grouer', '2009-01-31');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Sol Shearman', '2014-12-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gar Gopsall', '2018-05-06');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Alwyn Treweke', '2007-06-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Garrott Puddin', '2022-04-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Alexandra Hartil', '2008-04-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kaitlin Stowe', '2016-01-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Allx Yuill', '2009-04-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Norbert Mogg', '2021-06-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Waring Briddock', '2011-07-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Stepha Gabler', '2007-12-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Reider Szymaniak', '2015-05-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Scott Kunat', '2013-07-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ilario Fenix', '2005-11-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Raeann Tineman', '2008-11-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Rosalia Whistance', '2020-03-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chlo McNeice', '2015-03-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Rem Paulino', '2015-07-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Colas Simonsson', '2013-12-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Shoshana Pomeroy', '2014-11-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Reeba L''argent', '2007-10-28');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Shirl Nares', '2011-12-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Nerte Drohane', '2008-02-06');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ad Eastop', '2013-10-30');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Karen Eat', '2022-10-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Sunny Pressnell', '2023-10-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Carlotta Wadeling', '2008-05-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Zak Cardozo', '2021-09-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Costa Pretty', '2011-06-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chiquia Merali', '2015-05-31');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Freida Goodsell', '2007-09-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Yorke Godden', '2009-06-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Andriette Laroze', '2017-07-28');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Junette Coghlan', '2012-12-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Angelika Portam', '2006-06-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Rebecca Dreakin', '2024-07-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ninnette Bassett', '2015-03-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Giffy Clarkin', '2021-07-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Timmy Tunuy', '2014-05-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chrissy Cottu', '2023-09-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Nara Brouncker', '2011-07-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Salomo Bullocke', '2021-07-28');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Marita Mitchenson', '2022-08-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jorrie Jachtym', '2014-05-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jesse Lauks', '2016-09-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Aurelea Snoden', '2013-12-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Crissy Hardbattle', '2018-05-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('De witt Jerman', '2011-05-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Osborne Olford', '2021-05-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Valentine Wichard', '2024-05-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gabbie Nanni', '2015-08-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Shani Cranstone', '2022-07-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Dareen Thornthwaite', '2006-09-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chlo Peet', '2006-07-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jere Quene', '2008-03-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Reamonn Arnfield', '2020-01-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Clemens Caustic', '2014-03-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Arda Aitchinson', '2010-06-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ulrica Edworthye', '2014-06-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Paddie Mullenger', '2021-08-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mikaela Prendeguest', '2007-07-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Hortensia Degli Abbati', '2021-01-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Farrell Tubbs', '2014-01-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ignacio Tainton', '2017-03-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mark Borzone', '2023-07-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Consalve Durrans', '2018-10-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cathleen Dickson', '2012-12-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Alberto Gadson', '2021-10-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Horton Scading', '2006-04-27');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Alan Milborn', '2023-12-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Creight Hustings', '2012-01-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Clemens Forestall', '2011-07-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Raffaello Lacaze', '2016-04-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ruben Knatt', '2023-06-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Carlene Nicholson', '2013-04-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Joelynn Izhak', '2012-10-30');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Miguel Sandlin', '2024-08-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Wolfgang Casassa', '2021-01-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Dara Martinson', '2014-03-30');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Arabel Tooley', '2012-02-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ode Gomm', '2010-06-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Merilee Cowin', '2005-12-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Justina Tiffin', '2007-06-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kareem Pauler', '2019-01-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Hadria Amner', '2012-06-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Lowrance Petrollo', '2022-02-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Shalom Tersay', '2015-11-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Darbie Dabs', '2022-10-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Anabal Faltin', '2006-08-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jenna Gookey', '2006-11-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Andrew Fanner', '2021-07-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Zerk Cowterd', '2008-02-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kata Foro', '2015-10-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Fidelio Callan', '2018-03-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gal Montez', '2022-03-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chad Leake', '2016-09-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Benedicta Guiett', '2023-12-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Anjanette Bram', '2012-11-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Wylie Wedlake', '2012-09-30');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cristian Henrie', '2014-05-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Agnese Barwood', '2015-06-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Lyssa Stutter', '2024-04-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jillian Willarton', '2023-03-31');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Inessa MacKonochie', '2024-03-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Susie Wynes', '2011-10-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Benny Alexsandrev', '2010-06-27');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Zorana Twinborough', '2018-04-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Klara Lehemann', '2013-12-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Augustus Baldassi', '2019-01-29');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Dawna Ivkovic', '2019-03-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Bartolemo Scurr', '2013-08-28');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Everard Cosham', '2015-02-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gerhardt Enticknap', '2013-07-30');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Panchito Veale', '2013-08-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Yves M''Quharge', '2006-11-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Fin Challoner', '2010-03-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Zane Willmot', '2011-03-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Renae Peyzer', '2015-09-18');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cammy Baudains', '2014-05-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Rickey Gason', '2014-01-31');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Todd Wholesworth', '2021-03-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Hertha Simco', '2023-07-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Prue Emmer', '2023-05-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Alis Vidler', '2016-02-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Clywd Colten', '2015-05-07');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mickey Micah', '2013-02-14');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Manolo Roddie', '2007-07-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Gaile Simion', '2023-09-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Clement Jemmison', '2008-09-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Salaidh D''eye', '2021-08-27');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Evey Starbucke', '2009-03-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Fredric Wannell', '2013-02-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Babette Di Francecshi', '2011-12-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Eadmund Beadnell', '2022-10-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Darryl Bindon', '2018-07-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Emmalyn Korejs', '2022-09-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Selina Machent', '2008-09-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Paola Spary', '2006-02-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Doralia Loftus', '2015-03-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Caddric Lyddiatt', '2019-04-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Abbe Rhucroft', '2015-11-01');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Brandy Dixcee', '2024-03-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cornell Whitaker', '2023-01-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Novelia Pearcey', '2010-05-27');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chariot Melburg', '2018-05-06');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Husain Tropman', '2016-05-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mab Krolak', '2017-03-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mildred Cases', '2013-11-29');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Sterling Teasell', '2012-05-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Addy Frackiewicz', '2010-09-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Borg Rushmare', '2014-04-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Nani Cay', '2022-04-26');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Seth Loudian', '2011-09-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Marquita Scibsey', '2008-03-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Anatol Janeway', '2011-04-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Walt Kyston', '2024-06-21');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Burlie Alten', '2022-12-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Yancey Lunam', '2017-12-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Idalia Dudley', '2007-08-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Merline Ravenhill', '2021-12-19');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Stearn Lightwing', '2008-01-24');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Kipp Richardet', '2018-11-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Austine Ren', '2018-11-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Jacintha Garnar', '2021-02-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Trip O''Fergus', '2016-05-05');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Alleen Hustings', '2015-10-27');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Tina Dewberry', '2021-06-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Berri Harbinson', '2019-10-29');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Bruce Keyte', '2019-11-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Neila Vain', '2016-02-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Trude Hector', '2013-01-10');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Erinn Tweede', '2017-10-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Magdalena Timms', '2017-05-16');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Emelina Paolozzi', '2020-08-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Drugi Soles', '2012-08-31');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Nathaniel Thake', '2006-02-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cairistiona Bonafant', '2014-05-08');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Hilliard Tidgewell', '2016-06-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Flori Vanshin', '2010-04-06');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Chantalle Myerscough', '2013-05-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Doralynn Critchell', '2020-09-15');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Seka O''Carrol', '2023-03-28');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Sergio Yurasov', '2006-12-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Nappy Rolance', '2013-08-12');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Garret Cajkler', '2008-01-27');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Des Coit', '2009-04-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Towney Attac', '2024-10-13');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ame Giabucci', '2021-04-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Cobby Fealy', '2008-08-17');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Locke Rollings', '2016-05-09');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Mose Woolrich', '2009-02-02');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Sylvester Woodhall', '2023-06-22');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Lotty McGillacoell', '2021-08-03');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Stephanus McLafferty', '2008-09-20');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Ivan Biset', '2012-07-23');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Bunni Harring', '2011-11-11');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Stafford Jewel', '2006-09-25');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Delmar Bernhardsson', '2006-02-04');
INSERT INTO VISITANTES (Nombre, FechaVisita) VALUES ('Elsie Tale', '2012-12-14');