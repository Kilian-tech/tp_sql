SELECT * 
FROM utilisateurs 
WHERE prenom LIKE 'J%';

SELECT * 
FROM Materiel 
WHERE quantite_disponible <= 3;

SELECT * 
FROM Reservation 
WHERE date_debut > '2025-05-05';