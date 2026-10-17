<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Résultat IA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f8f9fa; 
            color: #212529; 
            min-height: 100vh; 
            display: flex; 
            align-items: center; 
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        
        .result-card { 
            background: white; 
            border-radius: 20px; 
            width: 100%; 
            max-width: 500px; 
            padding: 40px; 
            text-align: center; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .verdict { 
            font-size: 2.2rem; 
            font-weight: 800; 
            padding: 20px; 
            border-radius: 15px; 
            margin: 25px 0;
            text-transform: uppercase;
        }
        
        .score-faible { 
            background-color: #d1ecf1; 
            color: #0c5460; 
            border: 2px solid #bee5eb; 
        }
        
        .score-eleve { 
            background-color: #f8d7da; 
            color: #721c24; 
            border: 2px solid #f5c6cb; 
        }
        
        .btn-return {
            font-weight: 700;
            border-width: 2px;
        }
    </style>
</head>
<body>

    <div class="result-card">
        <h2 class="fw-bold">Analyse de Solvabilité</h2>
        <p class="text-muted">Résultat généré par le moteur prédictif IA</p>
        
        <div class="verdict ${score == 'Risque Faible' ? 'score-faible' : 'score-eleve'}">
            ${score}
        </div>
        
        <p class="small text-secondary mb-4">Analyse effectuée pour le client #${idClient}</p>
        
        <div class="d-grid gap-2">
            <a href="menu.jsp" class="btn btn-dark btn-return py-2 shadow-sm">
                Retour au Tableau de Bord
            </a>
            <a href="listePrets" class="btn btn-outline-secondary btn-sm border-0">
                Consulter les autres prêts
            </a>
        </div>
    </div>

</body>
</html>