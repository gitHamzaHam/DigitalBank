package com.banque.util;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Paramètres de connexion à ta base WAMP
    private static String url = "jdbc:mysql://localhost:3306/digitalbank";
    private static String user = "root";
    private static String password = "root";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Chargement du driver 
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Erreur de connexion : " + e.getMessage());
        }
        return conn;
    }
}