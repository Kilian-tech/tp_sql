1:
SELECT COUNT(*) FROM reservations
WHERE date_debut BETWEEN '2025-05-21' AND '2025-05-23 23:59:59';


2:
SELECT COUNT(DISTINCT id_etudiant) FROM reservations;