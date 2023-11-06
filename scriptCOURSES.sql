USE College;

-- Création de la table des cours
CREATE TABLE tblCourses (
    IdCourse INT PRIMARY KEY,  -- clé primaire pour tblCourses
    IdProgramme VARCHAR(6) NOT NULL, -- clé étrangère faisant référence à tblProgrammes
    NomDuCours VARCHAR(255) NOT NULL,
    DescriptionDuCours TEXT,
    FOREIGN KEY (IdProgramme) REFERENCES tblProgrammes(IdProgramme)
);

-- Insertion d'exemples de cours pour chaque programme
INSERT INTO tblCourses (IdCourse, IdProgramme, NomDuCours, DescriptionDuCours) VALUES
(1, 'MA.350', 'Modèles Financiers Appliqués', 'Une étude approfondie des modèles financiers modernes.'),
(2, 'MA.350', 'Méthodes Quantitatives en Finance', 'Étude des techniques quantitatives en finance.'),
(3, 'MA.766', 'Marchés des Dérivés', 'Exploration des marchés des dérivés, y compris les futures et les options.'),
(4, 'MA.766', 'Gestion de Portefeuille', 'Stratégies et méthodes pour une gestion efficace du portefeuille.'),
(5, 'BA.655', 'Anglais des Affaires', 'Amélioration de la communication d''affaires en anglais.'),
(6, 'BA.655', 'Comptabilité Financière', 'Fondamentaux de la comptabilité financière incluant bilans et comptes de résultat.'),
(7, 'BA.711', 'Allemand des Affaires', 'Introduction à la terminologie d''affaires en allemand.'),
(8, 'BA.650', 'Outils de Technologie des Affaires', 'Compréhension des outils et plateformes modernes en affaires.'),
(9, 'BA.712', 'Introduction à la Finance d''Entreprise', 'Fondamentaux de la finance d''entreprise et stratégies d''investissement.'),
(10, 'BA.661', 'Marketing Digital', 'Publicité en ligne, SEO et autres stratégies de marketing digital.'),
(11, 'BA.713', 'Principes de Gestion des RH', 'Concepts clés et stratégies en gestion des ressources humaines.'),
(12, 'LEA.9C', 'Bases du Développement Web', 'Introduction aux outils et techniques de développement web.'),
(13, 'LEA.9C', 'Développement Web Avancé', 'Exploration des sujets avancés en développement web.'),
(14, 'LEA.AE', 'Bases de la Sécurité Réseau', 'Introduction aux concepts de sécurité réseau.'),
(15, 'LEA.AE', 'Sécurité Réseau Avancée', 'Étude approfondie des configurations de pare-feu, détection d''intrusions, etc.'),
(16, '420.XX', 'Outils d’Intelligence d’Affaires', 'Introduction aux outils comme Tableau, PowerBI pour l''intelligence d''affaires.'),
(17, '421.XY', 'Protocoles de Sécurité Réseau', 'Étude des différents protocoles et leurs implications en matière de sécurité.'),
(18, 'MA.350', 'Analyse des Marchés Financiers', 'Étude des dynamiques et des facteurs influençant les marchés financiers.'),
(19, 'MA.350', 'Gestion des Risques Financiers', 'Méthodes et stratégies pour identifier, évaluer et gérer les risques dans le secteur financier.'),
(20, 'MA.350', 'Éthique en Finance', 'Examen des principes éthiques et des meilleures pratiques en finance.'),
(21, 'MA.350', 'Innovations en Fintech', 'Exploration des dernières innovations technologiques dans le domaine financier.'),
(22, 'BA.655', 'Stratégies de Communication', 'Développement de compétences en communication d''affaires efficace.'),
(23, 'BA.655', 'Gestion de Projet', 'Principes et outils essentiels pour une gestion de projet réussie.'),
(24, 'BA.655', 'Économie d''Entreprise', 'Introduction aux principaux concepts économiques dans le monde des affaires.'),
(25, 'BA.655', 'Marketing Stratégique', 'Élaboration et mise en œuvre de stratégies marketing efficaces.'),
(26, 'BA.655', 'Leadership et Gestion d’Équipe', 'Techniques et meilleures pratiques pour diriger et motiver une équipe.'),
(27, 'BA.655', 'Droit des Affaires', 'Aperçu des réglementations et des lois régissant le monde des affaires.'),
(28, 'BA.655', 'Analyses des Données d’Affaires', 'Utilisation des données pour prendre des décisions éclairées en affaires.'),
(29, 'BA.655', 'Ventes et Négociations', 'Stratégies et techniques pour réussir dans la vente et la négociation.'),
(30, 'BA.655', 'Innovation et Entrepreneuriat', 'Méthodes pour encourager l''innovation et l''entrepreneuriat.'),
(31, 'BA.655', 'Gestion de la Chaîne Logistique', 'Principes clés et meilleures pratiques en gestion de la chaîne logistique.');

