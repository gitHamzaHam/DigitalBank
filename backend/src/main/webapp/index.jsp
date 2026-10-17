<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Connexion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Fond gris clair identique aux pages Clients et Prêts */
        body { 
            background-color: #f8f9fa; 
            height: 100vh; 
            display: flex; 
            align-items: center; 
            font-family: 'Segoe UI', sans-serif; 
        }
        
        /* Carte blanche avec ombre légère */
        .card { 
            border-radius: 15px; 
            border: none; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card p-4">
                    <div class="text-center mb-4">
                        <h2 class="fw-bold text-dark">🏦 DigitalBank</h2>
                        <p class="text-muted">Accès Administration</p>
                    </div>
                    <form action="login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Identifiant</label>
                            <input type="text" name="login" class="form-control" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold">Mot de passe</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-dark w-100 py-2 fw-bold">Se connecter</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>