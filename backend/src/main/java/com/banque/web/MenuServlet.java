package com.banque.web;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.banque.util.DBConnection;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminConnecte") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            // 1. Total clients
            ResultSet rs1 = conn.createStatement().executeQuery("SELECT COUNT(*) FROM clients");
            int totalClients = rs1.next() ? rs1.getInt(1) : 0;

            // 2. Total prêts + répartition par type + taux moyen
            ResultSet rs2 = conn.createStatement().executeQuery(
                "SELECT COUNT(*) as total, " +
                "SUM(CASE WHEN type='IMMOBILIER' THEN 1 ELSE 0 END) as immo, " +
                "SUM(CASE WHEN type='AUTOMOBILE' THEN 1 ELSE 0 END) as auto_, " +
                "AVG(CASE WHEN type='IMMOBILIER' THEN taux END) as avgTauxImmo, " +
                "AVG(CASE WHEN type='AUTOMOBILE' THEN taux END) as avgTauxAuto " +
                "FROM prets"
            );

            int totalPrets = 0, countImmo = 0, countAuto = 0;
            double avgTauxImmo = 0.0, avgTauxAuto = 0.0;

            if (rs2.next()) {
                totalPrets   = rs2.getInt("total");
                countImmo    = rs2.getInt("immo");
                countAuto    = rs2.getInt("auto_");
                avgTauxImmo  = rs2.getDouble("avgTauxImmo");
                avgTauxAuto  = rs2.getDouble("avgTauxAuto");
            }

            // Envoi des attributs au JSP
            request.setAttribute("totalClients", totalClients);
            request.setAttribute("totalPrets",   totalPrets);
            request.setAttribute("countImmo",    countImmo);
            request.setAttribute("countAuto",    countAuto);
            request.setAttribute("avgTauxImmo",  String.format("%.2f", avgTauxImmo));
            request.setAttribute("avgTauxAuto",  String.format("%.2f", avgTauxAuto));

            request.getRequestDispatcher("menu.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("menu.jsp").forward(request, response);
        }
    }
}
