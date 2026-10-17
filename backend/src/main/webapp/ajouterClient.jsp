<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Nouveau Client & Prêt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background-color: #f8f9fa;">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="menu.jsp">🏦 DigitalBank</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="menu.jsp">Accueil</a>
                <a class="nav-link active" href="listeClients?page=1">Clients</a>
                <a class="nav-link" href="listePrets">Prêts</a>
                <a class="nav-link text-danger ms-3 fw-bold" href="logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 pb-5">
        <div class="card shadow border-0 p-4 mx-auto" style="max-width: 800px; border-radius: 15px;">
            <h3 class="fw-bold text-dark mb-4 text-center">🆕 Nouveau Dossier Client</h3>
            
            <form action="sauvegarderClient" method="post">
                <input type="hidden" name="action" value="add">

                <div class="row">
                    <div class="col-md-6 border-end">
                        <h5 class="text-primary mb-3"><i class="fas fa-user"></i> Informations du Client</h5>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Ville</label>
                            <select name="ville" class="form-select" required>
                                <option value="PARIS">PARIS</option>
                                <option value="LYON">LYON</option>
                                <option value="MARSEILLE">MARSEILLE</option>
                                <option value="TOULOUSE">TOULOUSE</option>
                                <option value="NICE">NICE</option>
                                <option value="BORDEAUX">BORDEAUX</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Code Postal</label>
                            <input type="text" name="cp" class="form-control" placeholder="Ex: 75000" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Revenu Mensuel (€)</label>
                            <input type="number" step="0.01" name="revenu" class="form-control" placeholder="Ex: 3000" required>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <h5 class="text-success mb-3"><i class="fas fa-hand-holding-usd"></i> Détails du Prêt</h5>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Type de Prêt</label>
                            <select name="type" class="form-select" required>
                                <option value="IMMOBILIER">IMMOBILIER</option>
                                <option value="AUTOMOBILE">AUTOMOBILE</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mensualité (€)</label>
                            <input type="number" step="0.01" name="remboursement" class="form-control" placeholder="Ex: 800" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Durée (mois)</label>
                            <input type="number" name="duree" class="form-control" placeholder="Ex: 120" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Taux (%)</label>
                            <input type="number" step="0.01" name="taux" class="form-control" placeholder="Ex: 1.5" required>
                        </div>
                    </div>
                </div>

                <hr class="my-4">

                <div class="row justify-content-center">
                    <div class="col-md-6 d-grid gap-2">
                        <button type="submit" class="btn btn-dark fw-bold py-2 shadow-sm">
                            <i class="fas fa-save me-2"></i> Sauvegarder
                        </button>
                        <a href="listeClients" class="btn btn-outline-secondary">Annuler</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>