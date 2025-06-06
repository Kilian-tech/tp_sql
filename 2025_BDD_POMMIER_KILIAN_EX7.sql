1:
-- Cette requête effectue une jointure entre les utilisateurs et leurs réservations.
-- Elle permet d’avoir une vue complète de qui a réservé quoi.
SELECT * FROM utilisateurs as u
INNER JOIN reservations as r ON u.id_etudiant=r.id_etudiant;

2:
-- Cette requête sélectionne tous les matériels dont l’identifiant n’apparaît dans aucune réservation.
-- Elle permet d’identifier les équipements inutilisés ou rarement utilisés.
SELECT * FROM materiel 
WHERE id_materiel NOT IN (
    SELECT id_materiel FROM reservations
);

3:
-- Cette requête compte le nombre de réservations par matériel et filtre ceux avec plus de 3 emprunts.
-- Elle est utile pour détecter les matériels très demandés.
SELECT 
    m.id_materiel, 
    m.nom_materiel, 
    COUNT(r.id_materiel) AS nombre_emprunts
FROM materiel as m
INNER JOIN reservations as r ON m.id_materiel = r.id_materiel
GROUP BY m.id_materiel, m.nom_materiel
HAVING COUNT(r.id_materiel) > 3;

4:
-- Cette requête utilise une jointure `LEFT JOIN` pour inclure tous les utilisateurs, même ceux sans réservation.
-- Elle permet de connaître le nombre total d’emprunts effectués par chaque utilisateur.
SELECT 
    u.id_etudiant,
    u.nom,
    u.prenom,
    u.numero_etudiant,
    COUNT(r.id_reservation) AS nombre_emprunts
FROM utilisateurs as u
LEFT JOIN reservations r ON u.id_etudiant = r.id_etudiant
GROUP BY u.id_etudiant, u.nom, u.prenom, u.numero_etudiant
ORDER BY u.numero_etudiant;