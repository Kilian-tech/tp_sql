1:
-- Cette table lie une période de disponibilité à un matériel donné.
CREATE TABLE Disponibilites(
   id_disponibilite SERIAL,
   date_debut TIMESTAMP NOT NULL,
   date_fin TIMESTAMP NOT NULL,
   id_materiel INTEGER NOT NULL,
   PRIMARY KEY(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(materialid)
);

2-3:
-- On relie chaque réservation à une période de disponibilité bien précise.
ALTER TABLE reservations
ADD COLUMN id_disponibilite INTEGER,
ADD CONSTRAINT fk_disponibilite
    FOREIGN KEY (id_disponibilite) REFERENCES disponibilites(id_disponibilite);

4:
-- Si une disponibilité existe pour cette période et qu’elle n’est pas déjà réservée, le statut sera 'OK'.
SELECT 
    m.id_materiel,
    m.nom_materiel,
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM disponibilites d
            WHERE d.id_materiel = m.id_materiel
              AND '2025-05-20 09:00:00' >= d.date_debut 
              AND '2025-05-25 09:00:00' <= d.date_fin 
              AND NOT EXISTS (
                  SELECT 1
                  FROM reservations r
                  WHERE r.id_disponibilite = d.id_disponibilite
                    AND ('2025-05-20 09:00:00', '2025-05-25 09:00:00') OVERLAPS (r.date_debut, r.date_fin)
              )
        )
        THEN 'OK'
        ELSE 'KO'
    END AS statut_disponibilite
FROM materiel m
WHERE m.id_materiel = 9; 

5:
--  Fonction PL/pgSQL pour ajouter une nouvelle disponibilité
CREATE OR REPLACE FUNCTION ajouter_disponibilite(
    p_id_materiel INTEGER,
    p_date_debut TIMESTAMP,
    p_date_fin TIMESTAMP
) RETURNS VOID AS $$
BEGIN
    INSERT INTO disponibilites (id_materiel, date_debut, date_fin)
    VALUES (p_id_materiel, p_date_debut, p_date_fin);
END;
$$ LANGUAGE plpgsql;

--  Fonction pour modifier une disponibilité existante
CREATE OR REPLACE FUNCTION modifier_disponibilite(
    p_id_disponibilite INTEGER,
    p_date_debut TIMESTAMP,
    p_date_fin TIMESTAMP
) RETURNS VOID AS $$
BEGIN
    UPDATE disponibilites
    SET date_debut = p_date_debut,
        date_fin = p_date_fin
    WHERE id_disponibilite = p_id_disponibilite;
END;
$$ LANGUAGE plpgsql;

--  Fonction pour supprimer une disponibilité
CREATE OR REPLACE FUNCTION supprimer_disponibilite(
    p_id_disponibilite INTEGER
) RETURNS VOID AS $$
BEGIN
    DELETE FROM disponibilites
    WHERE id_disponibilite = p_id_disponibilite;
END;
$$ LANGUAGE plpgsql;

6:
SELECT ajouter_disponibilite(1, '2025-06-01 08:00:00', '2025-06-10 18:00:00');


SELECT modifier_disponibilite(5, '2025-06-02 09:00:00', '2025-06-11 17:00:00');


SELECT supprimer_disponibilite(5);

-- Vérification de la disponibilité du matériel (ex : id 1) pour une autre période
-- Si la période est libre et couvre la demande sans chevauchement de réservation, statut = 'OK'.
SELECT 
    m.id_materiel,
    m.nom_materiel,
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM disponibilites d
            WHERE d.id_materiel = m.id_materiel
              AND '2025-06-02 09:00:00' >= d.date_debut 
              AND '2025-06-09 09:00:00' <= d.date_fin 
              AND NOT EXISTS (
                  SELECT 1
                  FROM reservations r
                  WHERE r.id_disponibilite = d.id_disponibilite
                    AND ('2025-06-02 09:00:00', '2025-06-09 09:00:00') OVERLAPS (r.date_debut, r.date_fin) 
              )
        )
        THEN 'OK'
        ELSE 'KO'
    END AS statut_disponibilite
FROM materiel m
WHERE m.id_materiel = 1; 



