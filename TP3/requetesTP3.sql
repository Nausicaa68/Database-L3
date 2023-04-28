
-- ----------------------------------------------
-- Nom de la base de donnees : ecole           --
-- Auteur des requêtes : Nausicaa              --
-- ----------------------------------------------

-- 1. Créer la vue Eleves_ValDeMarne renfermant tous les champs des élèves du Val de Marne (Département 94) -- 
create view Eleves_ValDeMarne as
select * from eleves
where CodePostal like "94%";

-- 2. Est-il possible de mettre à jour l’adresse de l’élève Buck DANNY qui déménage de 94800 Villejuif à 75013 PARIS depuis la vue Eleves_ValDeMarne ? Pourquoi ? Vérifier ? --
update Eleves_ValDeMarne 
set CodePostal = '75013', Ville = 'Paris'   
where NOM = 'Danny' and PRENOM = 'Buck';  

-- 3. Est-il possible de supprimer depuis la vue Eleves_ValDeMarne l’élève Gil JOURDAN habitant à 93800 EPINAY SUR SEINE qui a quitté l’école ? Pourquoi ? Vérifier ? --
delete from Eleves_ValDeMarne
where CodePostal = '93800' and NOM = 'Jourdan' and PRENOM = 'Gil';

-- 4. Peut-on ajouter un nouvel élève arrivant à l’école et venant de 94000 CRETEIL puis un autre élève venant de 91000 EVRY depuis la vue Eleves_ValDeMarne ? Pourquoi ? Vérifier ? --
insert into Eleves_ValDeMarne (NUM_ELEVE, NOM, PRENOM, DATE_NAISSANCE, Poids, ANNEE, SEXE, CodePostal, Ville)   
values 
(11, 'kazenotani', 'Nausicaa', '1984-03-11', 45, 1, 'f', '94000', 'CRETEIL'),
(12, 'Kujo', 'Jotaro', '2001-10-05', 100, 1, 'm', '91000', 'EVRY');

-- 5. En utilisant la vue Eleves_ValDeMarne, donner les noms et prénoms des élèves du Val de Marne qui pratiquent du Tennis et qui ont une moyenne générale supérieure à 10. --
select Eleves_ValDeMarne.NOM, Eleves_ValDeMarne.PRENOM
from Eleves_ValDeMarne join resultats join activites_pratiquees 
on Eleves_ValDeMarne.NUM_ELEVE = resultats.NUM_ELEVE and Eleves_ValDeMarne.NUM_ELEVE = activites_pratiquees.NUM_ELEVE
where activites_pratiquees.NOM = 'Tennis'
group by Eleves_ValDeMarne.NUM_ELEVE 
having avg(resultats.POINTS) > 9;

-- 6. Créer l’utilisateur User1 de mot passe 123 et lui donner un droit de consultation sur la table Eleves. --
create user 'User1'@'localhost' identified by '123';
grant select on Eleves to 'User1'@'localhost' with grant option;

-- 7. Tester s’il arrive bien à consulter le contenu de la table Eleves ? --
select user from mysql.user;
show grants for 'User1'@'localhost';

-- 8. Que faut-il faire pour que user1 puisse consulter toutes les tables de la base de données école ? --
grant select on ecole.* TO 'User1'@'localhost' with grant option;

-- 9. Le propriétaire de la base de données ecole est root. Il décide d’insérer un nouvel élève DUPONT Fantome né 12 avril 2001, de poids 60 kgs, de sexe masculin, qui est en 1ere année et qui vient de Villejuif 94800. Insérer ce nouvel élève et faire le nécessaire pour que User1 puisse le voir. --
insert into Eleves_ValDeMarne (NUM_ELEVE, NOM, PRENOM, DATE_NAISSANCE, Poids, ANNEE, SEXE, CodePostal, Ville)   
value
(13, 'DUPONT', 'Fantome', '2001-04-12', 60, 1, 'm', '94800', 'Villejuif');

-- 10. On souhaite donner tous les droits nécessaires à User1 pour gérer tous nos élèves du Val de Marne (Tous les élèves dont le code postal commence par 94). Donner les commandes nécessaires pour qu’il ait ces privilèges. Tester ces privilèges en choisissant des exemples adéquats. --
grant all privileges on Eleves_ValDeMarne to 'User1'@'localhost' with grant option;


