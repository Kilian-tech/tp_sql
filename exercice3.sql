1:
SELECT (nom, prenom) FROM utilisateurs
INNER JOIN reservations ON utilisateurs.id_etudiant=reservations.id_etudiant;

2:
SELECT nom_materiel FROM materiel AS m 
INNER JOIN reservations AS r ON m.id_materiel=r.id_materiel
INNER JOIN utilisateurs as u ON u.id_etudiant=r.id_etudiant
WHERE u.nom='Dupont' AND u.prenom='Alice';