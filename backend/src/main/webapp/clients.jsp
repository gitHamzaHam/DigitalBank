<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Clients</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .table-container { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .badge-client { background-color: #e0f2fe; color: #0369a1; border: 1px solid #bae6fd; }
        /* Pour s'assurer que les textes restent bien noirs dans le tableau */
        .table td { color: #000000 !important; }
        /* Style pour la pagination */
        .page-link { color: #212529; border: 1px solid #dee2e6; }
        .page-item.active .page-link { background-color: #212529; border-color: #212529; color: white; }
        .page-link:hover { background-color: #e9ecef; color: #000; }
    </style>
</head>
<body>
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

    <div class="container pb-5">
        <div class="card p-4 mb-4 border-0 shadow-sm">
            <form action="listeClients" method="get" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold">ID Client</label>
                    <input type="number" name="searchId" class="form-control" placeholder="ID..." value="${param.searchId}">
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Ville</label>
                    <select name="searchVille" class="form-select">
                        <option value="">Toutes les villes</option>
                        <c:forEach var="v" items="${villes}">
                            <option value="${v}" ${param.searchVille == v ? 'selected' : ''}>${v}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-dark w-100 fw-bold">Filtrer</button>
                </div>
            </form>
        </div>
<div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="text-dark fw-bold m-0">Liste des Clients</h3>
    <a href="ajouterClient.jsp" class="btn btn-success fw-bold shadow-sm">
        <i class="fas fa-plus-circle"></i> Ajouter un Client
    </a>
</div>
        <div class="table-container shadow-sm">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="text-dark">Identifiant</th>
                        <th class="text-dark">Ville</th>
                        <th class="text-dark">CP</th>
                        <th class="text-dark">Revenu</th>
                        <th class="text-center text-dark">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${clients}">
                        <tr>
                            <td><span class="fw-bold text-dark">#${c.id}</span></td>
                            <td><span class="badge rounded-pill badge-client p-2 px-3 text-uppercase">${c.ville}</span></td>
                            <td class="text-dark">${c.cp}</td>
                            <td>${c.revenu} €</td>
                            
                            <td class="text-center">
                                <div class="btn-group shadow-sm">
                                    <a href="listePrets?searchIdClient=${c.id}" class="btn btn-sm btn-outline-dark" title="Voir les prêts">
                                        <i class="fas fa-coins"></i>
                                    </a>
                                    <a href="editerClient.jsp?id=${c.id}&ville=${c.ville}&cp=${c.cp}&revenu=${c.revenu}" class="btn btn-sm btn-outline-primary" title="Modifier">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="supprimerClient?id=${c.id}" class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Supprimer définitivement ce client ?')" title="Supprimer">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
    <span class="text-secondary small">
        Page <strong>${currentPage}</strong> sur <strong>${totalPages}</strong> 
        (${clients.size() == 0 ? 0 : (currentPage-1)*20 + 1} - ${(currentPage-1)*20 + clients.size()})
    </span>
    <nav>
        <ul class="pagination mb-0">
            <%-- Bouton Précédent --%>
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link shadow-sm" href="listeClients?page=${currentPage - 1}&searchId=${param.searchId}&searchVille=${param.searchVille}">
                    &laquo; Précédent
                </a>
            </li>
            
            <%-- Bouton Suivant --%>
            <%-- On compare la page actuelle au nombre total de pages --%>
            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link shadow-sm" href="listeClients?page=${currentPage + 1}&searchId=${param.searchId}&searchVille=${param.searchVille}">
                    Suivant &raquo;
                </a>
            </li>
        </ul>
    </nav>
</div>
        </div>
    </div>
</body>
</html>