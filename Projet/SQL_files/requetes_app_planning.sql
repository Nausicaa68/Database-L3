-- ------------------------------------------------------------- --
--   Nom de la base de donnees : App_planning_dumas_grelaud 	 --
--   SGBD : MySql                                  				 --
--   Date de creation : 13/10/2021                  	 		 --
--   Auteurs : Guillaume DUMAS / Jérémy GRELAUD     	 		 --
--    					Requêtes			    	 			 --
-- ------------------------------------------------------------- --


-- 1. Afficher toutes les informations relatives au dernier évènement qui a bien eu lieu : nom, date, nom de l’organisateur, liste des participants, endroit, dépenses

select nom_event, date_event, nom_orga, cout_event, num_rue, nom_rue, ville
from evenement join dates_event join adresse
on evenement.id_date = dates_event.id_date and evenement.id_adresse = adresse.id_adresse
where date_event = (
				select max(date_event) from dates_event where date_event < now()
				) 
and annule = 0;


-- 2. Donner la liste des amis qui partagent avec vous le même loisir (donné en paramètre).

select distinct amitie.idUtilisateur, nom, prenom
from amitie join loisir_commun join personne
on amitie.id_amitie = loisir_commun.id_amitie and personne.idPersonne = amitie.idPersonne
where amitie.id_amitie in (
						Select id_amitie
						from loisir_commun 
						where Nom_loisir = "Maquettes militaires" AND idUtilisateur = 2
                        );


-- 3. Donner le nombre de séances de révision organisées pendant le mois dernier.

select count(*) as nbr_seances_revision_du_mois_dernier
from seance_revision join evenement join dates_event
on seance_revision.idEvenement = evenement.idEvenement and evenement.id_date = dates_event.id_date
where month(date_event) = month(now()) - 1;

-- Les infos des séances de révisions du mois dernier
select matiere, travail_a_faire, date_event
from seance_revision join evenement join dates_event
on seance_revision.idEvenement = evenement.idEvenement
and evenement.id_date = dates_event.id_date
where month(date_event) = month(now()) - 1;


-- 4. Donner la liste des camarades de classe qui ne sont pas considérés comme amis.

select nom, prenom, ville_residence, telephone 
from personne join camaraderie
on personne.idPersonne = camaraderie.idPersonne
where personne.idPersonne not in (
							select personne.idPersonne
							from personne join amitie
							on personne.idPersonne = amitie.idPersonne
							where idUtilisateur = 1
							)
and idUtilisateur = 1;

-- 5. Donner la liste des amis qui habitent la même ville où aura lieu un évènement donné en paramètre

select idUtilisateur, nom, prenom, ville_residence, telephone 
from personne join amitie
on personne.idPersonne = amitie.idPersonne
where idUtilisateur = 2 and ville_residence in (
											select ville 
                                            from evenement join adresse
											on evenement.id_adresse = adresse.id_adresse
											where nom_event = "road trip en coree"
                                            );
                                                

-- 6. Donner la liste des adresses favorites qui n’ont jamais hébergé d’évènements jusque-là.

select distinct num_rue, nom_rue, codepostal, ville 
from adresse_favorites join adresse
on adresse_favorites.id_adresse = adresse.id_adresse
where adresse_favorites.id_adresse not in (
										select evenement.id_adresse
										from evenement join dates_event join adresse 
										on evenement.id_date = dates_event.id_date and evenement.id_adresse = adresse.id_adresse
										where date_event <= now()
										and annule = 0 
										);


-- 7. Afficher la liste des dépenses ainsi que des rentrées d’argent du mois en cours.

select SUM(rentree_d_argent) as rentree_argents_mois , SUM(depenses_du_mois) as depenses_mois
from budget_utilisateur
where idUtilisateur = 2;

-- somme des couts des events du mois les coûts des events du mois sont considérés déjà compris dans le budget de l'utilisateur du mois

select SUM(cout_event) as couts_events_du_mois
from evenement join dates_event
on evenement.id_date = dates_event.id_date
where evenement.idUtilisateur = 2 and month(date_event) = month(now());


-- 8. Donner le taux d’acceptation des évènements (nombre d’évènements validés sur le nombre total d’évènements proposés) pour chaque organisateur.

-- Si l'utilisateur en question n'a organisé aucun évènement le taux d'acception sera : NULL
select distinct (
			select count(*) 
            from evenement 
            where annule=0 and idUtilisateur=2
			group by idUtilisateur
            ) / (
            Select count(*) 
            from evenement 
            where idUtilisateur = 2
			group by idUtilisateur
            ) * 100 as Taux_d_acceptation_events_organisés_par_user2
from evenement;

