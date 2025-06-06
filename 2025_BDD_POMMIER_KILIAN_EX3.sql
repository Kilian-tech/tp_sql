1:
-- Récupère les noms et prénoms de tous les utilisateurs ayant effectué une réservation.
-- La jointure se fait via l’identifiant de l’utilisateur (`id_etudiant`).
SELECT (nom, prenom) FROM utilisateurs
INNER JOIN reservations ON utilisateurs.id_etudiant=reservations.id_etudiant;

2:
-- Récupère les noms des matériels réservés par l’utilisatrice Alice Dupont.
-- Triple jointure entre les tables : `materiel`, `reservations`, `utilisateurs`.
-- On filtre sur le nom et prénom de l'utilisateur.
SELECT nom_materiel FROM materiel AS m 
INNER JOIN reservations AS r ON m.id_materiel=r.id_materiel
INNER JOIN utilisateurs as u ON u.id_etudiant=r.id_etudiant
WHERE u.nom='Dupont' AND u.prenom='Alice';