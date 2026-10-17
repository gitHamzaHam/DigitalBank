package com.banque.model;

public class Client {
    private int id;
    private String ville;
    private String cp;
    private double revenu;

    // Ce constructeur doit correspondre à la Servlet
    public Client(int id, String ville, String cp, double revenu) {
        this.id = id;
        this.ville = ville;
        this.cp = cp;
        this.revenu = revenu;
    }

    // Getters pour PredictionService
    public int getId() { return id; }
    public String getVille() { return ville; }
    public String getCp() { return cp; }
    public double getRevenu() { return revenu; }
}