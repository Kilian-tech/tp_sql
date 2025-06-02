1:
UPDATE materiel
SET quantite_disponible=15
WHERE id_materiel=2;

2:
UPDATE materiel
SET quantite_disponible = quantite_disponible - 1
FROM reservations
WHERE materiel.id_materiel = reservations.id_materiel
AND CURRENT_DATE >= reservations.date_debut
-- Date de début est inférieur ou égale à la date du jour
AND CURRENT_DATE <= reservations.date_fin
-- Valide que le matériel est toujours en cours d'emprunt
AND reservations.date_fin > CURRENT_DATE + INTERVAL '2 days';
-- Date de fin est supérieur ou égale à date du jour + 2 jours
