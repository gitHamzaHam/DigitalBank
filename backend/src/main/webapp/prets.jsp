<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DigitalBank - Prêts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .table-container { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .badge-immo { background-color: #d1ecf1 !important; color: #0c5460 !important; border: 1px solid #bee5eb; }
        .badge-auto { background-color: #fef3c7 !important; color: #92400e !important; border: 1px solid #fde68a; }
        .table td, .table th { vertical-align: middle !important; }
        .badge-custom { min-width: 110px; display: inline-block; font-weight: 600; }
        /* Style pagination */
        .page-link { color: #212529; }
        .page-item.active .page-link { background-color: #212529; border-color: #212529; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="menu.jsp">🏦 DigitalBank</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="menu.jsp">Accueil</a>
                <a class="nav-link" href="listeClients?page=1">Clients</a>
                <a class="nav-link active" href="listePrets">Prêts</a>
                <a class="nav-link text-danger ms-3 fw-bold" href="logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <div class="card p-4 mb-4 border-0 shadow-sm">
            <form action="listePrets" method="get" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold">ID Prêt</label>
                    <input type="number" name="searchIdPret" class="form-control" placeholder="ID..." value="${param.searchIdPret}">
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold">Type</label>
                    <select name="searchType" class="form-select">
                        <option value="">Tous</option>
                        <option value="IMMOBILIER" ${param.searchType == 'IMMOBILIER' ? 'selected' : ''}>Immobilier</option>
                        <option value="AUTOMOBILE" ${param.searchType == 'AUTOMOBILE' ? 'selected' : ''}>Automobile</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-dark w-100 fw-bold">Filtrer</button>
                </div>
            </form>
        </div>

        <div class="table-container shadow-sm p-3 bg-white rounded">
            <table class="table table-hover mb-0"> 
                <thead class="table-light">
                    <tr class="text-secondary">
                        <th>ID Prêt</th>
                        <th>Client ID</th>
                        <th>Mensualité</th>
                        <th>Durée</th>
                        <th class="text-center">Type</th> 
                        <th class="text-center">Taux</th> 
                        <th class="text-center">Analyse</th> 
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${prets}">
                        <tr>
                            <td><span class="fw-bold text-dark">#${p.idPret}</span></td>
                            <td>${p.clientId}</td>
                            <td>${p.remboursement} €</td>
                            <td>${p.duree} mois</td>
                            <td class="text-center">
                                <span class="badge rounded-pill p-2 px-3 text-uppercase badge-custom 
                                    ${p.type.toUpperCase() == 'IMMOBILIER' ? 'badge-immo' : 'badge-auto'}">
                                    ${p.type}
                                </span>
                            </td>
                            <td class="text-center">${p.taux} %</td>
                            <td class="text-center">
                                <a href="predire?idClient=${p.clientId}" class="btn btn-sm btn-outline-dark fw-bold px-3">
                                    Prédire le Risque
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
    <span class="text-secondary small">
        Page <strong>${currentPage}</strong> sur <strong>${totalPages != 0 ? totalPages : 1}</strong>
    </span>
    <nav>
        <ul class="pagination mb-0">
            <%-- Bouton Précédent --%>
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link shadow-sm" href="listePrets?page=${currentPage - 1}&searchIdPret=${param.searchIdPret}&searchType=${param.searchType}&searchIdClient=${param.searchIdClient}">
                    &laquo; Précédent
                </a>
            </li>
            
            <%-- Bouton Suivant : Désactivé si on atteint la dernière page --%>
            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link shadow-sm" href="listePrets?page=${currentPage + 1}&searchIdPret=${param.searchIdPret}&searchType=${param.searchType}&searchIdClient=${param.searchIdClient}">
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