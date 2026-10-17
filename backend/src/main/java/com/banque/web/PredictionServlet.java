package com.banque.web;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.banque.model.*;
import com.banque.service.PredictionService;
import com.banque.util.DBConnection;

@WebServlet("/predire")
public class PredictionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("idClient");
        if (idParam == null) {
            response.sendRedirect("listeClients");
            return;
        }
        int idClient = Integer.parseInt(idParam);
        
        Client client = null;
        Pret pret = null;
        
        try (Connection conn = DBConnection.getConnection()) {
            // 1. Récupérer le Client (pour le REVENU)
            String sqlClient = "SELECT * FROM clients WHERE identifiant = ?";
            PreparedStatement ps1 = conn.prepareStatement(sqlClient);
            ps1.setInt(1, idClient);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                client = new Client(rs1.getInt("identifiant"), rs1.getString("ville"), rs1.getString("cp"), rs1.getDouble("revenu"));
            }

            // 2. Récupérer le Prêt (avec taux et type en String)
            String sqlPret = "SELECT * FROM prets WHERE client_id = ? LIMIT 1";
            PreparedStatement ps2 = conn.prepareStatement(sqlPret);
            ps2.setInt(1, idClient);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                pret = new Pret(
                    rs2.getInt("id_pret"), 
                    rs2.getInt("client_id"), 
                    rs2.getDouble("remboursement"), 
                    rs2.getInt("duree"), 
                    rs2.getString("type"),
                    rs2.getDouble("taux") 
                );
            }

            if (client != null && pret != null) {
                PredictionService service = new PredictionService();
                // On récupère le score brut de l'API Flask (souvent "0" ou "1")
                String resultatBrut = service.predireRisque(client, pret);
                
                // --- LOGIQUE DE TRADUCTION POUR LE DESIGN JSP ---
                String verdictFinal;
                // On nettoie la chaîne et on vérifie si c'est "0" (Risque Faible)
                if (resultatBrut != null && resultatBrut.trim().equals("0")) {
                    verdictFinal = "Risque Faible"; // Sera affiché en BLEU par resultat.jsp
                } else {
                    verdictFinal = "Risque Eleve";  // Sera affiché en ROUGE par resultat.jsp
                }
                
                request.setAttribute("idClient", idClient);
                request.setAttribute("score", verdictFinal); // Envoi du texte traduit
                request.getRequestDispatcher("resultat.jsp").forward(request, response);
                
            } else {
                response.getWriter().println("Donnees incompletes en base pour ce client.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur : " + e.getMessage());
        }
    }
}