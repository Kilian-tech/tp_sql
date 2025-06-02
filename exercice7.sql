1:
SELECT * FROM utilisateur as u
INNER JOIN reservation as r ON u.userid=r.userid;

2:
SELECT * FROM materiel 
WHERE materialid NOT IN (
    SELECT materialid FROM reservation
);

3:
SELECT 
    m.materialid, 
    m.nom, 
    COUNT(r.materialid) AS nombre_emprunts
FROM materiel as m
INNER JOIN reservation as r ON m.materialid = r.materialid
GROUP BY m.materialid, m.nom
HAVING COUNT(r.materialid) > 3;

4:
SELECT 
    u.userid,
    u.nom,
    u.prenom,
    u.numetudiant,
    COUNT(r.reservationid) AS nombre_emprunts
FROM utilisateur as u
LEFT JOIN reservation r ON u.userid = r.userid
GROUP BY u.userid, u.nom, u.prenom, u.numetudiant
ORDER BY u.numetudiant;