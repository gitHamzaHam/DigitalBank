<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Modifier Dossier</title>
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
            <h3 class="fw-bold text-dark mb-4 text-center">Modifier le Dossier Client #${param.id}</h3>
            
            
            <form action="sauvegarderClient" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${param.id}">

                <div class="row">
                    <div class="col-md-6 border-end">
                        <h5 class="text-primary mb-3"><i class="fas fa-user"></i> Informations Client</h5>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Ville</label>
                            <select name="ville" class="form-select" required>
                                <option value="PARIS" ${param.ville == 'PARIS' ? 'selected' : ''}>PARIS</option>
                                <option value="LYON" ${param.ville == 'LYON' ? 'selected' : ''}>LYON</option>
                                <option value="MARSEILLE" ${param.ville == 'MARSEILLE' ? 'selected' : ''}>MARSEILLE</option>
                                <option value="TOULOUSE" ${param.ville == 'TOULOUSE' ? 'selected' : ''}>TOULOUSE</option>
                                <option value="NICE" ${param.ville == 'NICE' ? 'selected' : ''}>NICE</option>
                                <option value="BORDEAUX" ${param.ville == 'BORDEAUX' ? 'selected' : ''}>BORDEAUX</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Code Postal</label>
                            <input type="text" name="cp" class="form-control" value="${param.cp}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Revenu Mensuel (€)</label>
                            <input type="number" step="0.01" name="revenu" class="form-control" value="${param.revenu}" required>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <h5 class="text-success mb-3"><i class="fas fa-hand-holding-usd"></i> Détails du Prêt</h5>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Type de Prêt</label>
                            <select name="type" class="form-select" required>
                                <option value="IMMOBILIER" ${param.type == 'IMMOBILIER' ? 'selected' : ''}>IMMOBILIER</option>
                                <option value="AUTOMOBILE" ${param.type == 'AUTOMOBILE' ? 'selected' : ''}>AUTOMOBILE</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mensualité (Remboursement)</label>
                            <input type="number" step="0.01" name="remboursement" class="form-control" value="${param.remboursement}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Durée (mois)</label>
                            <input type="number" name="duree" class="form-control" value="${param.duree}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Taux (%)</label>
                            <input type="number" step="0.01" name="taux" class="form-control" value="${param.taux}" required>
                        </div>
                    </div>
                </div>

                <hr class="my-4">

                <div class="row justify-content-center">
                    <div class="col-md-6 d-grid gap-2">
                        <button type="submit" class="btn btn-dark fw-bold py-2 shadow-sm">
                            <i class="fas fa-save me-2"></i> Sauvegarder les modifications
                        </button>
                        <a href="listeClients" class="btn btn-outline-secondary">Annuler</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>