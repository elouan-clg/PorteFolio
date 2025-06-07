/*______________________________________________________________________________

        ÉTAPE 2
________________________________________________________________________________

POUR QUE LES DATES SOIENT INTERPRÉTÉES EN JOUR/MOIS/ANNÉE
EXÉCUTER LA REQUÊTE CI-DESSOUS :
*/
SET DATESTYLE TO EUROPEAN;

/*
__________________________________________

 A - PREMIÈRES DONNÉES DANS LA BASE
__________________________________________

=============================
  A1 - Jeu de données initial
===========================*/

-- Insertion de 10 adhérents de code compris entre 'A1' et 'A10'
INSERT INTO ADHERENT VALUES ('A1', 'Jean','Dupont', '01-01-1999', '01-23-45-67-89', 'JeanDupont@un.mail', 'DuponT'),
                            ('A2', 'Jack','Dupond', '01-01-1999', '09-87-65-43-21', 'JackDupond@un.mail', 'DuponD'),
                            ('A3', 'Fred','Martin', '24-12-2003', '06-25-95-88-15', 'Fredo38@contact.cool', 'AIYGIWGWY'),
                            ('A4', 'Joachim', 'Lefèvre', '28-07-1974', '07-37-39-95-28', 'Joachim.Lefevre@upmail.col', 'JLF745**'),
                            ('A5','Alban','Berclay','31-12-2003', '04-45-28-96-74','Exorbit@nt.lenon','FriandiseAuChocolat'),
                            ('A6', 'Janis', 'Fay', '06-06-1966', '06-14-85-29-25', 'JanisFay@un.mail', 'jANISoUBLIElEmDP'),
                            ('A7', 'Jean', 'Sive', '18-10-2001', '07-26-27-82-45', 'JeanSivePerso@upmail.col', 'P4smal2dans'),
                            ('A8', 'Octave', 'Septimius', '14-02-1982', '07-57-94-26-75', 'Octaveleromain@un.mail', 'YaPlusPompee'),
                            ('A9', 'Milla', 'Dubois', '29-02-2000', '06-06-06-06-06', 'MillaDubois@upmail.col', 'Milla1234'),
                            ('A10', 'Zoé', 'Zanardi', '12-01-1999', '07-99-88-99-79', 'ZZoeeee@upmail.col', 'ZZoeeeeDuZoir<3');

-- Insertion d'une piste : numéro de piste = 1
INSERT INTO PISTE VALUES (1);

-- Insertion de 2 paires de chaussures par pointure du 32 au 46
-- Au moins une paire par pointure doit être en bon état
-- Pour chaque pointure, le numéro d'une paire sera égal à
-- * 10 fois la pointure + 1 pour la 1ère paire
-- * 10 fois la pointure + 2 pour la 2ème paire

INSERT INTO CHAUSSURES VALUES  (321, 32, 'OK', '10-12-2018'), (322, 32, 'OK', '10-12-2018'), (331, 33, 'OK', '10-12-2018'), (332, 33, 'KO', '10-12-2018'),
                               (341, 34, 'OK', '10-12-2018'), (342, 34, 'OK', '10-12-2018'), (351, 35, 'OK', '10-12-2018'), (352, 35, 'OK', '10-12-2018'),
                               (361, 36, 'OK', '10-12-2018'), (362, 36, 'OK', '10-12-2018'), (371, 37, 'OK', '10-12-2018'), (372, 37, 'OK', '10-12-2018'),
                               (381, 38, 'OK', '10-12-2018'), (382, 38, 'OK', '10-12-2018'), (391, 39, 'KO', '10-12-2018'), (392, 39, 'OK', '10-12-2018'),
                               (401, 40, 'OK', '10-12-2018'), (402, 40, 'OK', '10-12-2018'), (411, 41, 'OK', '10-12-2018'), (412, 41, 'OK', '10-12-2018'),
                               (421, 42, 'KO', '10-12-2018'), (422, 42, 'OK', '10-12-2018'), (431, 43, 'OK', '10-12-2018'), (432, 43, 'OK', '10-12-2018'),
                               (441, 44, 'OK', '10-12-2018'), (442, 44, 'OK', '10-12-2018'), (451, 45, 'OK', '10-12-2018'), (452, 45, 'KO', '10-12-2018'),
                               (461, 46, 'OK', '10-12-2018'), (462, 46, 'OK', '10-12-2018');

);

/*===========================================
  A2 - Traitement de demandes de réservation
=============================================

****************************************************************************
 A2.1 : Première demande à traiter :

  date de jeu 17 février 2025, début à 9h15, 2 parties, 2 joueurs majeurs,
  l'adhérent 'A1' qui fait la demande fera partie des joueurs,
  retenue d'une paire de chaussures en pointure 42 et d'une paire
  de chaussures en pointure 43

RAPPEL :  cette demande pourra être satisfaite car aucune réservation n'a
          encore été faite (donc la piste n°1 est disponible) et que pour
          chaque pointure, au moins une paire de chaussures est en bon état
****************************************************************************

---------------------------------
a) Heure estimée de fin du jeu
-------------------------------*/

SELECT ('09:15:00'+ (interval'10 minutes') * 2 * 2) AS HeureFin;

/* Résultat de la requête (à coller ci-dessous)

 heurefin 
----------
 09:55:00
(1 row)

----------------------------------------------------------------------------
b) Enregistrement de la réservation (on sait qu'elle pourra être satisfaite)
--------------------------------------------------------------------------*/

INSERT INTO RESERVATION VALUES(1, '17-02-2025', '09:15:00', 2, 2, 0 , 'A1', 1, true);

-- vérification
SELECT * FROM RESERVATION;

/* Résultat du SELECT (à coller ci-dessous)

 numresa |  datejeu   | hdebjeu  | nbparties | nbjoueurs | nbmineurs | codeadh | numpiste | participation 
---------+------------+----------+-----------+-----------+-----------+---------+----------+---------------
       1 | 2025-02-17 | 09:15:00 |         2 |         2 |         0 | A1      |        1 | t
(1 row)

-----------------------------------------------------------------------------
-- c) Mémorisation de l'occupation de la piste 1 de 15 minutes avant l'Heure
      de début de jeu de la réservation n°1 à 15 minutes après l'heure de fin
      estimée
---------------------------------------------------------------------------*/

INSERT INTO OCCUPATION_P VALUES(1, '17-02-2025', '09:00:00', '10:10:00');

-- vérification
SELECT * FROM OCCUPATION_P;

/* Résultat du SELECT (à coller ci-dessous)

 numpiste |  datejour  |  debuto  |   fino   
----------+------------+----------+----------
        1 | 2025-02-17 | 09:00:00 | 10:10:00
(1 row)

---------------------------------------------------------------------------
d) Recherche de paires de chaussures en bon état, en pointure 42 et
   en pointure 43 (il y a au moins une paire de chaque)
   Pour chaque pointure :
      - enregistrement dans EMPRUNT d'une des paires trouvées
      - enregistrement dans INDISPONIBILITE_C de cette paire

NOTE : dans le cas où plusieurs paires de la même pointure sont en bon état
       la paire de plus petit numéro sera choisie
---------------------------------------------------------------------------

-------------------------------------------------------------
* Numéros des paires de chaussures de pointure 42 en bon état
-----------------------------------------------------------*/

SELECT * FROM CHAUSSURES WHERE Pointure = 42;

/* Résultat de la requête (à coller ci-dessous)

 numpaire | pointure | etat | dateachat  
----------+----------+------+------------
      421 |       42 | KO   | 2018-12-10
      422 |       42 | OK   | 2018-12-10
(2 rows)

--------------------------------------------------------------
* Enregistrement dans EMPRUNT de la paire de plus petit numéro
------------------------------------------------------------*/

INSERT INTO EMPRUNT VALUES(421, 1);

-- vérification
SELECT * FROM EMPRUNT WHERE NumResa = 1;
/* Résultat du SELECT (à coller ci-dessous)

 numpaire | numresa 
----------+---------
      421 |       1
(1 row)

-------------------------------------------------------------
* Numéros des paires de chaussures de pointure 43 en bon état
-----------------------------------------------------------*/

SELECT * FROM CHAUSSURES WHERE Pointure = 43;

/* Résultat de la requête (à coller ci-dessous)

 numpaire | pointure | etat | dateachat  
----------+----------+------+------------
      431 |       43 | OK   | 2018-12-10
      432 |       43 | OK   | 2018-12-10
(2 rows)

--------------------------------------------------------------
* Enregistrement dans EMPRUNT de la paire de plus petit numéro
------------------------------------------------------------*/

INSERT INTO EMPRUNT VALUES(431, 1);

-- vérification
SELECT * FROM EMPRUNT WHERE NumResa = 1;
/* Résultat du SELECT (à coller ci-dessous)

 numpaire | numresa 
----------+---------
      421 |       1
      431 |       1
(2 rows)

-------------------------------------------------------------------------
* Enregistrement des paires retenues dans INDISPONIBILITE_C pour le jour
  de la réservation n°1, de 15 minutes avant l'Heure de début de jeu
  à 15 minutes après l'heure de fin de jeu estimée
-----------------------------------------------------------------------*/

INSERT INTO INDISPONIBILITE_C VALUES(421, '17-02-2025', '09:00:00', '10:10:00'), (431, '17-02-2025', '09:00:00', '10:10:00') ;

-- vérification
SELECT * FROM INDISPONIBILITE_C;
/* Résultat du SELECT (à coller ci-dessous)

 numpaire |  datejour  |  debutu  |   finu   
----------+------------+----------+----------
      421 | 2025-02-17 | 09:00:00 | 10:10:00
      431 | 2025-02-17 | 09:00:00 | 10:10:00
(2 rows)

****************************************************************************
 A2.2 : Traitement de deux nouvelles demandes

 NOTE : les données de ces demandes sont choisies de façon à ce que
        ces demandes puissent être satisfaites

-------------------------
 1ère demande à traiter :
-------------------------
  date de jeu 17 février 2025, début à 11h30,
  1 partie, 3 joueurs dont 1 mineur,
  l'adhérent 'A3' qui fait la demande ne fera pas partie des joueurs,
  retenue d'une paire de chaussures en pointure 36

-------------------------
 2ème demande à traiter :
-------------------------
  date de jeu 17 février 2025, début à 16h,
  3 parties, 4 joueurs dont 3 mineurs,
  l'adhérent 'A10' qui fait la demande fera partie des joueurs,
  pas de chaussures retenues

****************************************************************************

** TRAITEMENT DE LA DEMANDE DE L'ADHÉRENT 'A3'
---------------------------------
-- a) Heure estimée de fin du jeu
-------------------------------*/

SELECT ('11:30:00'+ (interval'10 minutes') * 1 * 3) AS HeureFin;


/* Résultat de la requête (à coller ci-dessous)

heurefin 
----------
 12:00:00
(1 row)

---------------------------------------------------------------------------
 b) Enregistrement de la réservation

    NOTE : la valeur du numéro de cette réservation doit être immédiatement
           supérieure à la plus grande valeur de NumResa dans RESERVATION
-------------------------------------------------------------------------*/

INSERT INTO RESERVATION VALUES(2, '17-02-2025', '11:30:00', 1, 3, 1, 'A3', 1, false);

-- vérification
SELECT * FROM RESERVATION;
/* Résultat du SELECT (à coller ci-dessous)

 numresa |  datejeu   | hdebjeu  | nbparties | nbjoueurs | nbmineurs | codeadh | numpiste | participation 
---------+------------+----------+-----------+-----------+-----------+---------+----------+---------------
       1 | 2025-02-17 | 09:15:00 |         2 |         2 |         0 | A1      |        1 | t
       2 | 2025-02-17 | 11:30:00 |         1 |         3 |         1 | A3      |        1 | f
(2 rows)

-----------------------------------------------------------------------------
-- c) Mémorisation de l'occupation de la piste 1 de 15 minutes avant l'Heure
      de début de jeu de cette réservation à 15 minutes après l'heure de fin
      estimée
---------------------------------------------------------------------------*/

INSERT INTO OCCUPATION_P VALUES(1, '17-02-2025', '11:15:00', '12:15:00');

-- vérification
SELECT * FROM OCCUPATION_P;
/* Résultat du SELECT (à coller ci-dessous)

 numpiste |  datejour  |  debuto  |   fino   
----------+------------+----------+----------
        1 | 2025-02-17 | 09:00:00 | 10:10:00
        1 | 2025-02-17 | 11:15:00 | 12:15:00
(2 rows)

---------------------------------------------------------------------------
d) Recherche de paires de chaussures en bon état, en pointure 36
   (il y en a au moins une)
   Puis :
      - enregistrement dans EMPRUNT d'une des paires trouvées
      - enregistrement dans INDISPONIBILITE_C de cette paire

NOTE : dans le cas où plusieurs paires de la même pointure sont en bon état
       la paire de plus petit numéro sera choisie
---------------------------------------------------------------------------
-------------------------------------------------------------
* Numéros des paires de chaussures de pointure 36 en bon état
-----------------------------------------------------------*/
SELECT * FROM CHAUSSURES WHERE Pointure = 36;

/* Résultat de la requête (à coller ci-dessous)

 numpaire | pointure | etat | dateachat  
----------+----------+------+------------
      361 |       36 | OK   | 2018-12-10
      362 |       36 | OK   | 2018-12-10
(2 rows)

--------------------------------------------------------------
* Enregistrement dans EMPRUNT de la paire de plus petit numéro
------------------------------------------------------------*/

INSERT INTO EMPRUNT VALUES(361, 2);

-- vérification
SELECT * FROM EMPRUNT WHERE NumResa = 2;
/* Résultat du SELECT (à coller ci-dessous)

 numpaire | numresa 
----------+---------
      361 |       2
(1 row)

-------------------------------------------------------------------------
* Enregistrement de la paires retenue dans INDISPONIBILITE_C pour le jour
  de cette réservation, de 15 minutes avant l'Heure de début de jeu
  à 15 minutes après l'heure de fin de jeu estimée
-----------------------------------------------------------------------*/

INSERT INTO INDISPONIBILITE_C VALUES(361, '17-02-2025', '11:15:00', '12:15:00');

-- vérification
SELECT * FROM INDISPONIBILITE_C;
/* Résultat du SELECT (à coller ci-dessous)

 numpaire |  datejour  |  debutu  |   finu   
----------+------------+----------+----------
      421 | 2025-02-17 | 09:00:00 | 10:10:00
      431 | 2025-02-17 | 09:00:00 | 10:10:00
      361 | 2025-02-17 | 11:15:00 | 12:15:00
(3 rows)

** TRAITEMENT DE LA DEMANDE DE L'ADHÉRENT 'A10'
---------------------------------
-- a) Heure estimée de fin du jeu
-------------------------------*/

SELECT ('16:00:00'+ (interval'10 minutes') * 3 * 4) AS HeureFin;

/* Résultat de la requête (à coller ci-dessous)

 heurefin 
----------
 18:00:00
(1 row)

---------------------------------------------------------------------------
 b) Enregistrement de la réservation

    NOTE : la valeur du numéro de cette réservation doit être immédiatement
           supérieure à la plus grande valeur de NumResa dans RESERVATION
-------------------------------------------------------------------------*/
INSERT INTO RESERVATION VALUES(3, '17-02-2025', '16:00:00', 3, 4, 3, 'A10', 1, true);

-- vérification
SELECT * FROM RESERVATION;
/* Résultat du SELECT (à coller ci-dessous)

 numresa |  datejeu   | hdebjeu  | nbparties | nbjoueurs | nbmineurs | codeadh | numpiste | participation 
---------+------------+----------+-----------+-----------+-----------+---------+----------+---------------
       1 | 2025-02-17 | 09:15:00 |         2 |         2 |         0 | A1      |        1 | t
       2 | 2025-02-17 | 11:30:00 |         1 |         3 |         1 | A3      |        1 | f
       3 | 2025-02-17 | 16:00:00 |         3 |         4 |         3 | A10     |        1 | t
(3 rows)

-----------------------------------------------------------------------------
-- c) Mémorisation de l'occupation de la piste 1 de 15 minutes avant l'Heure
      de début de jeu de cette réservation à 15 minutes après l'heure de fin
      estimée
---------------------------------------------------------------------------*/

INSERT INTO OCCUPATION_P VALUES(1, '17-02-2025', '15:45:00', '18:15:00');

-- vérification
SELECT * FROM OCCUPATION_P;
/* Résultat du SELECT (à coller ci-dessous)

 numpiste |  datejour  |  debuto  |   fino   
----------+------------+----------+----------
        1 | 2025-02-17 | 09:00:00 | 10:10:00
        1 | 2025-02-17 | 11:15:00 | 12:15:00
        1 | 2025-02-17 | 15:45:00 | 18:15:00
(3 rows)
____________________________________________

 B - REQUÊTES ET TRAITEMENT NOUVELLES DEMANDES
     NE POUVANT PAS TOUJOURS ÊTRE SATISFAITES
_______________________________________________


===============================================
 B1 -	Écrire et tester les requêtes suivantes :
===============================================

************************************************************************
B1.1  Nombre total de mineurs pour chaque jour futur où des réservations
      sont enregistrées - Résultat ordonné par date
***********************************************************************/

SELECT sum(NBMineurs)AS nb_tt_mineur 
FROM RESERVATION
WHERE CURRENT_DATE < RESERVATION.datejeu;

/* Résultat de la requête (à coller ci-dessous)

 nb_tt_mineur 
--------------
            4
(1 row)

**************************************************************************
B1.2  Détails de la réservation numéro 1
      Code de l'adhérent demandeur, nombre d'adultes, nombre de mineurs,
      numéro de la piste réservée, heure de début de jeu, heure estimée de
      la fin du jeu et nombre de paires de chaussures retenues
*************************************************************************/

SELECT CodeAdh, NbJoueurs-NbMineurs AS NbMajeurs, NbMineurs, numPiste,
       HDebJeu, (HDebJeu+ (interval'10 minutes') * NbParties * NbJoueurs)AS HFinJeu,
       (SELECT COUNT(NumPaire) FROM EMPRUNT WHERE NumResa=1)
FROM RESERVATION WHERE NumResa=1;

/* Résultat de la requête (à coller ci-dessous)

 codeadh | nbmajeurs | nbmineurs | numpiste | hdebjeu  | hfinjeu  | count 
---------+-----------+-----------+----------+----------+----------+-------
 A1      |         2 |         0 |        1 | 09:15:00 | 09:55:00 |     2
(1 row)

********************************************************************************
B1.3  Pour le 17/02/2025, numéro et pointure des paires de chaussures
      réservées, numéro de réservation et plage d'indisponibilité de
      ces chaussures
      - Résultat ordonné sur la pointure puis le numéro des paires réservées

INDICATIONS :
* La clause FROM utilisera uniquement la relation INDISPONIBILITE_C
* Une clause WHERE restreindra le résultat aux n-uplets concernant le jour ciblé
* Les n-uplets (numpaire, pointure, debutu, finu, numresa) du résultat seront
  obtenus comme suit :
  - numpaire proviendra directement de INDISPONIBILITE_C
  - pointure proviendra d'une sous-requête sélectionnant dans CHAUSSURES
    la pointure de la paire de numéro égal à numpaire
  - debutu et finu proviendront directement de INDISPONIBILITE_C
  - numresa proviendra d'une sous-requête sélectionnant dans RESERVATION
    le numéro de la réservation dont le jour est le jour ciblé
    et l'heure de début de jeu est comprise entre debutu et finu
*******************************************************************************/

SELECT NumPaire, (SELECT C.Pointure FROM CHAUSSURES AS C WHERE C.NumPaire=I.NumPaire),
       debutu, finu,
       (SELECT R.NumResa FROM RESERVATION AS R, EMPRUNT AS E WHERE R.NumResa=E.NumResa
                                                             AND E.NumPaire=I.NumPaire
                                                             AND R.datejeu='17-02-2025'
                                                             AND R.HDebJeu BETWEEN I.debutu AND I.finu)
FROM INDISPONIBILITE_C AS I 
WHERE datejour='17-02-2025'
ORDER BY NumResa, NumPaire;

/* Résultat de la requête (à coller ci-dessous)

 numpaire | pointure |  debutu  |   finu   | numresa 
----------+----------+----------+----------+---------
      421 |       42 | 09:00:00 | 10:10:00 |       1
      431 |       43 | 09:00:00 | 10:10:00 |       1
      361 |       36 | 11:15:00 | 12:15:00 |       2
(3 rows)

**************************************************************************
B1.4  Pour chaque pointure, nombre de paires de chaussures en mauvais état
*************************************************************************/
SELECT C.pointure, (SELECT count(NumPaire)
                    FROM CHAUSSURES AS CC
                    WHERE C.pointure=CC.pointure
                    GROUP BY pointure) -COUNT(C.etat) AS NbreMauvaisEtat
FROM CHAUSSURES AS C
WHERE C.etat LIKE 'OK'
GROUP BY Pointure
ORDER BY Pointure;

/* Résultat de la requête (à coller ci-dessous)

 pointure | nbremauvaisetat 
----------+-----------------
       32 |               0
       33 |               1
       34 |               0
       35 |               0
       36 |               0
       37 |               0
       38 |               0
       39 |               1
       40 |               0
       41 |               0
       42 |               1
       43 |               0
       44 |               0
       45 |               1
       46 |               0
(15 rows)

*************************************************************
B1.5  Planning d'occupation des pistes, le 17 février 2025

NOTE : faire comme s'il y avait plusieurs pistes dans la base
************************************************************/
SELECT NumPiste, Debuto, Fino 
FROM OCCUPATION_P 
WHERE datejour='17-02-2025'
ORDER BY NumPiste, Debuto;


/* Résultat de la requête (à coller ci-dessous)

 numpiste |  debuto  |   fino   
----------+----------+----------
        1 | 09:00:00 | 10:10:00
        1 | 11:15:00 | 12:15:00
        1 | 15:45:00 | 18:15:00
(3 rows)

================================================================================
 B2 -	Vérifier s'il est possible que les demandes de réservation suivantes
      soient saitsfaites et, si c'est le cas, faire le nécessaire...

-------------------------
 1ère demande à traiter :
-------------------------
 date de jeu 17 février 2025, début à 13h,
 3 parties, 2 joueurs dont 1 mineur,
 l'adhérent 'A8' qui fait la demande ne fera pas partie des joueurs,
 retenue d'une paire de chaussures en pointure 32

 -------------------------
  2ème demande à traiter :
 -------------------------
 date de jeu 17 février 2025, début à 15h,
 2 parties, 4 joueurs majeurs,
 l'adhérent 'A5' qui fait la demande fera partie des joueurs,
 retenue d'une paire de chaussures en pointure 43
================================================================================

** TRAITEMENT DE LA DEMANDE DE L'ADHÉRENT 'A8'

---------------------------------
(1) Heure estimée de fin du jeu
-------------------------------*/
SELECT ('13:00:00'+ (interval'10 minutes') * 3 * 2) AS HeureFin;

/* Résultat de la requête (à coller ci-dessous)

 heurefin 
----------
 14:00:00
(1 row)

-------------------------------------------------------------------------------
(2) Recherche d'une piste disponible au moins 15 minutes avant l'heure de début
    du jeu et jusqu'à au moins 15 minutes après l'heure de fin estimée ?

    REMARQUE : pour l'instant il n'y a qu'une piste, mais écrire une requête
               qui qrend en compte le fait qu'il peut y en avoir plusieurs
-----------------------------------------------------------------------------*/

SELECT NumPiste
FROM PISTE
EXCEPT
SELECT NumPiste
FROM OCCUPATION_P
WHERE datejour='17-02-2025'
AND (Debuto<'12:45:00' 
 OR Fino>'13:45:00');

/* Résultat de la requête (à coller ci-dessous)

 numpiste 
----------
        1
(1 row)

-----------------------------------------------------------------
(3) S'il y a une piste disponible,
    Y a-t-il une paire de chaussures disponible en pointure 32 ?
---------------------------------------------------------------*/
-- IL Y A UNE PISTE DISPONIBLE (LA SEULE EXISTANT DANS LA BASE LORS DU TEST)

SELECT NumPaire
FROM CHAUSSURES
WHERE Pointure ='32'
AND Etat = 'OK'
EXCEPT
SELECT NumPaire
FROM INDISPONIBILITE_C
WHERE datejour='17-02-2025'
AND (Debutu<'12:45:00' 
 OR Finu>'13:45:00');

/* Résultat de la requête (à coller ci-dessous)

 numpaire 
----------
      321
      322
(2 rows)

-------------------------------------------------------------------------
(4) Si la retenue de chaussures peut être satisfaite, faire le nécessaire
    pour traiter la demande de l'adhérent 'A8'
    * enregistrer une nouvelle réservation correspondant à la demande
    * mettre à jour OCCUPATION_P
    * enregistrer dans EMPRUNT le plus petit numéro des paires de
      chaussures répondant à la demande
    * mettre à jour INDISPONIBILITE_C
-------------------------------------------------------------------------
NOTE : LA RETENUE DE CHAUSSURES PEUT ÊTRE SATISFAITE => FAIRE LE NÉCESSAIRE

* enregistrement de la réservation     */

INSERT INTO RESERVATION VALUES(4, '17-02-2025', '13:00:00', 3, 2, 1, 'A8', 1, false);

-- vérification
SELECT * FROM RESERVATION;
/* Résultat du SELECT (à coller ci-dessous)

 numresa |  datejeu   | hdebjeu  | nbparties | nbjoueurs | nbmineurs | codeadh | numpiste | participation 
---------+------------+----------+-----------+-----------+-----------+---------+----------+---------------
       1 | 2025-02-17 | 09:15:00 |         2 |         2 |         0 | A1      |        1 | t
       2 | 2025-02-17 | 11:30:00 |         1 |         3 |         1 | A3      |        1 | f
       3 | 2025-02-17 | 16:00:00 |         3 |         4 |         3 | A10     |        1 | t
       4 | 2025-02-17 | 12:45:00 |         3 |         2 |         1 | A8      |        1 | f
(4 rows)

* Mise à jour de OCCUPATION_P     */

INSERT INTO OCCUPATION_P VALUES(1, '17-02-2025', '12:45:00', '13:45:00');

-- vérification
SELECT * FROM OCCUPATION_P ORDER BY NumPiste, DateJour, DebutO;
/* Résultat du SELECT (à coller ci-dessous)

 numpiste |  datejour  |  debuto  |   fino   
----------+------------+----------+----------
        1 | 2025-02-17 | 09:00:00 | 10:10:00
        1 | 2025-02-17 | 11:15:00 | 12:15:00
        1 | 2025-02-17 | 12:45:00 | 13:45:00
        1 | 2025-02-17 | 15:45:00 | 18:15:00
(4 rows)

* Enregistrement dans EMPRUNT du plus petit numéro parmi des paires de pointure
  32 en bon état et disponibles de 15 minutes avant l'heure de déput de jeu
  à 15 minues après l'heure de fin estimée                                    */

INSERT INTO EMPRUNT VALUES((SELECT NumPaire
                            FROM CHAUSSURES
                            WHERE Pointure ='32'
                            EXCEPT
                            SELECT NumPaire
                            FROM INDISPONIBILITE_C
                            WHERE datejour='17-02-2025'
                            AND (Debutu<'12:45:00' 
                             OR Finu>'13:45:00')
                            LIMIT 1), 4);
-- vérification
SELECT * FROM EMPRUNT;
/* Résultat du SELECT (à coller ci-dessous)

 numpaire | numresa 
----------+---------
      421 |       1
      431 |       1
      361 |       2
      321 |       4
(4 rows)

* mise à jour de INDISPONIBILITE_C   */

INSERT INTO INDISPONIBILITE_C VALUES(321, '17-02-2025', '12:45:00', '13:45:00');
-- vérification
SELECT * FROM INDISPONIBILITE_C ORDER BY DateJour, DebutU;
/* Résultat du SELECT (à coller ci-dessous)

 numpaire |  datejour  |  debutu  |   finu   
----------+------------+----------+----------
      421 | 2025-02-17 | 09:00:00 | 10:10:00
      431 | 2025-02-17 | 09:00:00 | 10:10:00
      361 | 2025-02-17 | 11:15:00 | 12:15:00
      321 | 2025-02-17 | 12:45:00 | 13:45:00
(4 rows)

** TRAITEMENT DE LA DEMANDE DE L'ADHÉRENT 'A5'
------------------------------------------------------------------------
RAPPEL DE LA DEMANDE :
 date de jeu 17 février 2025, début à 15h,
 2 parties, 4 joueurs majeurs,
 l'adhérent 'A5' qui fait la demande fera partie des joueurs,
 retenue d'une paire de chaussures en pointure 43
-------------------------------------------------------------------------

---------------------------------
(1) Heure estimée de fin du jeu
-------------------------------*/

SELECT ('15:00:00'+ (interval'10 minutes') *  2 * 4) AS HeureFin;

/* Résultat de la requête (à coller ci-dessous)

 heurefin 
----------
 16:20:00
(1 row)

-------------------------------------------------------------------------------
(2) Recherche d'une piste disponible au moins 15 minutes avant l'heure de début
    du jeu et jusqu'à au moins 15 minutes après l'heure de fin estimée ?

    REMARQUE : pour l'instant il n'y a qu'une piste, mais écrire une requête
               qui qrend en compte le fait qu'il peut y en avoir plusieurs
-----------------------------------------------------------------------------*/

SELECT NumPiste
FROM PISTE
EXCEPT
SELECT NumPiste
FROM OCCUPATION_P
WHERE datejour='17-02-2025'
AND (Debuto<'14:45:00' 
 OR Fino>'16:05:00');

/* Résultat de la requête (à coller ci-dessous)

 numpiste 
----------
(0 rows)

------------------------------------------------------------------------------
BILAN ATTENDU :
  Aucune piste disponible, la demande ne peut pas être prise en compte !
  INUTILE DE VÉRIFIER S'IL Y A UNE PAIRE DE CHAUSSURES POINTURE 43 DISPONIBLE
------------------------------------------------------------------------------*/
