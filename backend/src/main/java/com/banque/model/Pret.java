package com.banque.model;

public class Pret {
    private int idPret;
    private int clientId;
    private double remboursement;
    private int duree;
    private String type; // Doit être String
    private double taux; // Doit être double

    // Constructeur mis à jour pour correspondre à PredictionServlet
    public Pret(int idPret, int clientId, double remboursement, int duree, String type, double taux) {
        this.idPret = idPret;
        this.clientId = clientId;
        this.remboursement = remboursement;
        this.duree = duree;
        this.type = type;
        this.taux = taux;
    }

    public int getIdPret() { return idPret; }
    public int getClientId() { return clientId; }
    public double getRemboursement() { return remboursement; }
    public int getDuree() { return duree; }
    public String getType() { return type; }
    public double getTaux() { return taux; }
}