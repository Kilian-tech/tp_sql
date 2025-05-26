SELECT 
    m.nom AS nom_materiel,
    m.description,
    r.date_debut,
    r.date_fin
FROM Reservation r
JOIN Materiel m ON r.id_materiel = m.id_materiel
WHERE r.id_utilisateur = 1;

SELECT 
    m.nom AS nom_materiel,
    m.description,
    r.date_debut,
    r.date_fin
FROM Reservation r
JOIN Materiel m ON r.id_materiel = m.id_materiel
WHERE r.id_utilisateur = 1;