1:
CREATE TABLE Disponibilites(
   id_disponibilite SERIAL,
   date_debut TIMESTAMP NOT NULL,
   date_fin TIMESTAMP NOT NULL,
   id_materiel INTEGER NOT NULL,
   PRIMARY KEY(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(materialid)
);

2-3:
ALTER TABLE reservations
ADD COLUMN id_disponibilite INTEGER,
ADD CONSTRAINT fk_disponibilite
    FOREIGN KEY (id_disponibilite) REFERENCES disponibilites(id_disponibilite);

4:
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

CREATE OR REPLACE FUNCTION supprimer_disponibilite(
    p_id_disponibilite INTEGER
) RETURNS VOID AS $$
BEGIN
    DELETE FROM disponibilites
    WHERE id_disponibilite = p_id_disponibilite;
END;
$$ LANGUAGE plpgsql;


SELECT ajouter_disponibilite(1, '2025-06-01 08:00:00', '2025-06-10 18:00:00');


SELECT modifier_disponibilite(5, '2025-06-02 09:00:00', '2025-06-11 17:00:00');


SELECT supprimer_disponibilite(5);

8:
SELECT 
    m.id_materiel,
    m.nom_materiel,
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM disponibilites d
            WHERE d.id_materiel = m.id_materiel
              AND '2025-06-02 09:00:00' >= d.date_debut -- Date début ici
              AND '2025-06-09 09:00:00' <= d.date_fin -- Date fin ici
              AND NOT EXISTS (
                  SELECT 1
                  FROM reservations r
                  WHERE r.id_disponibilite = d.id_disponibilite
                    AND ('2025-06-02 09:00:00', '2025-06-09 09:00:00') OVERLAPS (r.date_debut, r.date_fin)  -- Première date = date début et Seconde date = date fin
              )
        )
        THEN 'OK'
        ELSE 'KO'
    END AS statut_disponibilite
FROM materiel m
WHERE m.id_materiel = 1; -- Id matériel ici



