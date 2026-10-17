package com.banque.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Récupérer la session actuelle
        HttpSession session = request.getSession(false);
        if (session != null) {
            // 2. Détruire la session (supprime les données de l'admin)
            session.invalidate();
        }
        // 3. Rediriger vers la page de login
        response.sendRedirect("index.jsp");
    }
}