package com.banque.web;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.banque.model.Client;
import com.banque.util.DBConnection;

@WebServlet("/listeClients")
public class ListeClientsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sId = request.getParameter("searchId");
        String sVille = request.getParameter("searchVille");
        
        // 1. GESTION DE LA PAGINATION
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }
        int nbParPage = 20;
        int offset = (page - 1) * nbParPage;

        List<Client> listeClients = new ArrayList<>();
        List<String> listeVilles = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            // Récupérer les villes uniques
            ResultSet rsV = conn.createStatement().executeQuery("SELECT DISTINCT ville FROM clients ORDER BY ville");
            while (rsV.next()) listeVilles.add(rsV.getString("ville"));

            // Nombre total de clients (pour le KPI dashboard)
            ResultSet rsTotalClients = conn.createStatement().executeQuery("SELECT COUNT(*) FROM clients");
            int totalClients = 0;
            if (rsTotalClients.next()) totalClients = rsTotalClients.getInt(1);

            // CALCUL DU NOMBRE TOTAL DE PAGES
            StringBuilder countSql = new StringBuilder("SELECT COUNT(*) FROM clients WHERE 1=1");
            if (sId != null && !sId.isEmpty()) countSql.append(" AND identifiant = ").append(Integer.parseInt(sId));
            if (sVille != null && !sVille.isEmpty()) countSql.append(" AND ville = '").append(sVille).append("'");
            
            Statement stCount = conn.createStatement();
            ResultSet rsCount = stCount.executeQuery(countSql.toString());
            int totalRecords = 0;
            if (rsCount.next()) totalRecords = rsCount.getInt(1);
            
            int totalPages = (int) Math.ceil((double) totalRecords / nbParPage);

            // 2. CONSTRUCTION DE LA REQUÊTE PRINCIPALE
            StringBuilder sql = new StringBuilder("SELECT * FROM clients WHERE 1=1");
            if (sId != null && !sId.isEmpty()) sql.append(" AND identifiant = ").append(Integer.parseInt(sId));
            if (sVille != null && !sVille.isEmpty()) sql.append(" AND ville = '").append(sVille).append("'");
            
            sql.append(" LIMIT ").append(nbParPage).append(" OFFSET ").append(offset);

            ResultSet rsC = conn.createStatement().executeQuery(sql.toString());
            while (rsC.next()) {
                listeClients.add(new Client(rsC.getInt("identifiant"), rsC.getString("ville"), rsC.getString("cp"), rsC.getDouble("revenu")));
            }
            
            // 3. ENVOI DES ATTRIBUTS AU JSP
            request.setAttribute("clients", listeClients);
            request.setAttribute("villes", listeVilles);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalClients", totalClients); // <--- KPI dashboard
            
            request.getRequestDispatcher("clients.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }
}