
-- ----------------------------------------------
-- Nom de la base de donnees : cinema          --
-- Auteur des requêtes : Nausicaa              --
-- ----------------------------------------------


		-- EXERCICE 1 --

-- 1. Les titres des films triés par ordre croissant. --
select Titre from film
order by Titre ASC;

-- 2. Nom et année de naissance des artistes nés avant 1950. --
select Nom, annee_naissance from artiste
where annee_naissance < 1950;

-- 3. Les cinémas du 12ème arrondissement. --
select * from cinema
where Arrondissement = 12;

-- 4. Les artistes dont le nom commence par 'H' (commande LIKE). --
select * from artiste
where Nom like 'H%';

-- 5. Quels sont les acteurs dont on ignore la date de naissance ? (Attention : cela signifie que la valeur n'existe pas). --
select * from artiste
where Annee_naissance is NULL;

-- 6. Combien de fois Bruce Willis a-t-il joué le rôle de McLane ? --
select count(*) as nb_willlis_as_McLane from role
where Nom_Role = "McLane" and Nom_acteur = "Willis";

		-- EXERCICE 2 --

-- 1. Qui a joué Tarzan (nom et prénom) ? --
select Nom_acteur from role
where Nom_Role = "Tarzan";

-- 2. Nom des acteurs de Vertigo. --
select artiste.Nom from artiste join role join film on artiste.Nom = role.Nom_acteur and role.ID_film = film.ID_film
where film.Titre = "Vertigo";

-- 3. Quels films peut-on voir au Rex, et à quelle heure ? --
select distinct seance.Heure_debut, film.Titre from seance join film on film.ID_film = seance.ID_film
where seance.Nom_cinema = "Rex";

-- 4. Titre des films dans lesquels a joué Woody Allen. Donner aussi le rôle. --
select role.Nom_Role, film.Titre 
from role join film join artiste on film.ID_film = role.ID_film and role.Nom_acteur = artiste.Nom
where artiste.Nom = "Allen" and artiste.Prenom = "Woody";

-- 5. Quel metteur en scène a tourné dans ses propres films ? Donner le nom, le rôle et le titre des films. --
select role.Nom_acteur, role.Nom_Role, film.Titre
from role join film on film.ID_film = role.ID_film 
where role.Nom_acteur = film.Nom_Realisateur;

-- 6. Quel metteur en scène a tourné en tant qu'acteur ? Donner le nom, le rôle et le titre des films où le metteur en scène a joué. --
select role.Nom_acteur, role.Nom_Role, film.Titre
from role join film on film.ID_film = role.ID_film 
where role.Nom_acteur in (select film.Nom_Realisateur from film);

-- 7. Où peut-on voir Shining ? (Nom et adresse du cinéma, horaire). --
select seance.Nom_cinema, seance.Heure_debut, cinema.Adresse
from seance join cinema on seance.Nom_cinema = cinema.Nom_cinema 
where seance.ID_film = (select film.ID_film from film where Titre = "Shining");

-- 8. Dans quels films le metteur-en-scène a-t-il le même prénom que l'un des interprètes ? (titre, nom du metteur-en-scène, nom de l'interprète). Le metteur-en-scène et l'interprète ne doivent pas être la même personne. --
select distinct film.Titre, film.Nom_Realisateur, role.Nom_acteur, artiste.Prenom 
from film join role join artiste 
on film.ID_film = role.ID_film and role.Nom_acteur = artiste.Nom
where artiste.Nom != film.Nom_Realisateur and artiste.Prenom in (
																	select artiste.Prenom from artiste
                                                                    where artiste.Nom = film.Nom_Realisateur
																);


-- 9. Où peut-on voir un film avec Clint Eastwood ? (Nom et adresse du cinéma, horaire). --
Select film.Titre, cinema.Nom_cinema, seance.Heure_debut, seance.Heure_fin
from film join seance join cinema join role
on film.ID_film = seance.ID_film 
and seance.Nom_cinema = cinema.Nom_cinema 
and seance.ID_film = role.ID_film
where role.Nom_acteur = 'Eastwood';

-- 10. Quel film peut-on voir dans le 12e arrondissement, dans une salle climatisée ? (Nom du cinéma, numéro de la salle, horaire, titre du film). --
select distinct cinema.Nom_cinema, salle.No_salle, seance.Heure_debut, film.Titre
from cinema join seance join salle join film 
on cinema.Nom_cinema = seance.Nom_cinema 
and seance.Nom_cinema = salle.Nom_cinema
and seance.ID_film = film.ID_film
where cinema.Arrondissement = '12' and salle.Climatise = 'O'; 

-- 11. Liste des cinémas (Adresse, Arrondissement) ayant une salle de plus de 150 places et passant un film avec Bruce Willis. --
select distinct cinema.Nom_cinema, cinema.Adresse, cinema.Arrondissement, salle.Capacite
from seance join cinema join salle join role
on seance.ID_film = role.ID_film 
and seance.Nom_cinema = cinema.Nom_cinema 
and salle.Nom_cinema = cinema.Nom_cinema
and salle.No_salle = seance.No_salle
where role.Nom_acteur = 'Willis' and salle.Capacite > 150;

-- 12. Liste des cinémas (Nom, Adresse) dont TOUTES les salles ont plus de 100 places. --
Select distinct cinema.Nom_cinema, cinema.Adresse
from cinema join salle
on cinema.Nom_cinema = salle.Nom_cinema
where not exists (
					Select * from salle
					where salle.Capacite < 100 and salle.Nom_cinema = cinema.Nom_cinema
				  );
                  

		-- Exercice 3 --

-- 1. Quels acteurs n'ont jamais mis en scène de film ? --
Select artiste.Nom from artiste
where artiste.Nom not in (select film.Nom_Realisateur from film);

-- 2. Les cinémas (nom, adresse) qui ne passent pas un film de Tarantino. --
select cinema.Nom_cinema, cinema.Adresse 
from cinema
where not exists (
					Select * from seance join film on seance.ID_film = film.ID_film
                    where seance.Nom_cinema = cinema.Nom_cinema
                    and film.Nom_Realisateur = 'Tarantino'
				);
                
                
                
		-- Exercice 4 --

-- 1. Total des places dans les salles du Rex. --
select sum(salle.Capacite) from salle
where salle.Nom_cinema = 'Rex';

-- 2. Année du film le plus ancien et du film le plus récent. --
select min(film.Annee), max(film.Annee) from film;

-- 3. Total des places offertes par cinéma. --
select salle.Nom_cinema, sum(salle.Capacite) from salle
group by salle.Nom_cinema;

-- 4. Nom et prénom des réalisateurs, et nombre de films qu'ils ont tournés. --
select artiste.Nom, artiste.Prenom, count(titre) 
from artiste join film
on film.Nom_Realisateur = artiste.Nom
group by artiste.Nom;

-- 5. Nom des cinémas ayant plus de 1 salle climatisée. --
select salle.Nom_cinema, count(*) from salle
where salle.Climatise = 'O'
group by salle.Nom_cinema
having count(*) > 1;

-- 6. Les artistes (nom, prénom) ayant joué au moins dans trois films depuis 1985, dont au moins un, passe à l'affiche à Paris (donner aussi le nombre de films). --
select artiste.Prenom, artiste.Prenom, count(*)
from artiste join role join film
on artiste.Nom = role.Nom_acteur and role.ID_film = film.ID_film
where film.Annee >= 1985
group by artiste.Nom
having count(*) >= 3;


		-- Exercice 5 --

-- 1. Le nom des cinémas qui passent tous les films de Kubrick. --
select seance.Nom_cinema 
from seance join film
on seance.ID_film = film.ID_film
where film.Nom_Realisateur = 'Kubrick'
group by seance.Nom_cinema
having count(distinct seance.Nom_cinema) = (
												Select count(*) from film
                                                where film.Nom_Realisateur = 'Kubrick'
											);



