
-- ----------------------------------------------
-- Nom de la base de donnees : ecole           --
-- Auteur des requêtes : Nausicaa              --
-- ----------------------------------------------



-- create user 'User1'@'localhost' identified by '123';
-- grant select on Eleves to 'User1'@'localhost' with grant option;

	-- Commit et rollback --
start transaction;
insert into agglomerations (CP, ville, classement) value (68000, "Colmar", "GRANDE-VILLE");
insert into eleves (num_eleve, nom, prenom, date_naissance, poids, annee, sexe, codepostal, ville)
value (14, "Dumas", "Guillaume", "2001-01-01", 70, 1, "m", "68000", "Colmar");

select * from eleves;
commit;
select * from eleves;
-- on observe que rollback annule les requetes précedemment exécutée depuis le début de la transaction

	-- Transaction et remise sur panne --
start transaction;
insert into eleves (num_eleve, nom, prenom, date_naissance, poids, annee, sexe, codepostal, ville)
value (15, "Pechey", "Romain", "2001-02-01", 70, 1, "m", "68000", "Colmar");

-- En fermant puis rouvrant l'onglet de connexion, on constate que les données ne sont pas sauvegardées dans les tables 
-- En arrêtant brusquement le programme, on constate que les données ne sont pas sauvegardées non plus

	-- Niveau d'isolation des transactions --
show variables like "%isolation%";

start transaction;
delete from eleves where NUM_ELEVE = 13;
insert into agglomerations (CP, ville, classement) value (78000, "Arrakis", "METROPOLE");
insert into eleves (num_eleve, nom, prenom, date_naissance, poids, annee, sexe, codepostal, ville)
value (13, "Atréides", "Paul", "2001-02-01", 70, 1, "m", "78000", "Arrakis");
commit;

-- ces modfications sont visibles dans l'instance où l'on a réalisé la transaction, mais pas dans une autre instance. 

	-- Niveau d'isolation --
set transaction isolation level read uncommitted;

start transaction;
insert into eleves (num_eleve, nom, prenom, date_naissance, poids, annee, sexe, codepostal, ville)
value (15, "Atréides", "Leto", "1960-02-01", 70, 1, "m", "78000", "Arrakis");
select * from eleves;

-- read uncommitted spécifie que les instructions peuvent lire des lignes qui ont été modifiées
-- par d'autres transactions, mais pas encore validées. En allant select la table élève dans une autre instance,
-- on peut voir le nouveau tuple Leto Atréides bien que la transaction ci-dessus ne soit pas commit.

delete from eleves where NUM_ELEVE = 15;

set transaction isolation level serializable;

start transaction;
insert into eleves (num_eleve, nom, prenom, date_naissance, poids, annee, sexe, codepostal, ville)
value (15, "Atréides", "Leto", "1960-02-01", 70, 1, "m", "78000", "Arrakis");
select * from eleves;

-- serializable spécifie les instructions ne peuvent pas lire des données qui ont été modifiées 
-- mais pas encore validées par d'autres transactions. En allant dans une autre instance, on ne voit pas le tuple nouvellement créé.


