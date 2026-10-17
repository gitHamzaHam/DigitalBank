<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="_layout.jsp" %>
    <script>document.getElementById('nav-prets').classList.add('nav-link-active');</script>

    <style>
        .avatar {
            width: 34px; height: 34px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.7rem; font-weight: 800; flex-shrink: 0;
        }
        .taux-bar { height: 4px; border-radius: 9999px; background: #e2e8f0; min-width: 48px; }
        .taux-fill { height: 100%; border-radius: 9999px; }
        .risk-low  { background:#dcfce7; color:#15803d; }
        .risk-mid  { background:#fef9c3; color:#a16207; }
        .risk-high { background:#fee2e2; color:#b91c1c; }
    </style>

    <main class="max-w-7xl mx-auto px-6 py-10">

        <!-- Page Header -->
        <div class="flex items-center justify-between mb-8">
            <div>
                <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Analyse des Prêts</h1>
                <p class="text-slate-500 text-sm mt-1">
                    <span class="font-semibold text-slate-700">${totalPrets}</span> prêts ·
                    <span class="text-blue-600 font-semibold">${countImmo} immobilier</span> ·
                    <span class="text-amber-600 font-semibold">${countAuto} automobile</span>
                </p>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-8">
            <!-- Donut répartition -->
            <div class="card p-6">
                <h2 class="font-bold text-slate-800 text-sm mb-1">Répartition par Type</h2>
                <p class="text-slate-400 text-xs mb-4">Distribution de l'ensemble du portefeuille</p>
                <div class="flex items-center gap-6">
                    <div class="relative w-32 h-32 flex-shrink-0">
                        <canvas id="typePieChart"></canvas>
                    </div>
                    <div class="space-y-4 flex-1">
                        <div>
                            <div class="flex items-center justify-between mb-1">
                                <div class="flex items-center gap-2 text-xs font-semibold text-slate-600">
                                    <div class="w-2.5 h-2.5 rounded-full bg-blue-500"></div> Immobilier
                                </div>
                                <span class="font-bold text-slate-800 text-xs">${countImmo}</span>
                            </div>
                            <div class="h-1.5 bg-slate-100 rounded-full overflow-hidden">
                                <div class="h-full bg-blue-500 rounded-full" style="width: ${totalPrets > 0 ? (countImmo * 100 / totalPrets) : 0}%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex items-center justify-between mb-1">
                                <div class="flex items-center gap-2 text-xs font-semibold text-slate-600">
                                    <div class="w-2.5 h-2.5 rounded-full bg-amber-400"></div> Automobile
                                </div>
                                <span class="font-bold text-slate-800 text-xs">${countAuto}</span>
                            </div>
                            <div class="h-1.5 bg-slate-100 rounded-full overflow-hidden">
                                <div class="h-full bg-amber-400 rounded-full" style="width: ${totalPrets > 0 ? (countAuto * 100 / totalPrets) : 0}%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Bar taux moyen -->
            <div class="card p-6">
                <h2 class="font-bold text-slate-800 text-sm mb-1">Taux Moyen par Type</h2>
                <p class="text-slate-400 text-xs mb-4">Comparaison des taux d'intérêt moyens</p>
                <canvas id="tauxBarChart" height="100"></canvas>
            </div>
        </div>

        <!-- Filter Card -->
        <div class="card p-5 mb-6">
            <form action="listePrets" method="get" class="flex flex-wrap items-end gap-4">
                <input type="hidden" name="page" value="1">
                <!-- ID Prêt -->
                <div class="min-w-[140px]">
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">ID Prêt</label>
                    <div class="relative">
                        <i data-lucide="hash" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                        <input type="number" name="searchIdPret" class="input-field pl-9" placeholder="ID prêt..." value="${param.searchIdPret}">
                    </div>
                </div>
                <!-- ID Client -->
                <div class="min-w-[140px]">
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">ID Client</label>
                    <div class="relative">
                        <i data-lucide="user" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                        <input type="number" name="searchIdClient" class="input-field pl-9" placeholder="ID client..." value="${param.searchIdClient}">
                    </div>
                </div>
                <!-- Type -->
                <div class="min-w-[150px]">
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Type de Prêt</label>
                    <div class="relative">
                        <i data-lucide="tag" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                        <select name="searchType" class="input-field pl-9 appearance-none">
                            <option value="">Tous les types</option>
                            <option value="IMMOBILIER" ${param.searchType == 'IMMOBILIER' ? 'selected' : ''}>Immobilier</option>
                            <option value="AUTOMOBILE" ${param.searchType == 'AUTOMOBILE' ? 'selected' : ''}>Automobile</option>
                        </select>
                    </div>
                </div>
                <div class="flex gap-2">
                    <button type="submit" class="btn-primary flex items-center gap-2 text-sm">
                        <i data-lucide="search" class="w-4 h-4"></i>
                        Filtrer
                    </button>
                    <a href="listePrets" class="flex items-center gap-2 px-4 py-2.5 rounded-xl border border-slate-200 text-slate-500 text-sm font-semibold hover:bg-slate-50 transition-colors">
                        <i data-lucide="x" class="w-4 h-4"></i>
                        Reset
                    </a>
                </div>
            </form>
        </div>

        <!-- Active filter pill -->
        <c:if test="${!empty param.searchIdClient || !empty param.searchType || !empty param.searchIdPret}">
            <div class="flex items-center gap-2 mb-4 flex-wrap">
                <span class="text-xs text-slate-400 font-medium">Filtres actifs :</span>
                <c:if test="${!empty param.searchIdClient}">
                    <span class="inline-flex items-center gap-1.5 bg-indigo-50 text-indigo-700 text-xs font-semibold rounded-full px-3 py-1">
                        <i data-lucide="user" class="w-3 h-3"></i> Client #${param.searchIdClient}
                    </span>
                </c:if>
                <c:if test="${!empty param.searchType}">
                    <span class="inline-flex items-center gap-1.5 bg-indigo-50 text-indigo-700 text-xs font-semibold rounded-full px-3 py-1">
                        <i data-lucide="tag" class="w-3 h-3"></i> ${param.searchType}
                    </span>
                </c:if>
                <c:if test="${!empty param.searchIdPret}">
                    <span class="inline-flex items-center gap-1.5 bg-indigo-50 text-indigo-700 text-xs font-semibold rounded-full px-3 py-1">
                        <i data-lucide="hash" class="w-3 h-3"></i> Prêt #${param.searchIdPret}
                    </span>
                </c:if>
                <a href="listePrets" class="text-xs text-rose-500 hover:text-rose-700 font-semibold ml-1">Effacer tout</a>
            </div>
        </c:if>

        <!-- Table -->
        <div class="card overflow-hidden">
            <table class="w-full text-sm">
                <thead>
                    <tr class="border-b border-slate-100 bg-slate-50">
                        <th class="text-left px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Dossier</th>
                        <th class="text-left px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Client</th>
                        <th class="text-left px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Mensualité</th>
                        <th class="text-left px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Coût Total</th>
                        <th class="text-left px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Durée</th>
                        <th class="text-center px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Type</th>
                        <th class="text-left px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Taux / Risque</th>
                        <th class="text-center px-5 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">IA</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50">
                    <c:forEach var="p" items="${prets}">

                        <%-- Avatar color based on clientId --%>
                        <c:set var="mod" value="${p.clientId % 7}"/>
                        <c:set var="ac" value="bg-indigo-100 text-indigo-700"/>
                        <c:if test="${mod == 0}"><c:set var="ac" value="bg-violet-100 text-violet-700"/></c:if>
                        <c:if test="${mod == 1}"><c:set var="ac" value="bg-blue-100 text-blue-700"/></c:if>
                        <c:if test="${mod == 2}"><c:set var="ac" value="bg-cyan-100 text-cyan-700"/></c:if>
                        <c:if test="${mod == 3}"><c:set var="ac" value="bg-emerald-100 text-emerald-700"/></c:if>
                        <c:if test="${mod == 4}"><c:set var="ac" value="bg-amber-100 text-amber-700"/></c:if>
                        <c:if test="${mod == 5}"><c:set var="ac" value="bg-rose-100 text-rose-700"/></c:if>
                        <c:if test="${mod == 6}"><c:set var="ac" value="bg-pink-100 text-pink-700"/></c:if>

                        <%-- Taux risk label + CSS class --%>
                        <c:set var="riskClass" value="risk-low"/>
                        <c:set var="riskLabel" value="Faible"/>
                        <c:if test="${p.taux >= 2 && p.taux < 4}">
                            <c:set var="riskClass" value="risk-mid"/>
                            <c:set var="riskLabel" value="Modéré"/>
                        </c:if>
                        <c:if test="${p.taux >= 4}">
                            <c:set var="riskClass" value="risk-high"/>
                            <c:set var="riskLabel" value="Élevé"/>
                        </c:if>

                        <%-- Durée en années + mois restants --%>
                        <c:set var="annees" value="${p.duree / 12}"/>
                        <c:set var="moisReste" value="${p.duree % 12}"/>

                        <%-- Coût total = mensualité × durée --%>
                        <c:set var="coutTotal" value="${p.remboursement * p.duree}"/>

                        <tr class="hover:bg-slate-50/80 transition-colors duration-100">

                            <%-- DOSSIER: icône + ID --%>
                            <td class="px-5 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-9 h-9 rounded-xl flex items-center justify-center flex-shrink-0
                                        ${p.type.toUpperCase() == 'IMMOBILIER' ? 'bg-blue-50' : 'bg-amber-50'}">
                                        <c:choose>
                                            <c:when test="${p.type.toUpperCase() == 'IMMOBILIER'}">
                                                <i data-lucide="home" class="w-4 h-4 text-blue-500"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i data-lucide="car" class="w-4 h-4 text-amber-500"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div>
                                        <p class="font-semibold text-slate-700 text-sm leading-none">Dossier</p>
                                        <p class="font-mono text-xs text-slate-400 mt-0.5">#${p.idPret}</p>
                                    </div>
                                </div>
                            </td>

                            <%-- CLIENT: avatar coloré + lien --%>
                            <td class="px-5 py-4">
                                <a href="listePrets?searchIdClient=${p.clientId}" class="flex items-center gap-2.5 group" title="Voir tous les prêts de ce client">
                                    <div class="avatar ${ac}">C${p.clientId}</div>
                                    <div>
                                        <p class="font-semibold text-slate-700 text-sm leading-none group-hover:text-indigo-600 transition-colors">Client</p>
                                        <p class="font-mono text-xs text-slate-400 mt-0.5">#${p.clientId}</p>
                                    </div>
                                </a>
                            </td>

                            <%-- MENSUALITÉ --%>
                            <td class="px-5 py-4">
                                <p class="font-bold text-slate-800 text-base leading-none">
                                    <fmt:formatNumber value="${p.remboursement}" maxFractionDigits="0"/> <span class="text-slate-400 text-xs font-normal">€</span>
                                </p>
                                <p class="text-xs text-slate-400 mt-1">/ mois</p>
                            </td>

                            <%-- COÛT TOTAL --%>
                            <td class="px-5 py-4">
                                <p class="font-bold text-indigo-700 text-sm leading-none">
                                    <fmt:formatNumber value="${coutTotal}" maxFractionDigits="0"/> <span class="text-indigo-400 text-xs font-normal">€</span>
                                </p>
                                <p class="text-xs text-slate-400 mt-1">sur toute la durée</p>
                            </td>

                            <%-- DURÉE --%>
                            <td class="px-5 py-4">
                                <div class="flex items-center gap-1.5">
                                    <i data-lucide="clock" class="w-3.5 h-3.5 text-slate-300 flex-shrink-0"></i>
                                    <div>
                                        <p class="font-semibold text-slate-700 text-sm leading-none">
                                            ${annees}<span class="font-normal text-slate-400 text-xs"> ans</span>
                                            <c:if test="${moisReste > 0}">
                                                ${moisReste}<span class="font-normal text-slate-400 text-xs"> m</span>
                                            </c:if>
                                        </p>
                                        <p class="text-xs text-slate-400 mt-0.5">${p.duree} mois</p>
                                    </div>
                                </div>
                            </td>

                            <%-- TYPE badge --%>
                            <td class="px-5 py-4 text-center">
                                <c:choose>
                                    <c:when test="${p.type.toUpperCase() == 'IMMOBILIER'}">
                                        <span class="inline-flex items-center gap-1.5 badge-immo text-xs font-bold rounded-full px-3 py-1.5 uppercase tracking-wide whitespace-nowrap">
                                            <i data-lucide="home" class="w-3 h-3"></i> Immo
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-1.5 badge-auto text-xs font-bold rounded-full px-3 py-1.5 uppercase tracking-wide whitespace-nowrap">
                                            <i data-lucide="car" class="w-3 h-3"></i> Auto
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <%-- TAUX + BADGE RISQUE --%>
                            <td class="px-5 py-4">
                                <div class="flex items-center gap-2 mb-1.5">
                                    <span class="font-bold text-slate-800 text-sm">${p.taux}%</span>
                                    <span class="text-xs font-bold rounded-md px-2 py-0.5 ${riskClass}">${riskLabel}</span>
                                </div>
                                <div class="taux-bar">
                                    <div class="taux-fill ${riskClass == 'risk-low' ? 'bg-emerald-500' : (riskClass == 'risk-mid' ? 'bg-amber-400' : 'bg-rose-500')}"
                                         style="width:min(${p.taux * 10}%, 100%)"></div>
                                </div>
                            </td>

                            <%-- ANALYSE IA --%>
                            <td class="px-5 py-4 text-center">
                                <a href="predire?idClient=${p.clientId}"
                                   title="Lancer la prédiction IA pour ce client"
                                   class="inline-flex items-center justify-center w-8 h-8 rounded-lg border border-indigo-200 text-indigo-500 hover:bg-indigo-600 hover:text-white hover:border-indigo-600 transition-all duration-150">
                                    <i data-lucide="brain-circuit" class="w-4 h-4"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty prets}">
                        <tr>
                            <td colspan="8" class="px-6 py-16 text-center">
                                <div class="flex flex-col items-center gap-3">
                                    <div class="w-12 h-12 bg-slate-100 rounded-full flex items-center justify-center">
                                        <i data-lucide="landmark" class="w-5 h-5 text-slate-400"></i>
                                    </div>
                                    <p class="text-slate-600 font-semibold">Aucun prêt trouvé</p>
                                    <p class="text-slate-400 text-xs">Essayez de modifier ou réinitialiser vos filtres.</p>
                                    <a href="listePrets" class="text-indigo-600 text-sm font-semibold hover:underline">Réinitialiser les filtres</a>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>

                <!-- Summary footer row -->
                <c:if test="${!empty prets}">
                    <tfoot>
                        <tr class="bg-slate-50 border-t-2 border-slate-200">
                            <td colspan="2" class="px-5 py-3">
                                <span class="text-xs font-bold text-slate-500 uppercase tracking-wider">Résumé page</span>
                            </td>
                            <td class="px-5 py-3">
                                <p class="text-xs text-slate-400">Total mensualités</p>
                                <p class="font-bold text-slate-700 text-sm" id="sumMensualite">—</p>
                            </td>
                            <td class="px-5 py-3">
                                <p class="text-xs text-slate-400">Engagement total</p>
                                <p class="font-bold text-indigo-600 text-sm" id="sumCout">—</p>
                            </td>
                            <td class="px-5 py-3">
                                <p class="text-xs text-slate-400">Durée moy.</p>
                                <p class="font-bold text-slate-700 text-sm" id="avgDuree">—</p>
                            </td>
                            <td class="px-5 py-3">
                                <p class="text-xs text-slate-400">Sur la page</p>
                                <p class="font-bold text-slate-700 text-sm">${prets.size()} prêts</p>
                            </td>
                            <td class="px-5 py-3">
                                <p class="text-xs text-slate-400">Taux moyen</p>
                                <p class="font-bold text-slate-700 text-sm" id="avgTaux">—</p>
                            </td>
                            <td></td>
                        </tr>
                    </tfoot>
                </c:if>
            </table>

            <!-- Pagination -->
            <div class="flex items-center justify-between px-5 py-4 border-t border-slate-100 bg-white">
                <span class="text-xs text-slate-500">
                    Page <span class="font-semibold text-slate-700">${currentPage}</span> sur
                    <span class="font-semibold text-slate-700">${totalPages < 1 ? 1 : totalPages}</span>
                    &nbsp;·&nbsp; <span class="font-semibold text-slate-700">${prets.size()}</span> résultats affichés
                </span>
                <div class="flex items-center gap-2">
                    <a href="listePrets?page=${currentPage - 1}&searchIdPret=${param.searchIdPret}&searchType=${param.searchType}&searchIdClient=${param.searchIdClient}"
                       class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg border border-slate-200 text-xs font-semibold text-slate-600 transition-all hover:bg-slate-50 ${currentPage <= 1 ? 'opacity-40 pointer-events-none' : ''}">
                        <i data-lucide="chevron-left" class="w-3.5 h-3.5"></i> Précédent
                    </a>
                    <a href="listePrets?page=${currentPage + 1}&searchIdPret=${param.searchIdPret}&searchType=${param.searchType}&searchIdClient=${param.searchIdClient}"
                       class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg border border-slate-200 text-xs font-semibold text-slate-600 transition-all hover:bg-slate-50 ${currentPage >= totalPages ? 'opacity-40 pointer-events-none' : ''}">
                        Suivant <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
                    </a>
                </div>
            </div>
        </div>
    </main>

<script>
    lucide.createIcons();

    // ── Chart.js ──────────────────────────────────────────
    const immo    = parseInt('${countImmo}') || 0;
    const auto    = parseInt('${countAuto}') || 0;
    const total   = immo + auto;
    const avgImmo = parseFloat('${avgTauxImmo}') || 0;
    const avgAuto = parseFloat('${avgTauxAuto}') || 0;

    new Chart(document.getElementById('typePieChart'), {
        type: 'doughnut',
        data: {
            labels: ['Immobilier', 'Automobile'],
            datasets: [{
                data: total > 0 ? [immo, auto] : [1, 1],
                backgroundColor: ['#3b82f6', '#fbbf24'],
                borderWidth: 2,
                borderColor: ['#2563eb', '#f59e0b'],
                hoverOffset: 4
            }]
        },
        options: {
            cutout: '68%',
            plugins: {
                legend: { display: false },
                tooltip: { callbacks: { label: ctx => ` ${ctx.label}: ${total > 0 ? ctx.raw : 0}` } }
            }
        }
    });

    new Chart(document.getElementById('tauxBarChart'), {
        type: 'bar',
        data: {
            labels: ['Immobilier', 'Automobile'],
            datasets: [{
                label: 'Taux moyen (%)',
                data: [avgImmo, avgAuto],
                backgroundColor: ['rgba(59,130,246,0.12)', 'rgba(251,191,36,0.12)'],
                borderColor: ['#3b82f6', '#fbbf24'],
                borderWidth: 2,
                borderRadius: 8
            }]
        },
        options: {
            indexAxis: 'y',
            plugins: { legend: { display: false } },
            scales: {
                x: {
                    beginAtZero: true,
                    grid: { color: '#f1f5f9' },
                    ticks: { callback: v => v + '%', font: { size: 11 } }
                },
                y: {
                    grid: { display: false },
                    ticks: { font: { size: 12, weight: '600' } }
                }
            }
        }
    });

    // ── Summary row calculations ───────────────────────────
    (function() {
        const rows = document.querySelectorAll('tbody tr[class*="hover"]');
        let sumMens = 0, sumCout = 0, sumDuree = 0, sumTaux = 0, n = 0;
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            if (cells.length < 7) return;
            const mens  = parseFloat(cells[2].querySelector('p')?.textContent?.replace(/\s/g,'').replace(',','.')) || 0;
            const cout  = parseFloat(cells[3].querySelector('p')?.textContent?.replace(/\s/g,'').replace(',','.')) || 0;
            const duree = parseFloat(cells[4].querySelector('p:last-child')?.textContent) || 0;
            const taux  = parseFloat(cells[6].querySelector('span')?.textContent) || 0;
            sumMens  += mens;
            sumCout  += cout;
            sumDuree += duree;
            sumTaux  += taux;
            n++;
        });
        const fmt = v => v.toLocaleString('fr-FR', {maximumFractionDigits: 0}) + ' €';
        if (n > 0) {
            document.getElementById('sumMensualite').textContent = fmt(sumMens);
            document.getElementById('sumCout').textContent       = fmt(sumCout);
            document.getElementById('avgDuree').textContent      = Math.round(sumDuree / n) + ' mois';
            document.getElementById('avgTaux').textContent       = (sumTaux / n).toFixed(2) + '%';
        }
    })();
</script>
</body>
</html>