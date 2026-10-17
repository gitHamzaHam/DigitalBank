package com.banque.service;

import com.banque.model.Pret;
import com.banque.model.Client;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.net.URI;
import java.net.http.*;

public class PredictionService {
    // Constructeur vide par défaut (ne rien ecrire ici)

	public String predireRisque(Client client, Pret pret) {
	    try {
	        // 1. Préparer le JSON
	        JsonObject data = new JsonObject();
	        data.addProperty("revenu", client.getRevenu()); 
	        data.addProperty("remboursement", pret.getRemboursement());
	        data.addProperty("duree", pret.getDuree());
	        data.addProperty("taux", pret.getTaux());
	        int typeEncoded = pret.getType().equalsIgnoreCase("immobilier") ? 1 : 0;
	        data.addProperty("type", typeEncoded);

	        // 2. Envoyer via URL (Plus stable que HttpClient dans ton cas)
	        java.net.URL url = new java.net.URL("http://127.0.0.1:5000/predict");
	        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setDoOutput(true);

	        try(java.io.OutputStream os = conn.getOutputStream()) {
	            byte[] input = data.toString().getBytes("utf-8");
	            os.write(input, 0, input.length);           
	        }

	        // 3. Lire la réponse
	        java.util.Scanner s = new java.util.Scanner(conn.getInputStream()).useDelimiter("\\A");
	        String response = s.hasNext() ? s.next() : "";
	        
	        JsonObject result = JsonParser.parseString(response).getAsJsonObject();
	        return result.get("risk_score").getAsString();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "Erreur de connexion avec Flask (Vérifie Anaconda)";
	    }
	}
}