1:
-- Création de la table des retours
-- Chaque retour est lié à une réservation. La colonne "retard" indique si le retour est en retard.
CREATE TABLE RetourMateriel (
    id_retour SERIAL PRIMARY KEY,
    id_reservation INT REFERENCES Reservation(id_reservation) ON DELETE CASCADE,
    date_retour DATE NOT NULL,
    retard BOOLEAN
);

2:
-- Ajout d’une colonne dans la table Reservations
-- Cette colonne permettra de stocker la date réelle de retour.
ALTER TABLE reservations
ADD COLUMN date_retour_effectif DATE;

3:
-- Mise à jour du champ "retard" dans la table RetourMateriel
-- On compare la date de retour effective avec la date de fin prévue pour chaque réservation.
UPDATE RetourMateriel
SET retard = (
    SELECT CASE
        WHEN r.date_fin < RetourMateriel.date_retour THEN TRUE
        ELSE FALSE
    END
    FROM reservations r
    WHERE r.id_reservation = RetourMateriel.id_reservation
);

4:
-- Création d’une vue pour afficher les retards et calculer les pénalités
-- Une pénalité de 2 € est appliquée pour chaque jour de retard.
CREATE OR REPLACE VIEW RetardsEtPenalites AS
SELECT 
    u.nom,
    u.prenom,
    r.id_reservation,
    rm.date_retour,
    r.date_fin AS date_prevue,
    (rm.date_retour - r.date_fin) AS nb_jours_retard,
    CASE
        WHEN rm.date_retour > r.date_fin THEN
            (rm.date_retour - r.date_fin) * 2
        ELSE 0
    END AS penalite
FROM 
    RetourMateriel rm
JOIN 
    reservations r ON r.id_reservation = rm.id_reservation
JOIN 
    utilisateurs u ON u.numero_etudiant = r.numero_etudiant
WHERE 
    rm.date_retour > r.date_fin;

5.1:
-- Insertion d’un retour avec retard
-- Ce retour sera en retard si la date de retour est postérieure à la date de fin de réservation.
INSERT INTO RetourMateriel (id_reservation, date_retour)
VALUES (1, '2025-06-10');

5.2:
-- Insertion d’un second retour
-- Même logique : si cette date est postérieure à la date de fin, une pénalité sera calculée.
INSERT INTO RetourMateriel (id_reservation, date_retour)
VALUES (2, '2025-06-15');