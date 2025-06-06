1:
-- Cette requête force la quantité disponible du matériel ayant l’ID 2 à 15 unités.
-- Elle peut être utilisée pour corriger une erreur ou réinitialiser l’état du stock.
UPDATE materiel
SET quantite_disponible=15
WHERE id_materiel=2;

2:
-- Cette requête parcourt tous les matériels actuellement empruntés (réservations actives) et décrémente leur quantité disponible de 1 unité.
-- Le critère `date_fin > CURRENT_DATE + 2 jours` garantit que l'emprunt est encore valable.
UPDATE materiel
SET quantite_disponible = quantite_disponible - 1
FROM reservations
WHERE materiel.id_materiel = reservations.id_materiel
AND CURRENT_DATE >= reservations.date_debut
AND CURRENT_DATE <= reservations.date_fin
AND reservations.date_fin > CURRENT_DATE + INTERVAL '2 days';

