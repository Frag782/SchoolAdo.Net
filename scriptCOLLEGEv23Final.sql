USE [master]
GO

/****** Object:  Database [College]    Script Date: 2018-08-21 07:59:42 ******/
--CREATE DATABASE [College]
GO

USE [College]
GO

/****** Object:  Table [dbo].[tblEtudiants]    Script Date: 2018-05-26 11:20:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[tblEtudiants]
DROP TABLE [dbo].[tblProgrammes]
DROP TABLE [dbo].[tblUtilisateurs]


CREATE TABLE [dbo].[tblProgrammes](
	[IdProgramme] [varchar](6) NOT NULL,
	[Titre] [nvarchar](100) NULL,
 CONSTRAINT [PK_tblProgrammes] PRIMARY KEY CLUSTERED 
 (
	[IdProgramme] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[tblUtilisateurs](
	[IdUtilisateur] [char](5) NOT NULL,
	[Prenom] [varchar](15) NULL,
	[Nom] [varchar](15) NULL,
	[NomUtilisateur] [varchar](25) NULL,
	[MotPasse] [varchar](25) NULL,
 CONSTRAINT [PK_tblUtilisateurs] PRIMARY KEY CLUSTERED 
(
	[IdUtilisateur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tblEtudiants](
	[IdEtudiant] [char](10) NOT NULL,
	[Prenom] [nvarchar](25) NOT NULL,
	[Nom] [nvarchar](25) NOT NULL,
	[Adresse] [nvarchar](50) NOT NULL,
	[Ville] [nvarchar](50) NOT NULL,
	[Province] [char](2) NOT NULL,
	[CodePostal] [char](7) NOT NULL,
	[Telephone] [char](14) NOT NULL,
	[CodeProgramme] [varchar](6) NOT NULL,
	[IdInstructeur] [char](5) NOT NULL,
	[Statut] [smallint] NOT NULL,
 CONSTRAINT [PK_tblEtudiants] PRIMARY KEY CLUSTERED 
(
	[IdEtudiant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblEtudiants] ADD  CONSTRAINT [DF_tblEtudiants_Statut]  DEFAULT ((-1)) FOR [Statut]
GO

ALTER TABLE [dbo].[tblEtudiants] ADD CONSTRAINT FK_Etudiants_Instructeur FOREIGN KEY (IdInstructeur) REFERENCES [dbo].[tblUtilisateurs] (IdUtilisateur)
GO

ALTER TABLE [dbo].[tblEtudiants] ADD CONSTRAINT FK_Etudiants_Programme FOREIGN KEY (CodeProgramme) REFERENCES [dbo].[tblProgrammes] (IdProgramme)
GO

--DELETE FROM tblProgrammes;
INSERT INTO tblProgrammes VALUES('MA.350','Maîtrise ès sciences - finance appliquée')
INSERT INTO tblProgrammes VALUES('MA.766','La maîtrise en finance appliquée - Ingénierie financière')
INSERT INTO tblProgrammes VALUES('BA.655','Bachelier en administration des affaires - Anglais')
INSERT INTO tblProgrammes VALUES('BA.711','Bachelier en administration des affaires - Allemand')
INSERT INTO tblProgrammes VALUES('BA.650','Bachelier en administration des affaires - technologies d''affaires')
INSERT INTO tblProgrammes VALUES('BA.712','Bachelier en administration des affaires - finance')
INSERT INTO tblProgrammes VALUES('BA.661','Bachelier en administration des affaires - marketing')
INSERT INTO tblProgrammes VALUES('BA.713','Bachelier en administration des affaires - gestion des ressources humaines')
INSERT INTO tblProgrammes VALUES('LEA.9C','Programmeur-analyste - orienté Internet')
INSERT INTO tblProgrammes VALUES('LEA.AE','Gestionnaire en réseautique - spécialiste de la sécurité')
INSERT INTO tblProgrammes VALUES('420.XX','Programmeur - Intelligence d''affaire')
INSERT INTO tblProgrammes VALUES('421.XY','Gestionnaire en réseautique 2 - spécialiste de la sécurité')


--DELETE FROM tblUtilisateurs;
GO
INSERT INTO tblUtilisateurs VALUES('aa001','Admin','Admin','admin','admin')
INSERT INTO tblUtilisateurs VALUES('bb001','Bruno','Beaulieu','brubeaulieu','Naya2009')
INSERT INTO tblUtilisateurs VALUES('ac001','Alex','Cloutier','alecloutier','Max2018')
INSERT INTO tblUtilisateurs VALUES('yp001','Yves','Poulin','ypoulin','Joya2009')
INSERT INTO tblUtilisateurs VALUES('in001','Isabelle','Nadeau','inadeau','Ratchet2010')

INSERT INTO tblUtilisateurs VALUES('ab001','Ahmed','Bittar','abittar','Moncef2010')


INSERT INTO tblUtilisateurs VALUES('yd001','Yves','Desharnais','ydesharnais','Chanelle2010')
INSERT INTO tblUtilisateurs VALUES('ml001','Michel','Leduc','mleduc','projet9898')
INSERT INTO tblUtilisateurs VALUES('yd002','Maxime','Roger','mroger','mroger88')


INSERT INTO tblUtilisateurs VALUES('ml002','Martin','Davidson','root','root')

GO

--etudiants de admin admin
INSERT INTO tblEtudiants VALUES('821-002231','Josée','La Riccia','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(514) 325-6151','MA.350','aa001',1)
INSERT INTO tblEtudiants VALUES('821-002232','Patricia','Daoust','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(438) 325-6152','MA.350','aa001',1)
INSERT INTO tblEtudiants VALUES('821-002233','Bruno Théorêt','St-Laurent','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(145) 325-6153','MA.766','aa001',1)
--etudiants de Bruno Beaulieu
INSERT INTO tblEtudiants VALUES('754-003231','Joey','Mallet','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(587) 325-6158','BA.655','bb001',1)
INSERT INTO tblEtudiants VALUES('754-003232','Mélanie','Côté','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(789) 325-6158','BA.655','bb001',1)
INSERT INTO tblEtudiants VALUES('754-003233','Mary-Lou','Raymond','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(478) 325-6158','MA.766','bb001',1)
--etudiants d'Alex Cloutier
INSERT INTO tblEtudiants VALUES('648-004231','Étienne','Robert','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(694) 325-6158','420.XX','ac001',1)
INSERT INTO tblEtudiants VALUES('648-004232','Céline','Dion','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(789) 325-6158','420.XX','ac001',1)
INSERT INTO tblEtudiants VALUES('648-004233','Rachelle','Lefèvre','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(257) 325-6158','420.XX','ac001',1)
--etudiants d'Yves Poulin
INSERT INTO tblEtudiants VALUES('987-005231','Rachid','Badouri','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(438) 325-6158','420.XX','yp001',1)
INSERT INTO tblEtudiants VALUES('987-005232','Marcel','B.liveau','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(514) 325-6158','BA.713','yp001',1)
INSERT INTO tblEtudiants VALUES('987-005233','Eugenie','Bouchard','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(124) 325-6158','BA.713','yp001',1)
--etudiants d'Isabelle Nadeau
INSERT INTO tblEtudiants VALUES('593-006231','Isabelle','Boulay','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(248) 325-6158','BA.713','in001',1)
INSERT INTO tblEtudiants VALUES('593-006232','Véronique','Cloutier','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(981) 325-6158','BA.713','in001',1)
INSERT INTO tblEtudiants VALUES('593-006233','Emmanuelle','Chriqui','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(248) 325-6158','BA.713','in001',1)
--etudiants des autres instructeurs
INSERT INTO tblEtudiants VALUES('176-001231','Leonard','Cohen','9875 boul. St-Laurent','Montréal','Qc','H7A 1B2','(478) 325-6158','LEA.AE','ml001',1)
INSERT INTO tblEtudiants VALUES('176-002522','Gary','Fisher','3275 Crescent','Montréal','Qc','H1H 2B6','(514) 385-6952','LEA.AE','ml001',0)
INSERT INTO tblEtudiants VALUES('176-003323','Paul','Wagner','4555 boul. LabergeL','St-Constant','Qc','J3G 5F6','(450) 685-1254','LEA.9C','yd001',0)
INSERT INTO tblEtudiants VALUES('176-003321','Manon','Robichaud','2536 rue de la Montagne','St-Bruno-de-Montarville','Qc','M6V 1E3','(450) 587-2659','LEA.9C','yd001',0)
INSERT INTO tblEtudiants VALUES('653-003325','Sandrine','Latourelle','4595 English road','Mascouche','Qc','K9H 8G7','(847) 987-3216','LEA.9C','yd001',0)
INSERT INTO tblEtudiants VALUES('789-004450','Steve','Bristoll','56 rue Principale','Châteauguay','Qc','J7J 2F7','(987) 695-6547','LEA.9C','yd001',1)
INSERT INTO tblEtudiants VALUES('789-006543','Stéphanie','St-Jean','3795 boul. St-Joseph','Montréal','Qc','G7H 8P9','(514) 385-6549','LEA.9C','yd001',2)
INSERT INTO tblEtudiants VALUES('789-009876','Patrick','Laberge','5775 rue Juliette','Laval','Qc','H1G 9P8','(450) 665-3755','LEA.9C','yd001',0)
INSERT INTO tblEtudiants VALUES('653-009877','Martin','Forget','475 Avenue J-Alphonse-Lachance','Laval','Qc','H8R 0B6','(589) 665-3755','420.XX','yd002',0)
INSERT INTO tblEtudiants VALUES('789-009878','Isabelle','Raymond','5775 rue Hochelogua','Laval','Qc','H1G 9P8','(438) 665-3755','420.XX','yd002',0)
INSERT INTO tblEtudiants VALUES('854-009879','Harouna','Beau-soleil','5775 Pointe-aux trembles','Laval','Qc','H1G 9P8','(145) 665-3755','420.XX','yd002',0)


INSERT INTO tblEtudiants VALUES('654-005872','Michael','Johnson','123 Maple Street','Toronto','ON','M5V 2T6','(416) 123-4567','BA.712','ab001',0);
INSERT INTO tblEtudiants VALUES('790-002178','Emily','Wilson','234 Oak Avenue','Vancouver','BC','V5Z 3Y4','(604) 234-5678','BA.650','ab001',0);
INSERT INTO tblEtudiants VALUES('855-006841','Daniel','Moore','345 Pine Lane','Calgary','AB','T2P 1G5','(403) 345-6789','BA.711','ab001',0);
INSERT INTO tblEtudiants VALUES('657-001277','Jessica','Brown','456 Birch Drive','Montreal','QC','H3Z 2T1','(514) 456-7890','BA.712','ab001',0);
INSERT INTO tblEtudiants VALUES('791-003478','Matthew','Jackson','567 Cedar Way','Edmonton','AB','T6C 2V4','(780) 567-8901','BA.650','ab001',0);
INSERT INTO tblEtudiants VALUES('856-008492','Angela','Davis','678 Redwood Path','Halifax','NS','B3H 4P2','(902) 678-9012','BA.711','ab001',0);
INSERT INTO tblEtudiants VALUES('658-004879','Robert','Harris','789 Maple Leaf Blvd','Ottawa','ON','K1A 0A1','(613) 789-0123','BA.712','ab001',0);
INSERT INTO tblEtudiants VALUES('792-009080','Linda','Smith','890 Poplar Road','Winnipeg','MB','R3C 3A8','(204) 890-1234','BA.650','ab001',0);
INSERT INTO tblEtudiants VALUES('857-010193','David','Taylor','901 Cherry St','Regina','SK','S4P 3E9','(306) 901-2345','BA.711','ab001',0);



INSERT INTO tblEtudiants VALUES('654-006871','James','Williams','123 Elm Street','Montreal','QC','H3Z 2A5','(514) 453-5678','BA.650','ml002',0);
INSERT INTO tblEtudiants VALUES('790-002189','Sophia','Thompson','456 Spruce Lane','Quebec City','QC','G1K 6H7','(418) 234-6789','BA.712','ml002',0);
INSERT INTO tblEtudiants VALUES('855-006852','Benjamin','Anderson','789 Oak Drive','Gatineau','QC','J8T 5G3','(819) 345-7890','BA.711','ml002',0);
INSERT INTO tblEtudiants VALUES('656-001284','Oliver','Miller','112 Maple Blvd','Sherbrooke','QC','J1H 5N1','(819) 456-8901','BA.650','ml002',0);
INSERT INTO tblEtudiants VALUES('792-003489','Mia','Davis','334 Birch Avenue','Trois-Rivières','QC','G8Y 4B7','(819) 567-9012','BA.712','ml002',0);
INSERT INTO tblEtudiants VALUES('857-008493','Ethan','Jones','556 Pine Path','Saguenay','QC','G7H 4P2','(418) 678-0123','BA.711','ml002',0);
INSERT INTO tblEtudiants VALUES('659-004876','Ava','Smith','777 Cedar Road','Drummondville','QC','J2B 6X1','(819) 789-2345','BA.650','ml002',0);
INSERT INTO tblEtudiants VALUES('793-009091','Liam','Taylor','888 Redwood Way','Saint-Jean-sur-Richelieu','QC','J3B 8T8','(450) 890-3456','BA.712','ml002',0);
INSERT INTO tblEtudiants VALUES('858-010194','Emma','Clark','999 Spruce Boulevard','Granby','QC','J2J 3L1','(450) 901-4567','BA.711','ml002',0);






GO