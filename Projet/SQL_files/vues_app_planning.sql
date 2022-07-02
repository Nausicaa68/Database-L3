-- ------------------------------------------------------------- --
--   Nom de la base de donnees : App_planning_dumas_grelaud 	 --
--   SGBD : MySql                                  				 --
--   Date de creation : 13/10/2021                  	 		 --
--   Auteurs : Guillaume DUMAS / Jérémy GRELAUD     	 		 --
--    					    Vues			    	 			 --
-- ------------------------------------------------------------- --

-- 1. Créer une vue appelée « ambition » qui permet de lister tous les objectifs définis pendant l’année dernière, et la cagnotte rassemblée pour chaque objectif.

CREATE VIEW ambition AS
SELECT nom_objectif, description, cagnotte.idCagnotte, date_creation_objectif, nom, total as fonds_de_la_cagnotte
FROM objectif JOIN cagnotte 
ON objectif.idCagnotte = cagnotte.idCagnotte
WHERE YEAR(date_creation_objectif) = YEAR(now())-1 AND objectif.idUtilisateur = 1;


-- 2. Créer une vue appelée « top_organisateurs » qui affiche les deux amis qui ont organisé le plus d’évènements jusque-là.
-- les 2 top organisateur parmi les amis de user1

CREATE VIEW top_organisateurs AS
SELECT nom, prenom, COUNT( * ) as nbr_events_organisés 
FROM evenement JOIN personne 
ON evenement.idUtilisateur=personne.idPersonne
WHERE evenement.idUtilisateur IN (
							SELECT personne.idPersonne
							FROM amitie JOIN personne ON personne.idPersonne=amitie.idPersonne
							WHERE idUtilisateur=1
                            )
GROUP BY evenement.nom_orga ORDER BY nbr_events_organisés DESC LIMIT 0, 2;


-- 3. Créer une vue appelée « aujourd’hui », qui donne la liste des évènements et révisions prévues pour aujourd’hui dans le calendrier, classées par horaire.

CREATE VIEW aujourd_hui AS
SELECT DISTINCT nom_event, date_event as dates_revisions_du_jour
FROM calendrier JOIN evenement JOIN dates_event 
ON evenement.idEvenement = calendrier.idEvenement AND dates_event.id_date=evenement.id_date AND calendrier.idUtilisateur = 1
WHERE DATE(date_event) = DATE(now())
ORDER BY TIME(date_event) ASC;


-- 4. Créer une vue appelée « trouble_fête », qui donne le nom de l’ami qui refuse le plus de dates proposées pour des évènements.
-- on regarde parmi tous les amis d user1 lequel refuse le plus de dates. On le fais pour un user en particulier ici user1

CREATE VIEW trouble_fete AS
SELECT amitie.idPersonne, nom, prenom, count(*) as nbr_de_dates_refusées
FROM valider JOIN amitie JOIN personne 
ON amitie.id_amitie = valider.id_amitie AND personne.idPersonne = amitie.idPersonne
WHERE Validation = 0 AND idUtilisateur=1
GROUP BY amitie.idPersonne ORDER BY nbr_de_dates_refusées DESC LIMIT 0, 1;


-- 5. Créer une vue appelée « meilleur_réseau », qui donne le réseau social où sont actifs le plus grand nombre d’amis.
-- On regarde les amis de user1 seulement

CREATE VIEW meilleur_reseau AS
SELECT nom_reseau, count(*) as nbr_amis_actifs
FROM amitie JOIN personne JOIN comptes_reseaux_sociaux 
ON personne.idPersonne=amitie.idPersonne AND comptes_reseaux_sociaux.idPersonne = personne.idPersonne
WHERE idUtilisateur=1
GROUP BY nom_reseau ORDER BY nbr_amis_actifs DESC LIMIT 0, 1;


-- 6. Créer une vue appelée « rêve » qui donne la liste des objectifs dont le montant dépasse de 4 fois toutes les cagnottes annuelles rassemblées jusque-là. 

CREATE VIEW reve AS
SELECT objectif.idUtilisateur,nom_objectif, somme_cible
FROM objectif JOIN cagnotte 
ON objectif.idUtilisateur = cagnotte.idUtilisateur
WHERE objectif.idUtilisateur = 2
HAVING somme_cible >= 4*MAX(total);


-- 7. Créer une vue appelée « horaire_a_eviter » qui donne l’horaire de début le plus refusé parmi tous les horaires proposés.

CREATE VIEW horaire_a_eviter AS
SELECT COUNT(*) as nbr_refus, TIME(date_event) as horaire
FROM dates_event JOIN valider 
ON dates_event.id_date = valider.id_date
WHERE validation = 0
GROUP BY TIME(date_event) ORDER BY nbr_refus DESC LIMIT 0, 1;


-- 8. Créer une vue appelée « potentiels_amis » qui donne les deux camarades avec lesquels tu révises le plus. et qui ne sont pas déjà tes amis
-- toutes les personnes participant aux seances de revision avec user 1
-- on considère que si une séance de révision a été créée par user1, il y sera présent même s'il n'est pas marqué dans la table des participant

CREATE VIEW potentiels_amis AS
SELECT count(*) as nbr_de_fois_revision_ensemble, nom, prenom
FROM participer JOIN personne 
ON participer.idPersonne = personne.idPersonne
WHERE (
       participer.idEvenement IN (
								SELECT idEvenement -- toutes les seances de revisions créés par user1
								FROM seance_revision 
								WHERE idUtilisateur = 1
                                ) 
       OR participer.idEvenement IN (
								SELECT idEvenement -- toutes les seances de revisions auxquelles user1 a participé
								FROM  participer
								WHERE idPersonne = 1 AND idEvenement IN (SELECT idEvenement FROM seance_revision) 
                                )
)
AND personne.idPersonne != 1  -- on ne veut pas considérer l'utilisateur qui revise avec lui même
AND personne.idPersonne NOT IN (
							SELECT personne.idPersonne -- on ne considère pas non plus les personnes déjà amis avec user1 
							FROM personne JOIN amitie 
                            ON amitie.idPersonne = personne.idPersonne
                            WHERE  idUtilisateur=1)
GROUP BY personne.idPersonne 
ORDER BY nbr_de_fois_revision_ensemble DESC LIMIT 0, 2; 

Commit ; 