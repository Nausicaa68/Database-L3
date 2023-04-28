
-- ----------------------------------------------
-- Nom de la base de donnees : bdd_plasmide    --
-- SGBD : MySql                                --
-- Date de creation : 17 mai 2022              --
-- Auteur: Guillaume Dumas                     --
-- ----------------------------------------------

drop database if exists bdd_plasmide;
create database if not exists bdd_plasmide;
use bdd_plasmide;

CREATE TABLE personne(
   id_personne INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   telephone VARCHAR(50),
   bureau INT,
   etage INT,
   PRIMARY KEY(id_personne)
);

CREATE TABLE type_de_plasmide(
   id_type INT,
   origineDuSite VARCHAR(50),
   code INT,
   nom VARCHAR(50),
   vecteur VARCHAR(50),
   taille VARCHAR(50),
   PRIMARY KEY(id_type)
);

CREATE TABLE lieuStockage(
   id_lieu INT,
   lieu VARCHAR(50),
   designation VARCHAR(50),
   PRIMARY KEY(id_lieu)
);

CREATE TABLE origine(
   id_origine INT,
   nom VARCHAR(50),
   adresse VARCHAR(50),
   telephone VARCHAR(50),
   courriel VARCHAR(50),
   PRIMARY KEY(id_origine)
);

CREATE TABLE reference(
   id_reference INT,
   lien VARCHAR(50),
   PRIMARY KEY(id_reference)
);

CREATE TABLE plasmide(
   id_plasmide INT,
   id_origine INT NOT NULL,
   id_type INT NOT NULL,
   id_lieu INT NOT NULL,
   PRIMARY KEY(id_plasmide),
   FOREIGN KEY(id_origine) REFERENCES origine(id_origine),
   FOREIGN KEY(id_type) REFERENCES type_de_plasmide(id_type),
   FOREIGN KEY(id_lieu) REFERENCES lieuStockage(id_lieu)
);

CREATE TABLE mta(
   id_mta INT,
   numero_mta VARCHAR(50),
   id_personne INT NOT NULL,
   id_plasmide INT NOT NULL,
   PRIMARY KEY(id_mta),
   UNIQUE(id_plasmide),
   FOREIGN KEY(id_personne) REFERENCES personne(id_personne),
   FOREIGN KEY(id_plasmide) REFERENCES plasmide(id_plasmide)
);

CREATE TABLE reception(
   id_plasmide INT,
   id_personne INT,
   dateReception DATE,
   PRIMARY KEY(id_plasmide, id_personne),
   FOREIGN KEY(id_plasmide) REFERENCES plasmide(id_plasmide),
   FOREIGN KEY(id_personne) REFERENCES personne(id_personne)
);

CREATE TABLE lien(
   id_plasmide INT,
   id_reference INT,
   PRIMARY KEY(id_plasmide, id_reference),
   FOREIGN KEY(id_plasmide) REFERENCES plasmide(id_plasmide),
   FOREIGN KEY(id_reference) REFERENCES reference(id_reference)
);

-- Valeurs --

INSERT INTO personne (id_personne,nom,prenom,telephone,bureau,etage)
VALUES
(1,"DUPONT","Marc","0611223344",014,0),
(2,"SCHMIT","Jean","0610213512",028,0),
(3,"OTT"," Emma","0656867814",029,0),
(4,"PETIT"," Richard","0611361728",104,1),
(5,"DUBOIS"," Daniel","0618436412",108,1),
(6,"AUBRY","Sarah","0614764436",118,1),
(7,"MULLER","Lisa","0633405118",203,2);

INSERT INTO type_de_plasmide (id_type, origineDuSite, code, nom, vecteur, taille)
VALUES
(1,"addgene",35000,"Nurr1","pCCL-ppt-PGK-WPRE",7041),
(2,"addgene",27150,"Tet-0-FUW-Ascl1","Teto-FUW",8393),
(3,"addgene",20342,"FUW-M2rtTA","FUW(Lenti-Lox-Ubi)",7231),
(4,"snapgene",22217,"FCK-Arch-GFP","FCK(1,3)GW",9227),
(5,"snapgene",52398,"pLXSNGbE7","pLXSN",6380),
(6,"plsdb",20083,"pEF1-PNH-4","pDONRP4-P1R",4777);

INSERT INTO lieuStockage (id_lieu,lieu,designation)
VALUES
(1,"Salle 1","Frigo1"),
(2,"Salle 1","Frigo2"),
(3,"Salle 2","Frigo1"),
(4,"Salle 3","Frigo1"),
(5,"Salle 4","Frigo1");

INSERT INTO origine (id_origine,nom,adresse,telephone,courriel)
VALUES
(1,"VALOIS"," 13 rue de la paix 67000 Strasbourg","0626341114","valois@gmail.com"),
(2,"RICHARD","18 rue Eiffel 75000 Paris","0612162108","richard@gmail.com"),
(3,"CLARK"," 28 rue de la victoire 69000 Lyon","0604362477","clark@gmail.com");

INSERT INTO reference (id_reference,lien)
VALUES
(1,"addgene.org"),
(2,"snapgene.com"),
(3,"ccb-microbe.cs.uni-saarland.de/plsdb");

INSERT INTO plasmide (id_plasmide,id_origine,id_type,id_lieu)
VALUES
(1,2,2,1),
(2,1,3,3),
(3,2,2,2),
(4,2,1,2),
(5,2,4,3),
(6,1,5,3),
(7,3,3,1),
(8,3,2,2),
(9,1,6,4),
(10,3,6,4);

INSERT INTO mta (id_mta,id_personne,id_plasmide)
VALUES
(1,6,4),
(2,4,5),
(3,3,2),
(4,3,1),
(5,3,9),
(6,1,10);

INSERT INTO reception(id_plasmide,id_personne,dateReception)
VALUES
(1,3,"2021-11-04"),
(2,3,"2021-10-03"), 
(3,4,"2021-04-06"), 
(4,6,"2021-02-01"), 
(5,4,"2021-03-18"), 
(6,2,"2021-08-19"), 
(7,2,"2021-08-20"), 
(8,1,"2021-11-23"), 
(9,3,"2021-07-16"), 
(10,1,"2021-03-11"); 

INSERT INTO lien (id_plasmide,id_reference)
VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,2),
(6,2),
(7,1),
(8,1),
(9,3),
(10,3);

commit;

-- Requête demandée --

Select plasmide.id_plasmide, origineDuSite, code, nom, vecteur, taille, lieu, designation 
from plasmide join type_de_plasmide join lieustockage
on plasmide.id_type = type_de_plasmide.id_type and plasmide.id_lieu = lieustockage.id_lieu
order by plasmide.id_plasmide;

