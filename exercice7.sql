1:
SELECT * FROM utilisateurs as u
INNER JOIN reservations as r ON u.id_etudiant=r.id_etudiant;

2:
SELECT * FROM materiel 
WHERE id_materiel NOT IN (
    SELECT id_materiel FROM reservations
);

3:
SELECT 
    m.id_materiel, 
    m.nom_materiel, 
    COUNT(r.id_materiel) AS nombre_emprunts
FROM materiel as m
INNER JOIN reservations as r ON m.id_materiel = r.id_materiel
GROUP BY m.id_materiel, m.nom_materiel
HAVING COUNT(r.id_materiel) > 3;

4:
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