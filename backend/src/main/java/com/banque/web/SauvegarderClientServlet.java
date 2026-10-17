package com.banque.web;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.banque.util.DBConnection;

@WebServlet("/sauvegarderClient")
public class SauvegarderClientServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Données Client
        String ville = request.getParameter("ville");
        String cp = request.getParameter("cp");
        double revenu = Double.parseDouble(request.getParameter("revenu"));

        // Données Prêt
        String type = request.getParameter("type");
        double remboursement = Double.parseDouble(request.getParameter("remboursement"));
        int duree = Integer.parseInt(request.getParameter("duree"));
        double taux = Double.parseDouble(request.getParameter("taux"));

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Transaction sécurisée

            if ("add".equals(action)) {
                // INSERT CLIENT
                String sqlCli = "INSERT INTO clients (ville, cp, revenu) VALUES (?, ?, ?)";
                PreparedStatement ps1 = conn.prepareStatement(sqlCli, Statement.RETURN_GENERATED_KEYS);
                ps1.setString(1, ville);
                ps1.setString(2, cp);
                ps1.setDouble(3, revenu);
                ps1.executeUpdate();

                ResultSet rs = ps1.getGeneratedKeys();
                if (rs.next()) {
                    int newId = rs.getInt(1);
                    // INSERT PRÊT
                    String sqlPret = "INSERT INTO prets (client_id, remboursement, duree, type, taux) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement ps2 = conn.prepareStatement(sqlPret);
                    ps2.setInt(1, newId);
                    ps2.setDouble(2, remboursement);
                    ps2.setInt(3, duree);
                    ps2.setString(4, type);
                    ps2.setDouble(5, taux);
                    ps2.executeUpdate();
                }
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                
                // UPDATE CLIENT
                String sqlUpCli = "UPDATE clients SET ville=?, cp=?, revenu=? WHERE identifiant=?";
                PreparedStatement psU1 = conn.prepareStatement(sqlUpCli);
                psU1.setString(1, ville);
                psU1.setString(2, cp);
                psU1.setDouble(3, revenu);
                psU1.setInt(4, id);
                psU1.executeUpdate();

                // UPDATE PRÊT
                String sqlUpPret = "UPDATE prets SET remboursement=?, duree=?, type=?, taux=? WHERE client_id=?";
                PreparedStatement psU2 = conn.prepareStatement(sqlUpPret);
                psU2.setDouble(1, remboursement);
                psU2.setInt(2, duree);
                psU2.setString(3, type);
                psU2.setDouble(4, taux);
                psU2.setInt(5, id);
                psU2.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listeClients");
    }
}