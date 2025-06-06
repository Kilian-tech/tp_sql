1:
-- Cette requête permet de compter toutes les réservations dont la date de début est comprise entre le 21 mai 2025 et le 23 mai 2025 à 23h59.
-- Cela sert à analyser le nombre d'emprunts lancés pendant une période précise.
SELECT COUNT(*) FROM reservations
WHERE date_debut BETWEEN '2025-05-21' AND '2025-05-23 23:59:59';

2:
-- Grâce à COUNT(DISTINCT), on ne compte qu’une seule fois chaque étudiant, même s’il a réservé plusieurs fois. Cela donne une idée du nombre d’utilisateurs actifs.
SELECT COUNT(DISTINCT id_etudiant) FROM reservations;