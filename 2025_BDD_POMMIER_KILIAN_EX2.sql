1:
-- Sélectionne tous les utilisateurs dont le prénom commence par la lettre 'J'.
-- L’opérateur `LIKE 'J%'` permet d’effectuer une recherche textuelle partielle sur le prénom.
SELECT * 
FROM utilisateurs 
WHERE prenom LIKE 'J%';

2:
-- Affiche les matériels dont la quantité disponible est inférieure ou égale à 3.
-- Cela permet d’identifier rapidement les équipements à réapprovisionner.
SELECT * 
FROM materiel 
WHERE quantite_disponible <= 3;

3:
-- Récupère toutes les réservations dont la date de début est postérieure au 5 mai 2025.
-- Permet d’afficher les réservations à venir.
SELECT * 
FROM reservations 
WHERE date_debut > '2025-05-05';