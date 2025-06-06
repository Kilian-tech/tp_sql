1:
ALTER TABLE disponibilites DROP CONSTRAINT IF EXISTS disponibilite_id_materiel_fkey;
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS fk_disponibilite;
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS reservation_id_etudiant_fkey;
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS reservations_pkey;

-- Réinitialisation complète des données
TRUNCATE TABLE reservations RESTART IDENTITY CASCADE;
TRUNCATE TABLE disponibilites RESTART IDENTITY CASCADE;
TRUNCATE TABLE materiel RESTART IDENTITY CASCADE;
TRUNCATE TABLE utilisateurs RESTART IDENTITY CASCADE;

-- Insérer 100 000 utilisateurs
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO utilisateurs (id_etudiant, nom, prenom, email, numero_etudiant)
        VALUES (
            i,
            'nom_' || i,
            'prenom_' || i,
            'user_' || i || '@example.com',
            LPAD(i::TEXT, 6, '0')
        );
    END LOOP;
END $$;

-- Insérer 100 000 matériels
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO materiel (id_materiel, nom, description, quantite_disponible)
        VALUES (
            i,
            'materiel_' || i,
            'description for materiel_' || i,
            (random() * 20)::INT + 1
        );
    END LOOP;
END $$;

-- Insérer 200 000 disponibilités
DO $$
DECLARE
    i INT;
    date_debut DATE;
    date_fin DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        date_debut := DATE '2025-01-01' + (random() * 365)::INT;
        date_fin := date_debut + (random() * 30)::INT;

        INSERT INTO disponibilites (id_disponibilite, id_materiel, date_debut, date_fin)
        VALUES (
            i,
            (random() * 99999)::INT + 1,
            date_debut,
            date_fin
        );
    END LOOP;
END $$;

-- Insérer 200 000 réservations
DO $$
DECLARE
    i INT;
    date_debut DATE;
    date_fin DATE;
    date_retour_effectif DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        date_debut := DATE '2025-01-01' + (random() * 365)::INT;
        date_fin := date_debut + (random() * 15)::INT;
        date_retour_effectif := date_debut + (random() * 15)::INT;

        INSERT INTO reservations (
            id_reservation, date_debut, date_fin,
            numero_etudiant, id_materiel,
            id_disponibilite, date_retour_effectif
        )
        VALUES (
            i,
            date_debut,
            date_fin,
            (random() * 99999)::INT + 1,
            (random() * 99999)::INT + 1,
            (random() * 199999)::INT + 1,
            date_retour_effectif
        );
    END LOOP;
END $$;

5:
-- Cette requête affiche les réservations prévues à partir du 1er juin 2025
-- Jointure entre les tables materiel, reservations, utilisateurs et disponibilites
-- Permet de visualiser le matériel réservé, l'étudiant concerné et les périodes disponibles
SELECT 
    r.id_reservation,
    u.nom,
    u.prenom,
    m.nom_materiel,
    d.date_debut AS date_disponibilite,
    d.date_fin AS fin_disponibilite,
    r.date_debut AS date_reservation,
    r.date_fin AS fin_reservation
FROM reservations r
JOIN utilisateurs u ON u.id_etudiant = r.id_etudiant
JOIN materiel m ON m.id_materiel = r.id_materiel
JOIN disponibilites d ON d.id_disponibilite = r.id_disponibilite
WHERE r.date_debut >= '2025-06-01'
ORDER BY r.date_debut;

6:
EXPLAIN ANALYZE
SELECT 
    r.id_reservation,
    u.nom,
    u.prenom,
    m.nom_materiel,
    d.date_debut AS date_disponibilite,
    d.date_fin AS fin_disponibilite,
    r.date_debut AS date_reservation,
    r.date_fin AS fin_reservation
FROM reservations r
JOIN utilisateurs u ON u.id_etudiant = r.id_etudiant
JOIN materiel m ON m.id_materiel = r.id_materiel
JOIN disponibilites d ON d.id_disponibilite = r.id_disponibilite
WHERE r.date_debut >= '2025-06-01'
ORDER BY r.date_debut;

7:
CREATE INDEX idx_reservations_id_etudiant
ON reservations(id_etudiant);

CREATE INDEX idx_reservations_id_materiel
ON reservations(id_materiel);

CREATE INDEX idx_reservations_id_disponibilite
ON reservations(id_disponibilite);

CREATE INDEX idx_disponibilites_id_materiel
ON disponibilites(id_materiel);

9:
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX idx_utilisateurs_nom_trgm 
ON utilisateurs USING gin (nom gin_trgm_ops);

EXPLAIN ANALYZE
SELECT * 
FROM utilisateurs 
WHERE nom LIKE '%nt%';

