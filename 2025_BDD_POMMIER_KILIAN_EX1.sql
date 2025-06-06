-- Création de la table utilisateurs contenant les informations personnelles des étudiants.
-- Le champ `id_etudiant` est la clé primaire, et `numero_etudiant` est unique pour éviter les doublons d’identifiants.
CREATE TABLE utilisateurs(
   id_etudiant INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   numero_etudiant VARCHAR(20) UNIQUE,
   PRIMARY KEY(id_etudiant)
);

-- Création de la table materiel listant les équipements disponibles à la réservation.
-- Chaque matériel est identifié par `id_materiel` (clé primaire).
CREATE TABLE materiel(
   id_materiel INT,
   nom_materiel VARCHAR(50),
   description VARCHAR(150),
   quantite_disponible INT,
   PRIMARY KEY(id_materiel)
);

-- Création de la table des réservations.
-- Chaque réservation associe un étudiant à un matériel, avec des dates de début et de fin.
-- Les clés étrangères garantissent l’intégrité référentielle avec les tables `utilisateurs` et `materiel`.
CREATE TABLE reservations(
   id_reservation INT,
   date_debut DATE,
   date_fin DATE,
   numero_etudiant VARCHAR(50),
   id_materiel INT,
   id_etudiant INT NOT NULL,
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_etudiant) REFERENCES utilisateurs(id_etudiant),
   FOREIGN KEY(id_materiel) REFERENCES materiel(id_materiel)
);

-- Insertion de 10 utilisateurs fictifs dans la table utilisateurs.
-- Les données couvrent des noms, prénoms, emails et numéros étudiants simulés pour les tests.
INSERT INTO utilisateurs (nom, prenom, email, numero_etudiant) VALUES
('Dupont', 'Alice', 'alice.dupont@example.com', '01'),
('Martin', 'Lucas', 'lucas.martin@example.com', '02'),
('Durand', 'Sophie', 'sophie.durand@example.com', '03'),
('Leroy', 'Thomas', 'thomas.leroy@example.com', '04'),
('Petit', 'Laura', 'laura.petit@example.com', '05'),
('Moreau', 'Nicolas', 'nicolas.moreau@example.com', '06'),
('Fournier', 'Emma', 'emma.fournier@example.com', '07'),
('Girard', 'Léo', 'leo.girard@example.com', '08'),
('Garnier', 'Chloé', 'chloe.garnier@example.com', '09'),
('Chevalier', 'Nathan', 'nathan.chevalier@example.com', '10')

-- Insertion de 10 équipements disponibles à la réservation avec leurs caractéristiques (nom, description, quantité).
INSERT INTO materiel (id_materiel, nom_materiel, description, quantite_disponible) VALUES
(1, 'Ordinateur portable', 'PC Lenovo ThinkPad avec 16 Go de RAM', 5),
(2, 'Caméra', 'Caméra 4K Sony', 3),
(3, 'Projecteur', 'Vidéoprojecteur HD BenQ', 2),
(4, 'Microphone', 'Micro USB Blue Yeti', 4),
(5, 'Casque audio', 'Casque antibruit Bose', 6),
(6, 'Tablette graphique', 'Wacom Intuos Pro', 2),
(7, 'Imprimante 3D', 'Creality Ender 3', 1),
(8, 'Clé USB', 'Clé USB 64 Go', 10),
(9, 'Routeur Wi-Fi', 'Routeur TP-Link AC1200', 2),
(10, 'Arduino Kit', 'Kit de démarrage Arduino Uno', 7);

-- Insertion de 5 réservations correspondant à des prêts de matériel par différents utilisateurs.
-- Les dates sont utilisées pour simuler des périodes de réservation réalistes.
INSERT INTO reservations (id_reservation, date_debut, date_fin, id_etudiant, id_materiel) VALUES
(1, '2025-05-01', '2025-05-05', 1, 2),
(2, '2025-05-03', '2025-05-04', 1, 3),
(3, '2025-05-02', '2025-05-07', 3, 4),
(4, '2025-05-10', '2025-05-12', 4, 7),
(5, '2025-05-15', '2025-05-16', 5, 3);
