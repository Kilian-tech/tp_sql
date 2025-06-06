1:
-- Cette requête supprime la réservation ayant pour identifiant `id_reservation = 2`.
-- Elle peut être utilisée pour annuler une réservation en particulier.
DELETE FROM reservations
WHERE id_reservation=2;

2:
-- Cette requête supprime toutes les réservations dont la date de fin est déjà passée.
-- Elle permet de nettoyer la base de données des anciennes entrées devenues obsolètes.
DELETE FROM reservations
WHERE date_fin<CURRENT_DATE;