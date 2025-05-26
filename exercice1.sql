CREATE TABLE utilisateurs(
   id_etudiant INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
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

INSERT INTO utilisateurs (nom, prenom, email) VALUES
('Dupont', 'Alice', 'alice.dupont@example.com'),
('Martin', 'Lucas', 'lucas.martin@example.com'),
('Durand', 'Sophie', 'sophie.durand@example.com'),
('Leroy', 'Thomas', 'thomas.leroy@example.com'),
('Petit', 'Laura', 'laura.petit@example.com'),
('Moreau', 'Nicolas', 'nicolas.moreau@example.com'),
('Fournier', 'Emma', 'emma.fournier@example.com'),
('Girard', 'Léo', 'leo.girard@example.com'),
('Garnier', 'Chloé', 'chloe.garnier@example.com'),
('Chevalier', 'Nathan', 'nathan.chevalier@example.com')

INSERT INTO materiel (nom, description, quantite_disponible) VALUES 
('Ordinateur portable', 'PC Lenovo ThinkPad avec 16 Go de RAM', 5),
('Caméra', 'Caméra 4K Sony', 3),
('Projecteur', 'Vidéoprojecteur HD BenQ', 2),
('Microphone', 'Micro USB Blue Yeti', 4),
('Casque audio', 'Casque antibruit Bose', 6),
('Tablette graphique', 'Wacom Intuos Pro', 2),
('Imprimante 3D', 'Creality Ender 3', 1),
('Clé USB', 'Clé USB 64 Go', 10),
('Routeur Wi-Fi', 'Routeur TP-Link AC1200', 2),
('Arduino Kit', 'Kit de démarrage Arduino Uno', 7);

INSERT INTO reservation (date_debut, date_fin, id_utilisateur, id_materiel) VALUES
('2025-05-01', '2025-05-05', 1, 2),  -- Jean Dupont réserve la Caméra
('2025-05-03', '2025-05-04', 2, 1),  -- Sophie Martin réserve un PC portable
('2025-05-02', '2025-05-07', 3, 4),  -- Paul Durand réserve un Micro
('2025-05-10', '2025-05-12', 4, 7),  -- Claire Leroy réserve une imprimante 3D
('2025-05-15', '2025-05-16', 5, 3);  -- Lucas Moreau réserve un projecteur
