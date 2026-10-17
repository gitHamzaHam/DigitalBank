<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Gestion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }
        .navbar-brand { font-weight: 700; letter-spacing: -1px; }
        .card { border: none; shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); }
    </style>
</head>
<div style="display: flex; justify-content: space-between; align-items: center; 
            background-color: #2c3e50; color: white; padding: 15px 30px; 
            font-family: Arial, sans-serif; margin-bottom: 20px;">
    
    <div style="font-size: 1.2em; font-weight: bold;">🏦 DigitalBank - Gestionnaire</div>
    
    <div style="display: flex; align-items: center; gap: 20px;">
        <span>👤 Connecté : <strong>${sessionScope.adminConnecte}</strong></span>
        <a href="logout" style="background-color: #e74c3c; color: white; 
           padding: 8px 15px; border-radius: 5px; text-decoration: none; 
           font-size: 0.9em;">Déconnexion</a>
    </div>
</div>