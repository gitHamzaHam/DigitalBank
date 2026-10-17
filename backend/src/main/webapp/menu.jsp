<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        /* Style des cartes */
        .card { 
            border-radius: 12px; 
            border: none; 
            transition: transform 0.2s, box-shadow 0.2s;
            background: white;
        }
        .card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; 
        }
        
        .icon-circle {
            width: 80px;
            height: 80px;
            background-color: #f8f9fa;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
        }

        /* On s'assure que la navbar a la même ombre et taille que la page Prêts */
        .navbar { padding-top: 0.5rem; padding-bottom: 0.5rem; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="menu.jsp">🏦 DigitalBank</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link active" href="menu.jsp">Accueil</a>
                <a class="nav-link text-danger ms-3 fw-bold" href="logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="text-center mb-5">
            <h1 class="fw-bold text-dark display-5">Tableau de Bord</h1>
            <p class="text-muted">Sélectionnez un module pour commencer la gestion</p>
        </div>
        
        <div class="row g-4 justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card shadow-sm p-4 text-center">
                    <div class="icon-circle">👥</div>
                    <h3 class="fw-bold text-dark">Gestion des Clients</h3>
                    <p class="text-muted small">Accédez au répertoire complet de vos clients.</p>
                    <a href="listeClients?page=1" class="btn btn-dark btn-lg mt-3 fw-bold w-100">Ouvrir</a>
                </div>
            </div>

            <div class="col-md-5 col-lg-4">
                <div class="card shadow-sm p-4 text-center">
                    <div class="icon-circle">💰</div>
                    <h3 class="fw-bold text-dark">Analyse des Prêts</h3>
                    <p class="text-muted small">Analyse des risques et gestion des dossiers.</p>
                    <a href="listePrets" class="btn btn-dark btn-lg mt-3 fw-bold w-100">Ouvrir</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>