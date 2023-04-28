-- ------------------------------------------------------------- --
--   Nom de la base de donnees : App_planning_dumas_grelaud 	 --
--   SGBD : MySql                                  				 --
--   Date de creation : 13/10/2021                  	 		 --
--   Auteurs : Guillaume DUMAS / Jérémy GRELAUD     	 		 --
-- ------------------------------------------------------------- --

-- Création de la base de données --

drop database if exists App_planning_dumas_grelaud;
create database if not exists App_planning_dumas_grelaud;
use App_planning_dumas_grelaud;

-- Destruction des tables --

SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Personne ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Camaraderie ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Comptes_Reseaux_sociaux ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Utilisateur ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Amitie ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Cagnotte ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Objectif ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Anciens_objectifs ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Objectif_ultime ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Dates_event ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Loisir_commun ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Adresse_favorites ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Budget_utilisateur ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Evenement ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Calendrier ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Seance_revision ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Participer ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Valider ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Proposer ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Adresse ; SET FOREIGN_KEY_CHECKS=1;


-- Création de tables --

CREATE TABLE Dates_event(
   id_date INT,
   date_event DATETIME NOT NULL,
   accord BOOLEAN,
   PRIMARY KEY(id_date)
)Engine = 'InnoDb';

CREATE TABLE Personne(
   idPersonne INT,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   ville_residence VARCHAR(50),
   telephone VARCHAR(50),
   PRIMARY KEY(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Comptes_Reseaux_sociaux(
   id_reseau INT,
   nom_reseau VARCHAR(50) NOT NULL,
   idPersonne INT NOT NULL,
   PRIMARY KEY(id_reseau),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Adresse(
   id_adresse INT,
   num_rue INT,
   nom_rue VARCHAR(50),
   codepostal INT,
   ville VARCHAR(50),
   PRIMARY KEY(id_adresse)
)Engine = 'InnoDb';

CREATE TABLE Utilisateur(
   idUtilisateur INT,
   idPersonne INT NOT NULL,
   PRIMARY KEY(idUtilisateur),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Amitie(
   id_amitie INT,
   idUtilisateur INT NOT NULL,
   idPersonne INT NOT NULL,
   PRIMARY KEY(id_amitie),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Cagnotte(
   idCagnotte INT,
   nom VARCHAR(50) NOT NULL,
   total INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idCagnotte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Objectif(
   idObjectif INT,
   nom_objectif VARCHAR(50) NOT NULL,
   description VARCHAR(50),
   type VARCHAR(50),
   somme_cible INT,
   date_creation_objectif DATE,
   idCagnotte INT NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idObjectif),
   FOREIGN KEY(idCagnotte) REFERENCES Cagnotte(idCagnotte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Anciens_objectifs(
   idObjectif INT,
   PRIMARY KEY(idObjectif),
   FOREIGN KEY(idObjectif) REFERENCES Objectif(idObjectif)
)Engine = 'InnoDb';

CREATE TABLE Objectif_ultime(
   idObjectif INT,
   PRIMARY KEY(idObjectif),
   FOREIGN KEY(idObjectif) REFERENCES Objectif(idObjectif)
)Engine = 'InnoDb';

CREATE TABLE Loisir_commun(
   id_loisir INT,
   nom_loisir VARCHAR(50) NOT NULL,
   idUtilisateur INT NOT NULL,
   id_amitie INT NOT NULL,
   PRIMARY KEY(id_loisir),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(id_amitie) REFERENCES Amitie(id_amitie)
)Engine = 'InnoDb';

CREATE TABLE Camaraderie(
   idCamaraderie INT,
   idUtilisateur INT NOT NULL,
   idPersonne INT NOT NULL,
   PRIMARY KEY(idCamaraderie),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Adresse_favorites(
   id_adresse_fav INT,
   id_loisir INT NOT NULL,
   id_adresse INT NOT NULL,
   PRIMARY KEY(id_adresse_fav),
   FOREIGN KEY(id_loisir) REFERENCES Loisir_commun(id_loisir),
   FOREIGN KEY(id_adresse) REFERENCES Adresse(id_adresse)
)Engine = 'InnoDb';

CREATE TABLE Budget_utilisateur(
   id_Budget INT,
   rentree_d_argent INT,
   depenses_du_mois INT,
   deficit BOOLEAN,
   idCagnotte INT NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(id_Budget),
   FOREIGN KEY(idCagnotte) REFERENCES Cagnotte(idCagnotte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Evenement(
   idEvenement INT,
   nom_event VARCHAR(50) NOT NULL,
   nom_orga VARCHAR(50) NOT NULL,
   annule BOOLEAN,
   cout_event INT,
   idUtilisateur INT NOT NULL,
   id_date INT NOT NULL,
   id_Budget INT NOT NULL,
   id_adresse INT NOT NULL,
   PRIMARY KEY(idEvenement),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(id_date) REFERENCES Dates_event(id_date),
   FOREIGN KEY(id_Budget) REFERENCES Budget_utilisateur(id_Budget),
   FOREIGN KEY(id_adresse) REFERENCES Adresse(id_adresse)
)Engine = 'InnoDb';

CREATE TABLE Calendrier(
   idCalendar INT,
   idEvenement INT NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idCalendar),
   FOREIGN KEY(idEvenement) REFERENCES Evenement(idEvenement),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Seance_revision(
   idEvenement INT,
   matiere VARCHAR(50),
   travail_a_faire VARCHAR(50),
   date_rendu DATE,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idEvenement),
   FOREIGN KEY(idEvenement) REFERENCES Evenement(idEvenement),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Participer(
   idEvenement INT,
   idPersonne INT,
   PRIMARY KEY(idEvenement, idPersonne),
   FOREIGN KEY(idEvenement) REFERENCES Evenement(idEvenement),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Proposer(
   idUtilisateur INT,
   id_date INT,
   PRIMARY KEY(idUtilisateur, id_date),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(id_date) REFERENCES Dates_event(id_date)
)Engine = 'InnoDb';

CREATE TABLE Valider(
   id_amitie INT,
   id_date INT,
   Validation BOOLEAN,
   PRIMARY KEY(id_amitie, id_date),
   FOREIGN KEY(id_amitie) REFERENCES Amitie(id_amitie),
   FOREIGN KEY(id_date) REFERENCES Dates_event(id_date)
)Engine = 'InnoDb';



-- Remplissage des tables --

INSERT INTO Dates_event (id_date, date_event, accord) VALUES 
(1, '2021-07-05 00:00', TRUE),
(2, '2021-10-05 15:00', TRUE),
(3, '2022-11-01 11:30', FALSE),
(4, '2021-09-01 12:00', TRUE),
(5, '2021-12-16 15:59', TRUE),
(6, ADDTIME(now(), "-01:05:00"),TRUE),
(7, '2021-10-05 13:30', TRUE),
(8, NOW(),TRUE),
(9, ADDTIME(now(), "01:00:00"),TRUE),
(10, NOW(),FALSE),
(11, ADDTIME(now(), "-05:00:00"),TRUE),
(12, '2021-10-14 14:30',TRUE),
(13, '2021-10-05 10:30',TRUE),
(14, '2021-10-09 17:00',TRUE),
(15, '2021-10-19 15:00',TRUE),
(16, '2021-10-19 18:00',TRUE);


INSERT INTO Personne (idPersonne, nom, prenom, ville_residence, telephone) VALUES  
(1, 'DUMAS', 'Guillaume', 'Villejuif','0769696969'),
(2, 'GRELAUD', 'Jeremy', 'Villejuif','0669696969'),
(3, 'ROSSIGNOL', 'Amaury', 'Savigny','0569696969'),
(4, 'Helltaker', 'Cerberus', 'Hell','0466666666'),
(5, 'Helltaker', 'Justice', 'Hell','0466666666'),
(6, 'JONG UN', 'Kim','Pyongyang','+380 8080-80'),
(7, 'GEVARA', 'Che','cuba','+1 555-555-5555'),
(8, 'BONAPARTE', 'Napoleon','Ajaccio','0785479864'),
(9, 'MOZART', 'Wolfgang Amadeus','Salzbourg','+43 54972685'),
(10, 'TESLA', 'NIKOLA','Smiljan','+43 82476510');

INSERT INTO Comptes_Reseaux_sociaux (id_reseau, nom_reseau, idPersonne) VALUES 
(1, 'Facebook',1),
(2, 'Facebook',2),
(3, 'Facebook',3),
(4, 'Facebook',4),
(5, 'Facebook',5),
(6, 'Facebook',6),
(7, 'Facebook',7),
(8, 'Facebook',9),
(9, 'Facebook',10),

(10, 'Whatsapp',1),
(11, 'Whatsapp',2),
(12, 'Whatsapp',3),
(13, 'Whatsapp',8),

(14, 'Snapchat',1),
(15, 'Snapchat',4),
(16, 'Snapchat',5),
(17, 'Snapchat',6),
(18, 'Snapchat',10),

(19, 'Twitter', 2),
(20, 'Twitter', 3),
(21, 'Twitter', 8),
(22, 'Twitter', 9);

INSERT INTO Adresse (id_adresse, num_rue, nom_rue, codepostal, ville) VALUES 
(1, 3,'Rue des Potiers',94800,'Villejuif'),
(2, 7,'Rue Albert',94800,'Villejuif'),
(3, 2,'Rue des Alouettes',20167,'Ajaccio'),
(4, 55,'Ryongsong',850111,'Pyongyang'),
(5, 1,'Rue de Lucifer',66666,'Hell'),
(6, 30,'Av. de la Republique',94800,'Villejuif'),
(7, 19,'Av. de liancourt',75014,'Paris'),
(8, 1,'Fushiya',4500001,'Nagoya'),
(9, 5,'Rue de l Hippodrome',29000,'Quimper'),
(10, 1,'Rue de Bron',69001,'Lyon');


INSERT INTO Utilisateur (idUtilisateur, idPersonne) VALUES 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10); 

INSERT INTO Amitie (id_amitie, idUtilisateur, idPersonne) VALUES 
(1,1,2), 
(2,1,3), 
(3,1,4),
(4,1,5),

(5,2,1),
(6,2,3),
(7,2,6),
(8,2,8),

(9,3,1),
(10,3,2),

(11,4,1),

(12,5,1),

(13,6,2),

(14,8,2),

(15,9,10),
(16,10,9);


INSERT INTO Cagnotte (idCagnotte, nom, total, idUtilisateur) VALUES 
(1, 'CagnotteGuillaume', 9000, 1),
(2, 'CagnotteJeremy', 3400, 2),
(3, 'CagnotteSecrete', 100000, 2),
(4, 'CagnotteEfreiInt', 5000, 1),
(5, 'CagnotteAmaury', 2355, 3),
(6, 'CagnotteBBQ', 349, 4),
(7, 'CagnotteHell', 874, 5),
(8, 'CagnotteKim', 854215, 6),
(9, 'CagnotteChe', 57000, 7),
(10, 'CagnotteEmpereur', 1500000, 8),
(11, 'CagnotteAmadeus', 5000, 9),
(12, 'CagnotteNikola', 8500, 10);

INSERT INTO Objectif (idObjectif, nom_objectif, description, type, somme_cible, date_creation_objectif, idCagnotte, idUtilisateur) VALUES 
(1, 'Bac', 'Avoir son bac', 'professionnel', 100, '2019-10-05', 1, 1),
(2, 'Diplome', 'Avoir son diplome avec honneur', 'professionnel', 120000, '2020-09-01', 1, 1),
(3, 'Trouver l_amour', 'avec Belle', 'sentimental', 777, '2020-01-05', 1, 1),
(4, 'Dominer le monde', 'comme Lelouch', 'militaire', 10000000, '2001-07-01', 3, 2),
(5,'Dieu des mathematiques','comme M Teller', 'indispensable', 0, '2019-11-11', 2, 2),
(6,'Japonais','etre bilingue', 'professionnel', 1000, '2018-09-01', 5, 3),
(7,'Patrie','proteger son pays', 'responsabilite', 1000000000, '2011-12-17', 8, 6),
(8,'Musique','composer un nouveau chef d oeuvre', 'artistique', 800, '2021-11-01', 11, 9),
(9,'Batterie electrique','inventer une nouvelle batterie electrique durable', 'ecologique/economique', 500000, '2021-01-05', 12, 10),
(10,'Etudier','l_electromagnetisme', 'educatif', 0, '2019-07-11', 12, 10),
(11,'Ideal marxiste','instaurer cet ideal', 'politique', 55000, '1950-07-11', 9, 7),
(12,'BBQ','avec tous les habitants de Hell', 'loisir', 300, '2021-04-01', 6, 4),
(13,'35h','instaurer les 35h en Hell', 'economique', 0, '2021-04-01', 7, 5),
(14,'Conquête','de l occident', 'militaire', 1748752, '1781-02-08', 10, 8);

INSERT INTO Anciens_objectifs (idObjectif) VALUES 
(1),
(2),
(5),
(10);

INSERT INTO Objectif_ultime (idObjectif) VALUES 
(3),
(4),
(6),
(7),
(8),
(9),
(11),
(12),
(13),
(14);

INSERT INTO Loisir_commun (id_loisir, nom_loisir, idUtilisateur, id_amitie) VALUES 
(1, 'Base de donnees', 1, 2),
(2, 'Cuisine', 1, 1),
(3, 'Maquettes militaires', 2, 7),
(4, 'Maquettes militaires', 2, 5),
(5, 'Maquettes militaires', 2, 8),
(6, 'LoL', 2, 6),
(7, 'Anime', 3, 9),
(8, 'Anime', 3, 10),
(9, 'Sieste', 4, 11),
(10, 'Echecs', 5, 12),
(11, 'Strategie', 6, 13),
(12, 'Modelisme', 8, 14),
(13, 'Science', 9, 15),
(14, 'Musique', 10, 16),
(15, 'Sieste', 1, 2),
(16, 'Sieste', 1, 3),
(17, 'Cuisine', 1, 4),
(18, 'Base de donnees', 3, 9),
(19, 'Cuisine', 2, 5),
(20, 'Maquettes militaires', 6, 13),
(21, 'Maquettes militaires', 1, 1),
(22, 'Maquettes militaires', 8, 14),
(23, 'LoL', 3, 10),
(24, 'Anime', 1, 2),
(25, 'Anime', 2, 6),
(26, 'Sieste', 1, 3),
(27, 'Echecs', 1, 4),
(28, 'Strategie', 2, 7),
(29, 'Modelisme', 2, 8),
(30, 'Science', 10, 16),
(31, 'Musique', 9, 15),
(32, 'Sieste', 2, 5),
(33, 'Sieste', 3, 9),
(34, 'Cuisine', 5, 12);

INSERT INTO Camaraderie (idCamaraderie, idPersonne, idUtilisateur) VALUES 
(1,2,1),
(2,3,1),
(3,4,1),
(4,5,1),
(5,6,1),
(6,9,1),

(7,1,2),
(8,9,2),
(9,7,2),
(10,8,2),
(11,10,2);


INSERT INTO Adresse_favorites (id_adresse_fav, id_adresse, id_loisir) VALUES 
(1, 1, 2),
(2, 2, 1),
(3, 1, 3),
(4, 1, 4),
(5, 3, 5),
(6, 4, 6),
(7, 2, 7),
(8, 2, 8),
(9, 5, 9),
(10, 5, 10),
(11, 1, 11),
(12, 4, 11),
(13, 1, 12),
(14, 3, 12),
(15, 6, 13),
(16, 6, 14);


INSERT INTO Budget_utilisateur(id_Budget, rentree_d_argent, depenses_du_mois, deficit, idCagnotte, idUtilisateur) VALUES 
(1, 1100, 859, FALSE, 1, 1),
(2, 100, 200, TRUE, 2, 2),
(3, 11000, 10000, FALSE, 3, 2),
(4, 1000, 500, FALSE, 4, 1),
(5, 500, 139, FALSE, 5, 3),
(6, 100, 500, TRUE, 6, 4),
(7, 0, 15, TRUE, 7, 5),
(8, 1000000, 5000000, TRUE, 8, 6),
(9, 15000, 0, FALSE, 10, 8),
(10, 357, 125, FALSE, 11, 9);

INSERT INTO Evenement(idEvenement, nom_event, nom_orga, annule, cout_event, idUtilisateur, id_date, id_Budget, id_adresse) VALUES
(1, 'road trip en coree', 'GRELAUD', FALSE, 10000, 2, 1, 3, 4),
(2, 'enquete inge', 'GRELAUD', FALSE, 10, 2, 2, 2, 7),
(3, 'stage japon', 'DUMAS', FALSE, 3000, 1, 3, 1, 8),
(4, 'revision math', 'DUMAS', FALSE, 0, 1, 7, 1, 6),
(5, 'revision Canaux de transmission', 'DUMAS', FALSE, 0, 1, 5, 1, 6),
(6, 'reussir le CE de Canaux de transmission', 'GRELAUD', TRUE, 420, 2, 3, 2, 9),
(7, 'Reunion avec la DRI', 'ROSSIGNOL', FALSE, 0, 3, 6, 1, 6),
(8, 'Reunion avec la DRI n°2', 'ROSSIGNOL', FALSE, 0, 3, 8, 1, 6),
(9, 'revision conception circuits num', 'DUMAS', FALSE, 0, 1,9, 1, 2),
(10, 'Accueil etudiants internationaux', 'DUMAS', TRUE, 0, 1, 11, 1, 6),

(11, 'revision informatique', 'DUMAS', FALSE, 0, 1, 11, 1, 6),
(12, 'revision anglais', 'DUMAS', FALSE, 0, 1, 11, 1, 6),
(13, 'revision systèmes lineaires', 'Helltaker', FALSE, 0, 4, 12, 6, 6),

(14, 'revision Theorie des graphes','DUMAS', FALSE, 0, 1, 13, 1, 2),
(15, 'revision Recherche operationnelle', 'DUMAS', FALSE, 0, 1, 14, 1, 2),
(16, 'revision HTML', 'GRELAUD', FALSE, 0, 2, 15, 2, 10),
(17, 'revision Projet transverse', 'GRELAUD', FALSE, 0, 2, 16, 2, 10);


INSERT INTO Calendrier (idCalendar, idEvenement, idUtilisateur) VALUES 
(1, 3, 1),
(2, 4, 1),
(3, 5, 1),
(4, 7, 1),
(5, 8, 1),
(6, 9, 1),
(7, 13, 1),
(8, 14, 1),
(9, 15, 1),
(10, 16, 1),
(11, 17, 1),

(12, 1, 2),
(13, 2, 2),
(14, 5, 2),
(15, 14, 2),
(16, 15, 2),
(17, 16, 2),
(18, 17, 2),

(19, 7, 3),
(20, 8, 3),
(21, 9, 3),
(22, 3, 3),
(23, 5, 3),
(24, 13, 3);

-- date_rendu = null quand ce n'est pas un devoir
INSERT INTO Seance_revision(idEvenement, matiere, travail_a_faire, date_rendu, idUtilisateur) VALUES
(4, 'Maths', 'Exo matrices', '2021-11-01', 1),
(5, 'Canaux de transmission','Abaque de Smith', '2021-12-17', 1),
(9, 'Conception de circuits numeriques','Comprendre le VHDL', null, 1),
(11, 'base de donnees','Finir le porjet', '2021-11-14',1),
(12, 'anglais','reviser le vocabulaire', null, 1),
(13, 'systèmes lineaires','reviser la decomposition en elements simples', null, 1),
(14, 'Theorie des graphes','reviser Bellman', null, 1),
(15, 'Recherche operationnelle','reviser l algo de flot minimal', null, 1),
(16, 'HTML','reviser le programme avance en html', null, 2),
(17, 'Projet transverse','avancer sur le back-end du projet', '2021-12-31', 2);

INSERT INTO Participer (idEvenement, idPersonne) VALUES
(1, 2),
(1, 6),

(2, 1),
(2, 2),

(3, 1),
(3, 3),

(4, 1),
(4, 2),
(4, 3),

(5, 1),
(5, 2),
(5, 3),

(7, 1),
(7, 3),

(8, 1),
(8, 3),

(9, 1),
(9, 3),


(11, 6),
(11, 9),
(11, 2),

(12, 9),
(12, 3),

(13,3),
(13,6),
(13,8),
(13,9),

(14, 1),
(14, 2),

(15, 1),
(15, 2),

(16, 1),
(16, 2),

(17, 1),
(17, 2);

INSERT INTO Proposer (idUtilisateur, id_date) VALUES 
(1, 2),
(1, 3),
(1, 5),
(1, 7),
(1, 11),

(2, 1),
(2, 6),
(2, 9),
(2, 10),

(3, 4),
(3, 8);




INSERT INTO Valider (id_amitie, id_date, Validation) VALUES 
(5, 1, TRUE), 
(6, 1, FALSE), 
(7, 1, TRUE),
(8, 1, FALSE),

(5, 6, TRUE), 
(6, 6, TRUE), 
(7, 6, FALSE),
(8, 6, FALSE),


(1, 5, TRUE), 
(2, 5, FALSE),
(3, 5, FALSE),
(4, 5, FALSE),

(1, 7, TRUE),
(2, 7, FALSE),
(3, 7, TRUE),
(4, 7, TRUE);

COMMIT;