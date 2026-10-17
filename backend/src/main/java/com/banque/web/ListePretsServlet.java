package com.banque.web;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.banque.model.Pret;
import com.banque.util.DBConnection;

@WebServlet("/listePrets")
public class ListePretsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sIdPret = request.getParameter("searchIdPret");
        String sType = request.getParameter("searchType");
        String sIdClient = request.getParameter("searchIdClient");

        // 1. GESTION DE LA PAGINATION
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }
        int nbParPage = 20;
        int offset = (page - 1) * nbParPage;

        List<Pret> liste = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection()) {
            // --- NOUVEAU : CALCUL DU NOMBRE TOTAL DE PAGES ---
            StringBuilder countSql = new StringBuilder("SELECT COUNT(*) FROM prets WHERE 1=1");
            if (sIdPret != null && !sIdPret.isEmpty()) countSql.append(" AND id_pret = ").append(sIdPret);
            if (sIdClient != null && !sIdClient.isEmpty()) countSql.append(" AND client_id = ").append(sIdClient);
            if (sType != null && !sType.isEmpty()) countSql.append(" AND type = '").append(sType).append("'");

            Statement stCount = conn.createStatement();
            ResultSet rsCount = stCount.executeQuery(countSql.toString());
            int totalRecords = 0;
            if (rsCount.next()) totalRecords = rsCount.getInt(1);
            
            int totalPages = (int) Math.ceil((double) totalRecords / nbParPage);
            // --------------------------------------------------

            // 2. CONSTRUCTION DE LA REQUÊTE PRINCIPALE
            StringBuilder sql = new StringBuilder("SELECT * FROM prets WHERE 1=1");
            if (sIdPret != null && !sIdPret.isEmpty()) sql.append(" AND id_pret = ").append(sIdPret);
            if (sIdClient != null && !sIdClient.isEmpty()) sql.append(" AND client_id = ").append(sIdClient);
            if (sType != null && !sType.isEmpty()) sql.append(" AND type = '").append(sType).append("'");

            sql.append(" LIMIT ").append(nbParPage).append(" OFFSET ").append(offset);

            ResultSet rs = conn.createStatement().executeQuery(sql.toString());
            while (rs.next()) {
                liste.add(new Pret(rs.getInt("id_pret"), rs.getInt("client_id"), rs.getDouble("remboursement"), 
                                  rs.getInt("duree"), rs.getString("type"), rs.getDouble("taux")));
            }
            
            // 3. ENVOI DES ATTRIBUTS
            request.setAttribute("prets", liste);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages); // <--- AJOUTÉ
            
            request.getRequestDispatcher("prets.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }
}