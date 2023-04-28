-- -------------------------------------------------
-- Nom de la base de donnees : recherche          --
-- Auteur des requêtes : Nausicaa                 --
-- -------------------------------------------------


-- 1. Liste de tous les budgets triés par ordre décroissant et sans doublons --
Select distinct BUDGET from projet order by BUDGET DESC ;

-- 2. Liste de tous les projets dont le budget est entre 400000 et 900000 euros. --
Select BUDGET from projet
where BUDGET Between 400000 and 900000;

-- 3. Liste des chercheurs en précisant pour chacun le nom de l’équipe à laquelle il appartient --
Select chercheur.NOM, chercheur.PRENOM, equipe.NOM 
from chercheur inner join equipe on chercheur.NE = equipe.NE;

-- 4. Lister les noms de toutes les équipes et le nombre de projets qui lui appartiennent (indiquer 0 si l’équipe ne gère aucun projet) --
Select equipe.NOM, count(projet.NP) from equipe left join projet
on projet.NE = equipe.NE 
Group by equipe.NE;

-- 5. Lister les noms et prénoms des chercheurs qui ont participé à plus de 4 projets. --
Select chercheur.NOM, chercheur.PRENOM 
from chercheur natural join aff 
Group by chercheur.NC having count(distinct aff.NP) > 4 ;

-- 6. Lister les noms et prénoms des chercheurs qui ont participé à plus de 2 projets durant une année et dont le budget du projet est supérieur à 30k euros -- 
Select chercheur.NOM, chercheur.PRENOM 
from chercheur join aff join projet 
on chercheur.NC = aff.NC and aff.NP = projet.NP
where projet.BUDGET > 30000
Group by chercheur.NOM having count(aff.NP)>2;

-- 7. Lister les chercheurs qui ont participé au même projet que « M. VIEIRA » en 2018. --
select * from chercheur join aff on chercheur.NC = aff.NC
where( chercheur.NOM != 'VIEIRA' and aff.ANNEE = '2018' 
	   and chercheur.NE = ( select NE from chercheur 
							where NOM ='VIEIRA') 
		and aff.NP in (select NP from chercheur natural join aff
					    where(chercheur.NOM = 'VIEIRA' and aff.ANNEE = '2018') ) 
	);


-- 8. Lister les chercheurs qui ont participé à tous les projets de leur équipe. --
Select chercheur.NOM from chercheur
where not exists (Select projet.NP from projet
					where projet.NE = chercheur.NE and not exists (Select * from aff 
																	where aff.NP = projet.NP and aff.NC = chercheur.NC));

-- 9. Lister les noms et prénoms des chercheurs qui ont participé au plus grand nombre de projets. --
Select chercheur.NOM, chercheur.PRENOM 
from chercheur join aff on chercheur.NC = aff.NC
group by chercheur.NOM, chercheur.PRENOM 
having count(distinct aff.NP) >= all(select count(distinct aff.NP) from aff group by aff.NC); -- all : compare toutes les valeurs de la sous requete avec count(distinct aff.NP)
 
-- 10. Lister les projets dont le budget est supérieur à un budget quelconque de l’année 2018. --
Select * from projet
where projet.BUDGET > any( select distinct BUDGET 
						   from projet natural join aff
                           where aff.ANNEE = 2018) ;

-- 11. Lister les équipes qui ont au moins un projet auquel a participé plus de 2 chercheurs. --
Select distinct equipe.NOM 
from equipe join projet on equipe.NE = projet.NE
where projet.NP in (select aff.NP from aff
		group by aff.NP having count(distinct aff.NC) > 2 ) ;
        

-- 12. Lister les équipes dont tous les projets ont plus de 2 participants. --
Select * from equipe 
where equipe.NE in ( Select distinct NE from projet natural join aff
					 group by NP having count(distinct NC) > 2 );


-- 13. Donner les noms et le nombre de chercheurs y participant des projets qui ont le plus grand budget. --
Select projet.NOM, count(distinct NC) 
from projet natural join aff
where projet.BUDGET = (select max(projet.BUDGET) from projet)
group by NP;

-- 14. Lister les noms et prénoms des chercheurs qui ont participés dans les projets de 2 équipes différentes. --
Select distinct count(distinct aff.NP), chercheur.NOM, chercheur.PRENOM 
from chercheur join aff join projet on chercheur.NC = aff.NC and aff.NP = projet.NP
-- where chercheur.NC = aff.NC and projet.NP = aff.NP ;
where chercheur.NE != projet.NE
group by chercheur.NOM, chercheur.PRENOM;

-- 15. Lister les projets auxquels sont affectés les chercheurs « BOUGUEROUA » et « WOLSKA ». --
Select distinct projet.NP, projet.NOM from projet, aff, chercheur 
where projet.NP = aff.NP 
	  and aff.NC = chercheur.NC 
      and chercheur.NOM in ('BOUGUEROUA', 'WOLSKA');

-- 16. Lister les projets auxquels ne sont affectés ni « BOUGUEROUA », ni « WOLSKA ». --
Select distinct projet.NP, projet.NOM from projet
where not exists 
(
	Select * from aff, chercheur 
	where projet.NP = aff.NP 
		  and aff.NC = chercheur.NC 
		  and chercheur.NOM in ('BOUGUEROUA', 'WOLSKA')	
);

-- 17. Lister les noms de projets dont le budget est de plus de 30K et auxquels sont affectés au moins un chercheur par équipe. --
Select projet.NOM from projet, aff, chercheur
where projet.BUDGET > 30000 and projet.NP = aff.NP and aff.NC = chercheur.NC
group by projet.NP having count(distinct chercheur.NE) = (select count(*) from equipe);

-- 18. Donner les noms et prénoms des chercheurs qui ont participé à tous les projets de l’année 2018. --
Select distinct chercheur.nom, chercheur.prenom 
from chercheur, aff
where chercheur.NC = aff.NC and aff.NP = all(
						select distinct projet.NP from projet, aff
						where projet.NP = aff.NP and aff.ANNEE = 2020
);

