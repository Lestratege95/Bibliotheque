-- Insertion des éditeurs
INSERT INTO editeurs (NS, nom, site_web, groupe, adresse_postale, telephone, telecopie, adresse_messagerie, commentaire)
VALUES
  (1, 'Gallimard', 'https://www.gallimard.fr', 'Groupe Madrigall', '5 Rue Gaston Gallimard, 75007 Paris', '0149393800', '0149393801', 'contact@gallimard.fr', NULL),
  (2, 'Hachette', 'https://www.hachette.fr', 'Groupe Lagardère', '43 Quai de Grenelle, 75015 Paris', '0157571213', NULL, 'contact@hachette.fr', NULL),
  (3, 'Flammarion', 'https://www.flammarion.fr', 'Madrigall', '87 Quai Panhard et Levassor, 75013 Paris', '0140647000', NULL, 'contact@flammarion.fr', NULL);

-- Insertion des collections
INSERT INTO collections (NS, nom, editeur, commentaire)
VALUES
  (1, 'Folio', 1, NULL),
  (2, 'Livre de Poche', 2, NULL),
  (3, 'GF Flammarion', 3, NULL);

-- Insertion des auteurs
INSERT INTO auteurs (NS, nom, prenom, pseudo, naissance, deces, nationalite, biographie, commentaire, photo)
VALUES
  (1, 'Hugo', 'Victor', NULL, '1802-02-26', '1885-05-22', 'Française', 'Grand écrivain français du XIXe siècle.', NULL, NULL),
  (2, 'Camus', 'Albert', NULL, '1913-11-07', '1960-01-04', 'Française', 'Philosophe et écrivain existentialiste.', NULL, NULL),
  (3, 'Zola', 'Émile', NULL, '1840-04-02', '1902-09-29', 'Française', 'Écrivain naturaliste.', NULL, NULL);

-- Insertion des œuvres
INSERT INTO oeuvres (NS, titre, editeur, collection, serie, ordre_dans_serie, parution, format, nombre_de_pages, nature, genre, isbn, code_barre, prix_editeur, resume, commentaire, couverture, langue, prix_actuel)
VALUES
  (1, 'Les Misérables', 1, 1, NULL, NULL, '1862-04-03', 'A5', 1463, 'Roman', 'Historique', '9782070408502', NULL, 25.50, 'Un roman historique et social sur la France du XIXe siècle.', NULL, NULL, 'Français', 22.00),
  (2, 'L'Étranger', 1, 1, NULL, NULL, '1942-05-19', 'Poche', 120, 'Roman', 'Philosophique', '9782070360022', NULL, 8.50, 'Un roman existentiel qui explore l'absurdité de la vie.', NULL, NULL, 'Français', 7.50),
  (3, 'Germinal', 3, 3, NULL, NULL, '1885-03-01', 'A4', 592, 'Roman', 'Naturaliste', '9782080700656', NULL, 18.00, 'Un récit poignant sur la condition ouvrière.', NULL, NULL, 'Français', 15.50);

-- Insertion des propriétaires
INSERT INTO proprietaires (NS, pseudo, mot_de_passe, adresse_email, nom, prenom, adresse, departement, ville, pays, actif)
VALUES
  (1, 'booklover92', 'password123', 'booklover92@email.com', 'Dupont', 'Jean', '12 Rue des Livres, 75005 Paris', 75, 'Paris', 'France', TRUE),
  (2, 'lectrice75', 'securepass', 'lectrice75@email.com', 'Durand', 'Marie', '34 Avenue de la Culture, 75006 Paris', 75, 'Paris', 'France', TRUE),
  (3, 'biblofan', 'readmore', 'biblofan@email.com', 'Martin', 'Paul', '78 Rue du Savoir, 69003 Lyon', 69, 'Lyon', 'France', TRUE);

-- Insertion des possessions
INSERT INTO possessions (NS, oeuvre, proprietaire, nature, nom, date, date_de_retour, prix_acquisition, commentaire)
VALUES
  (1, 1, 1, 'Acquisition', 'Bibliothèque personnelle', '2022-01-15', NULL, 20.00, NULL),
  (2, 2, 2, 'Lecture', 'En cours de lecture', '2023-10-10', NULL, NULL, NULL),
  (3, 3, 3, 'Acquisition', 'Collection privée', '2021-06-20', NULL, 15.00, NULL);

-- Insertion des énumérés
INSERT INTO enumeres (NS, groupe, nom)
VALUES
  (1, 'Genre', 'Roman'),
  (2, 'Genre', 'Poésie'),
  (3, 'Langue', 'Français'),
  (4, 'Langue', 'Anglais'),
  (5, 'Genre', 'Science-fiction'),
  (6, 'Langue', 'Espagnol');

-- Insertion des textes
INSERT INTO textes (NS, type, texte)
VALUES
  (1, 'Résumé', "Un chef-d'œuvre de la littérature française."),
  (2, 'Commentaire', 'Un livre à lire absolument.'),
  (3, 'Résumé', 'Un roman captivant sur la lutte sociale.'),
  (4, 'Commentaire', 'Un texte qui fait réfléchir.');