package com.banque.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.banque.util.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Récupérer les données du formulaire index.jsp
        String log = request.getParameter("login");
        String pass = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            // 2. Vérifier si l'utilisateur existe dans la table 'utilisateurs' de WAMP
            String sql = "SELECT nom_complet FROM utilisateurs WHERE login=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, log);
            ps.setString(2, pass);
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // 3. Si trouvé, on crée une session et on va vers le menu
                HttpSession session = request.getSession();
                session.setAttribute("adminConnecte", rs.getString("nom_complet"));
                response.sendRedirect("menu");
            } else {
                // 4. Si non trouvé, on revient au login avec un message
                response.sendRedirect("index.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=db");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}