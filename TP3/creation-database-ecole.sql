
-- ----------------------------------------------
-- Nom de la base de donnees : ecole           --
-- SGBD : MySql                                --
-- Date de creation : 20/10/2021               --
-- Auteur : Nausicaa                           --
-- ----------------------------------------------

DROP DATABASE IF EXISTS ecole ;
CREATE DATABASE IF NOT EXISTS ecole ;
USE ecole;

drop table if exists ACTIVITES_PRATIQUEES ;
drop table if exists  CHARGE ;
drop table if exists  RESULTATS ;
drop table if exists  ACTIVITES ;
drop table if exists  PROFESSEURS ;
drop table if exists COURS ;
drop table if exists ELEVES ;
drop table if exists AGGLOMERATIONS ;

create table ELEVES
(
    NUM_ELEVE       Numeric(6) NOT NULL,
    NOM             VARCHAR(25) NOT NULL,
    PRENOM          VARCHAR(25) NOT NULL,
    DATE_NAISSANCE  DATE,
    POIDS           Numeric(3),
    ANNEE           Numeric(1),
    SEXE	         CHAR(1),
    constraint PK_ELEVES primary key (NUM_ELEVE)
) engine = InnoDB;

create table COURS
(
    NUM_COURS       Numeric(4)  NOT NULL,
    NOM             VARCHAR(20) NOT NULL,
    NBHEURES        Numeric(2),
    ANNEE           Numeric(1),
    constraint PK_COURS primary key (NUM_COURS)
) engine = InnoDB;

create table PROFESSEURS
(
    NUM_PROF        Numeric(4)  NOT NULL,
    NOM             VARCHAR(25) NOT NULL,
    SPECIALITE      VARCHAR(20),
    DATE_ENTREE     DATE,
    DER_PROM        DATE,
    SALAIRE_BASE    Numeric(8,2),
    SALAIRE_ACTUEL  Numeric(8,2),
    constraint PK_PROFESSEURS primary key (NUM_PROF)
) engine = InnoDB;

create table ACTIVITES
(
    NIVEAU          Numeric(1)  NOT NULL,
    NOM             VARCHAR(20) NOT NULL,
    EQUIPE          VARCHAR(32),
    constraint PK_ACTIVITES primary key (NIVEAU,NOM)
) engine = InnoDB;

create table RESULTATS
(
    NUM_ELEVE       Numeric(6) NOT NULL,
    NUM_COURS       Numeric(4) NOT NULL,
    POINTS         Numeric(3),
    constraint PK_RESULTATS primary key (NUM_ELEVE, NUM_COURS)
) engine = InnoDB;

create table CHARGE
(
    NUM_PROF       Numeric(4) NOT NULL,
    NUM_COURS      Numeric(4) NOT NULL,
    constraint PK_CHARGE primary key (NUM_PROF, NUM_COURS)
) engine = InnoDB;

create table ACTIVITES_PRATIQUEES
(
    NUM_ELEVE       Numeric(6) NOT NULL,
    NIVEAU          Numeric(1) NOT NULL,
    NOM             VARCHAR(20) NOT NULL,
    constraint PK_ACTIVITES_PRATIQUEES primary key 
    (NUM_ELEVE, NIVEAU, NOM) 
)engine = InnoDB;

alter table RESULTATS
    add constraint FK_RESULTAT_ELEVES foreign key(NUM_ELEVE)
       references ELEVES(NUM_ELEVE);

alter table RESULTATS
    add constraint FK_RESULTAT_COURS foreign key(NUM_COURS)
       references COURS(NUM_COURS);

alter table CHARGE
    add constraint FK_CHARGE_COURS foreign key(NUM_COURS)
       references COURS(NUM_COURS);

alter table CHARGE
    add constraint FK_CHARGE_PROFESSEUR foreign key (NUM_PROF)
       references PROFESSEURS(NUM_PROF);

alter table ACTIVITES_PRATIQUEES
    add constraint FK_ACTIVITE_ELEVES foreign key (NUM_ELEVE)
       references ELEVES(NUM_ELEVE);

alter table ACTIVITES_PRATIQUEES
    add constraint FK_ACTIVITEPR_ACTIVITE foreign key(NIVEAU, NOM)
       references ACTIVITES (NIVEAU, NOM);



Insert into eleves (Num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (1, 'Brisefer', 'Benoit', '2004-10-12', 35, 1) ;

Insert into eleves (Num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (2, 'Génial', 'Olivier', '2004-10-04', 42, 1) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (3, 'Jourdan', 'Gil', '2004-06-28', 72, 2) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (4, 'Spring', 'Jerry', '2003-02-16', 78, 2) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (5, 'Tsuno', 'Yoko', '2005-10-19', 45, 1) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (6, 'Lebut', 'Marc', '2003-04-29', 75,2) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (7, 'Lagaffe', 'Gaston', '2004-08-04', 61,1) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (8, 'Dubois', 'Robin', '2005-04-12', 60, 2) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (9, 'Walthéry', 'Natacha', '2004-07-09', 59,1) ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee)
Values (10, 'Danny', 'Buck', '2000-02-19', 82, 2) ;

set sql_safe_updates=0; -- Pour autoriser la mise a jour
update eleves set sexe ='M' where num_eleve in (1, 3, 7);
update eleves set sexe ='m' where num_eleve in (2,4,5);
update eleves set sexe ='F' where num_eleve in (6,8);
update eleves set sexe ='f' where num_eleve in (9,10);

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (1, 'Réseau', 15, 1);

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (2, 'Sgbd', 30, 1) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (3, 'Programmation', 15,1) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (4, 'Systeme', 30,2 ) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (5, 'Analyse', 60,2) ;


Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(1, 'Bottle', 'poésie', '2000-10-19', '2020-01-01', 2000, 2600) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(2, 'Bolenov', 'réseau', '2010-10-11', '2020-01-01', 1900, 2468) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(3, 'Tonilaclasse', 'poo', '2019-01-10', '2021-01-01', 1900, 2360);

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(4, 'Pastecnov', 'sql', '2020-10-19', NULL, 2500, 2500) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(5, 'Selector', 'sql', '2002-10-15', '2021-01-01', 1900, 1900) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(6, 'Vilplusplus', 'poo', '1999-02-04', '2020-05-01', 1900, 2200) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(7, 'Francesca', NULL, '2015-01-10', '2019-11-01', 2000, 3200) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(8, 'Pucette', 'sql', '1998-06-12', '2018-02-01', 2000, 2500) ;

Insert into CHARGE (Num_prof, Num_cours) Values(1,1) ;

Insert into CHARGE (Num_prof, Num_cours) Values(1,4) ;

Insert into CHARGE (Num_prof, Num_cours) Values(2,1) ;

Insert into CHARGE (Num_prof, Num_cours) Values(3,2) ;

Insert into CHARGE (Num_prof, Num_cours) Values(3,4) ;

Insert into CHARGE (Num_prof, Num_cours) Values(3,5) ;

Insert into CHARGE (Num_prof, Num_cours) Values(4,2) ;

Insert into CHARGE (Num_prof, Num_cours) Values(7,4) ;

Insert into CHARGE (Num_prof, Num_cours) Values(8,1) ;

Insert into CHARGE (Num_prof, Num_cours) Values(8,2) ;

Insert into CHARGE (Num_prof, Num_cours) Values(8,3) ;

Insert into CHARGE (Num_prof, Num_cours) Values(8,4) ;

Insert into CHARGE (Num_prof, Num_cours) Values(8,5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(1,1, 15 ) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(1,2 ,10.5 ) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(1, 4, 8) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(1, 5, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(2, 1, 13.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(2, 2, 12) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(2, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(2, 5, 1.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(3, 1, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(3, 2, 15) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(3, 4, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(3, 5, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(4, 1, 16.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(4, 2, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(4, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(4, 5, 8) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(5, 1, 5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(5, 2, 6.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(5, 4, 13) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(5, 5, 13) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(6, 1, 15) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(6, 2, 3.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(6, 4, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(6, 5, 5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(7, 1, 2.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(7, 2, 18) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(7, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(7, 5, 10) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(8, 1, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(8, 2, 0) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(8, 4, 6) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(8, 5, 11.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(9, 1, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(9, 2, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(9, 4, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(9, 5, 9.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(10, 1, 3) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(10, 2, 12.5);

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(10, 4, 0) ;

Insert into RESULTATS (Num_eleve, Num_cours, points) Values(10, 5, 16) ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(1,'Mini foot','Amc Indus') ;

Insert into ACTIVITES (Niveau, Nom, equipe) 
values (1,'Surf','Les planchistes ...') ;


Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Tennis','Ace Club') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(3,'Tennis','Ace Club') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(1,'Volley ball', 'Avs80') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Mini foot', 'Les as du ballon') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Volley ball', 'smash') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (2, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (2, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (4, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (4, 2, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (9, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (9, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 2, 'Volley ball') ;

COMMIT;

-- 2.2
ALTER TABLE Eleves ADD (CodePostal NUMERIC(5), Ville VARCHAR(50));
ALTER TABLE Eleves MODIFY Poids NUMERIC(3) CHECK(Poids BETWEEN 35 AND 135);

-- 2.3
UPDATE Eleves SET CodePostal=75013, Ville='paris' WHERE Num_Eleve = 1;
UPDATE Eleves SET CodePostal=93800, Ville='EPINAY / seine' WHERE Num_Eleve = 3;
UPDATE Eleves SET CodePostal=93800, Ville='EPINAY SUR SEINE' WHERE Num_Eleve = 5;
UPDATE Eleves SET CodePostal=91000, Ville='EVRY' WHERE Num_Eleve = 7;
UPDATE Eleves SET CodePostal=94000, Ville='Creteil' WHERE Num_Eleve = 9;

-- 2.4
UPDATE Eleves SET CodePostal = 94800, Ville='Villejuif' WHERE Num_Eleve IN(2, 4, 6, 8, 10);

-- 2.5
ALTER TABLE Eleves MODIFY COLUMN Ville VARCHAR(60);
-- ALTER TABLE Eleves MODIFY COLUMN CodePostal NUMERIC(4);

-- 2.6
CREATE TABLE Agglomerations
(
    CP          Numeric(5)    NOT NULL,
    Ville       VARCHAR(60) CHECK(Ville = Upper(Ville)),
    -- Classement  VARCHAR(50) CHECK(Classement IN('PETITE-VILLE', 'GRANDE-VILLE', 'METROPOLE', 'MEGAPOLE')),
    Classement  ENUM ('PETITE-VILLE', 'GRANDE-VILLE', 'METROPOLE', 'MEGAPOLE'),
    constraint PK_Agglo primary key (CP, Ville)
) engine = 'InnoDB';

-- 2.7
INSERT INTO Agglomerations(CP, Ville, Classement)
  VALUES (75001, 'PARIS', 'METROPOLE'),
         (75013,'PARIS','METROPOLE'),
         (93800,'EPINAY SUR SEINE','PETITE-VILLE'),
         (93430,'Villetaneuse','PETITE-Ville'),
         (91000,'EVRY','PETITE-VILLE'),
         (94000,'CRETEIL','GRANDE-VILLE'),
         (94800,'VILLEJUIF','GRANDE-VILLE');

-- 2.8
UPDATE Eleves SET Ville = (SELECT Ville FROM Agglomerations WHERE CP = CodePostal);

-- 2.9
ALTER TABLE Eleves ADD CONSTRAINT FK_Eleves_Agglo FOREIGN KEY(CodePostal, Ville) REFERENCES Agglomerations(CP, Ville) ON DELETE CASCADE;

commit;

