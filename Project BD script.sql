--6) Connectez-vous avec le privilège sysdba puis lancer la commande permettant d'arrêter la base.
    CONN SYS/DBX AS SYSDBA;
    SHUTDOWN IMMEDIATE;

--8) Ecrire la commande permettant de faire un démarrage partiel (NOMOUNT) de votre INSTANCE sous SQLPLUS. Est-il possible de créer une table.
    STARTUP NOMOUNT;
    CREATE TABLE PERSONNE(
        name VARCHAR(15)
    );

--9) Faire passer l’instance a l’état (MOUNT) puis démarrer complètement la Base de Données.
    SHUTDOWN;
    STARTUP MOUNT;
    SHUTDOWN;
    STARTUP OPEN;

--10)  Quels sont le nom de l’instance Oracle, sa version, sa machine de résidence et l’état de la base? 
    SELECT INSTANCE_NAME, HOST_NAME, VERSION, STATUS FROM V$INSTANCE;

--11) Quel est le nom de la base et son mode d’ouverture?
    SELECT NAME, OPEN_MODE FROM V$DATABASE;

--12) Création de l’espace de l’espace de stockage TBS1.
    CREATE TABLESPACE TBS1 
    DATAFILE 
    'c:\tporacle1\datafile1.dbf' SIZE 50M,
    'c:\tporacle1\datafile2.dbf' SIZE 75M,
    'c:\tporacle1\datafile3.dbf' SIZE 100M
    DEFAULT STORAGE
    (INITIAL 10K
    NEXT 5K
    MINEXTENTS 1
    MAXEXTENTS 5);

--13) Création de l’espace de stockage TBS2.
    CREATE TABLESPACE TBS2 
    DATAFILE 
    'c:\tporacle2\datafile4.dbf' SIZE 100M,
    'c:\tporacle2\datafile5.dbf' SIZE 750M
    DEFAULT STORAGE
    (INITIAL 140K
    NEXT 50K
    MINEXTENTS 4
    MAXEXTENTS 5);

--14) Quels sont les noms et les numéros des espaces de stockage (tablespace) ?

--15) Quels sont les noms des fichiers de données (datafile) et la taille de leurs blocs. ?
    SELECT FILE_NAME, BYTES FROM DBA_DATA_FILES;


--16) Dans quel espace de stockage (tablespace) est localisé chaque fichier de données (datafile) ?
    SELECT TABLESPACE_NAME, FILE_NAME FROM DBA_DATA_FILES;

--17) Quels sont les noms et les emplacements des fichiers de contrôle de la base?
    SELECT NAME FROM V$CONTROLFILE;

--18) Quels sont les noms et les emplacements des fichiers du journal (redo log) des images après modif ?
    SELECT MEMBER FROM V$LOGFILE;

--19) Ajouter à TBS2 un troisième fichier de données datafile3 localises dans c:\tporacle2 de 80M
    ALTER TABLESPACE TBS2 ADD DATAFILE 'c:\tporacle2\datafile3.dbf' SIZE 80M;

--20) Déplacer le fichier datafile3 vers le répertoire c:\nomgroupe\projet2021(Donner les étapes).
    ALTER TABLESPACE TBS2 OFFLINE NORMAL;
    copy c:\tporacle2\datafile3.dbf c:\BDGroupe\projet2021\datafile3.dbf
    ALTER TABLESPACE TBS2 RENAME DATAFILE 'c:\tporacle2\datafile3.dbf' TO 'c:\BDGroupe\projet2021\datafile3.dbf';
    ALTER TABLESPACE TBS2 ONLINE;

--21) Quels sont les noms des fichiers de données (datafile)
    SELECT FILE_NAME FROM DBA_DATA_FILES;

--22) Mettre le tablespace TBS1 hors-service pour rendre cette partie de la base indisponible. Peut-on y créer une table employe (id ,first_name , last_name , email , phone_number ,sal,comm)
    ALTER TABLESPACE TBS1 OFFLINE NORMAL;
    CREATE TABLE EMPLOYE(
        ID NUMBER(11),
        FIRST_NAME VARCHAR2(20),
        LAST_NAME VARCHAR2(20),
        EMAIL varchar(30),
        PHONE_NUMBER NUMBER(15),
        SAL NUMBER(7,2),
        COMM VARCHAR2(50)
    )
    TABLESPACE TBS1;

--23) Mettre le tablespace en service puis y créer la table employe (id ,first_name , last_name , email , phone_number ,sal, comm)
    ALTER TABLESPACE TBS1 ONLINE;
    CREATE TABLE EMPLOYE(
        ID NUMBER(11),
        FIRST_NAME VARCHAR2(20),
        LAST_NAME VARCHAR2(20),
        EMAIL varchar(30),
        PHONE_NUMBER NUMBER(15),
        SAL NUMBER(7,2),
        COMM VARCHAR2(50)
    )
    TABLESPACE TBS1;

--24) Mettre le tablespace en lecture seule. Peut-on insérer une nouvelle ligne dans la table employe.
    ALTER TABLESPACE TBS1 READ ONLY;
    INSERT INTO EMPLOYE VALUES(1, 'Mackenson', 'JEAN LOUIS', 'jean@gmail.com', 35956727, 5000, 'Employe exemplaire');

--25) Afficher les principales informations sur les tablespaces.
    SELECT TABLESPACE_NAME, INITIAL_EXTENT, NEXT_EXTENT, MIN_EXTENTS, MAX_EXTENTS, STATUS, BLOCK_SIZE FROM DBA_TABLESPACES;

------------------------------------------------------------------------------------------------------------------------------
--PARTIE 2
------------------------------------------------------------------------------------------------------------------------------

--26) Etablir la différence entre les vues suivantes. Interroger pour cela la vue DICT :
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_TABLES', 'ALL_TABLES');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_CONSTRAINTS', 'ALL_CONSTRAINTS');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_TAB_COLUMNS', 'ALL_TAB_COLUMNS');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_TAB_COMMENTS', 'ALL_TAB_COMMENTS');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_COL_COMMENTS', 'ALL_COL_COMMENTS');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_SYNONYMS', 'ALL_SYNONYMS');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_SEQUENCES', 'ALL_SEQUENCES');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_INDEXES', 'ALL_INDEXES');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_IND_COLUMNS', 'ALL_IND_COLUMNS');
    SELECT * FROM DICT WHERE TABLE_NAME IN ('USER_CONS_COLUMNS', 'ALL_CONS_COLUMNS');

--27) On considère les vues suivantes du Dictionnaire de données d’Oracle
    --a)Ecrire les requêtes SQL permettant de retrouver le nom, le type de données et la tailles des différentes colonnes des vues précédentes
    SELECT TABLE_NAME FROM USER_TAB_COLUMNS WHERE TABLE_NAME like'A%';


------------------------------------------------------------------------------------------------------------------------------
--PARTIE 3
------------------------------------------------------------------------------------------------------------------------------
