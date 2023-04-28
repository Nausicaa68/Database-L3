package App_planning;

import java.sql.*;
import java.util.Scanner;

public class App_planning {
	
	public static void main(String[] args) {
		try {
			// chargement du driver 
			Class.forName("com.mysql.jdbc.Driver");
			// cr�ation de la connexion
			Connection connex = DriverManager.getConnection("jdbc:mysql://localhost/App_planning_dumas_grelaud", "root", "root");
			//cr�ation de l'�tat de connexion
			Statement st = connex.createStatement();

			Scanner sc = new Scanner(System.in);
			String mot = "";
			
			do {
				System.out.println("Entrez votre id d'utilisateur (ex: 1)");	
				mot = sc.nextLine();
			}while(Integer.parseInt(mot) < 0 || Integer.parseInt(mot) > 10);
			
			
			//requete de s�lection
			ResultSet res = st.executeQuery("select distinct nom, prenom, nom_loisir\r\n" + 
					"from personne join amitie join loisir_commun\r\n" + 
					"on personne.idPersonne = amitie.idPersonne and loisir_commun.id_amitie = amitie.id_amitie\r\n" + 
					"where amitie.idUtilisateur = " + mot +";" );
			
			// parcours des donn�es
			while(res.next()) {
				System.out.println("Info de l'amis : Nom : " + res.getString(1) + "Pr�nom : " + res.getString(2) + "Loisir commun : " + res.getString(3));
			}
		}
		catch (Exception e){
			System.out.println("Erreur :" + e.getMessage() );			
		}
		
	}

}
