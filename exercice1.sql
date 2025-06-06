CREATE TABLE utilisateurs(
   id_etudiant INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   numero_etudiant VARCHAR(20) UNIQUE,
   PRIMARY KEY(id_etudiant)
);

CREATE TABLE materiel(
   id_materiel INT,
   nom_materiel VARCHAR(50),
   description VARCHAR(150),
   quantite_disponible INT,
   PRIMARY KEY(id_materiel)
);

CREATE TABLE reservations(
   id_reservation INT,
   date_debut DATE,
   date_fin DATE,
   numero_etudiant VARCHAR(50),
   id_materiel INT,
   id_etudiant INT NOT NULL,
   id_materiel_1 INT NOT NULL,
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_etudiant) REFERENCES Utilisateurs(id_etudiant),
   FOREIGN KEY(id_materiel_1) REFERENCES Materiel(id_materiel)
);

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

INSERT INTO reservations (id_reservation, date_debut, date_fin, id_etudiant, id_materiel) VALUES
(1, '2025-05-01', '2025-05-05', 1, 2),
(2, '2025-05-03', '2025-05-04', 1, 3),
(3, '2025-05-02', '2025-05-07', 3, 4),
(4, '2025-05-10', '2025-05-12', 4, 7),
(5, '2025-05-15', '2025-05-16', 5, 3);
