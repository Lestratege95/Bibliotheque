from flask import Flask, render_template, request, redirect, url_for
import psycopg2

app = Flask(__name__)

# Connexion à la base de données PostgreSQL
def get_db_connection():
    return psycopg2.connect(
        dbname='votre_base', user='votre_utilisateur', password='votre_mot_de_passe', host='localhost'
    )

# Routes pour afficher les listes
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/editeurs')
def liste_editeurs():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM editeurs LIMIT 20")
    editeurs = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('liste_editeurs.html', editeurs=editeurs)

@app.route('/auteurs')
def liste_auteurs():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM auteurs LIMIT 20")
    auteurs = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('liste_auteurs.html', auteurs=auteurs)

# Route pour afficher les informations détaillées
@app.route('/editeur/<int:id>')
def info_editeur(id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM editeurs WHERE NS = %s", (id,))
    editeur = cur.fetchone()
    cur.close()
    conn.close()
    return render_template('info_editeur.html', editeur=editeur)

# Route pour ajouter un éditeur
@app.route('/ajouter_editeur', methods=['GET', 'POST'])
def ajouter_editeur():
    if request.method == 'POST':
        nom = request.form['nom']
        site_web = request.form['site_web']
        groupe = request.form['groupe']
        adresse_postale = request.form['adresse_postale']
        
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("INSERT INTO editeurs (nom, site_web, groupe, adresse_postale) VALUES (%s, %s, %s, %s)",
                    (nom, site_web, groupe, adresse_postale))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('liste_editeurs'))
    return render_template('ajouter_editeur.html')

if __name__ == '__main__':
    app.run(debug=True)

# HTML Templates
