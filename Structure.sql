-- Création des tables PostgreSQL

CREATE TABLE editeurs (
    NS SERIAL PRIMARY KEY,
    Nom TEXT NOT NULL,
    Site_web TEXT,
    Groupe TEXT,
    Adresse_postale TEXT,
    Téléphone TEXT,
    Télécopie TEXT,
    Adresse_messagerie_électronique TEXT,
    Commentaire TEXT
);

CREATE TABLE collections (
    NS SERIAL PRIMARY KEY,
    Nom TEXT NOT NULL,
    Editeur INTEGER REFERENCES editeurs(NS),
    Commentaire TEXT
);

CREATE TABLE auteurs (
    NS SERIAL PRIMARY KEY,
    Nom TEXT NOT NULL,
    Prénom TEXT,
    Pseudo TEXT,
    Naissance DATE,
    Décès DATE,
    Nationalité TEXT,
    Biographie TEXT,
    Commentaire TEXT,
    Photo BYTEA
);

CREATE TABLE groupes_auteurs (
    Oeuvre INTEGER REFERENCES oeuvres(NS),
    Auteur INTEGER REFERENCES auteurs(NS),
    Fonction TEXT,
    PRIMARY KEY (Oeuvre, Auteur)
);

CREATE TABLE oeuvres (
    NS SERIAL PRIMARY KEY,
    Titre TEXT NOT NULL,
    Editeur INTEGER REFERENCES editeurs(NS),
    Collection INTEGER REFERENCES collections(NS),
    Série INTEGER REFERENCES collections(NS),
    Ordre_dans_la_série INTEGER,
    Parution DATE,
    Format TEXT,
    Nombre_de_pages INTEGER,
    Nature TEXT,
    Genre TEXT,
    ISBN TEXT,
    Code_barre TEXT,
    Prix_éditeur REAL,
    Résumé TEXT,
    Commentaire TEXT,
    Couverture BYTEA,
    Langue TEXT,
    Prix_actuel REAL
);

CREATE TABLE proprietaires (
    NS SERIAL PRIMARY KEY,
    Pseudo TEXT NOT NULL,
    Mot_de_passe TEXT NOT NULL,
    Adresse_email TEXT NOT NULL,
    Nom TEXT NOT NULL,
    Prénom TEXT NOT NULL,
    Adresse TEXT NOT NULL,
    Département INTEGER NOT NULL,
    Ville TEXT NOT NULL,
    Pays TEXT NOT NULL,
    Actif BOOLEAN NOT NULL
);

CREATE TABLE possessions (
    NS SERIAL PRIMARY KEY,
    Oeuvre INTEGER REFERENCES oeuvres(NS),
    Propriétaire INTEGER REFERENCES proprietaires(NS),
    Nature TEXT NOT NULL,
    Nom TEXT,
    Date DATE,
    Date_de_retour DATE,
    Prix_d_acquisition REAL,
    Commentaire TEXT
);

CREATE TABLE enumeres (
    NS SERIAL PRIMARY KEY,
    Groupe TEXT NOT NULL,
    Nom TEXT NOT NULL
);

CREATE TABLE textes (
    NS SERIAL PRIMARY KEY,
    Type TEXT NOT NULL,
    Texte TEXT NOT NULL
);

-- Déclencheurs pour EX13 (nettoyage des orphelins)
CREATE OR REPLACE FUNCTION nettoyer_orphelins() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM collections WHERE Editeur NOT IN (SELECT NS FROM editeurs);
    DELETE FROM oeuvres WHERE Editeur NOT IN (SELECT NS FROM editeurs);
    DELETE FROM groupes_auteurs WHERE Auteur NOT IN (SELECT NS FROM auteurs);
    DELETE FROM possessions WHERE Oeuvre NOT IN (SELECT NS FROM oeuvres);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_nettoyage
AFTER DELETE ON editeurs
FOR EACH ROW EXECUTE FUNCTION nettoyer_orphelins();

-- Vues pour EX09 (listes alphabétiques)
CREATE VIEW vue_auteurs_alphabetiques AS
SELECT * FROM auteurs ORDER BY Nom, Prénom;

CREATE VIEW vue_editeurs_alphabetiques AS
SELECT * FROM editeurs ORDER BY Nom;

CREATE VIEW vue_oeuvres_alphabetiques AS
SELECT * FROM oeuvres ORDER BY Titre;

-- Scripts Python pour EX10 (import de fichiers/APIs)
-- Ces scripts doivent être exécutés en dehors de PostgreSQL
-- Exemple de script Python pour l'import de fichiers CSV

import csv
import psycopg2

def importer_csv(fichier, table):
    conn = psycopg2.connect(dbname='ta_base', user='ton_utilisateur', password='ton_mot_de_passe', host='localhost')
    cur = conn.cursor()
    with open(fichier, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        colonnes = next(reader)
        requete = f"INSERT INTO {table} ({', '.join(colonnes)}) VALUES ({', '.join(['%s'] * len(colonnes))})"
        for ligne in reader:
            cur.execute(requete, ligne)
        conn.commit()
        cur.close()
        conn.close()

# Exemple d'utilisation
# importer_csv('auteurs.csv', 'auteurs')
