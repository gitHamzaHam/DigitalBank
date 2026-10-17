<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="_layout.jsp" %>
    <script>document.getElementById('nav-prets').classList.add('nav-link-active');</script>

    <main class="max-w-7xl mx-auto px-6 py-10">

        <!-- Page Header -->
        <div class="flex items-center justify-between mb-8">
            <div>
                <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Analyse des Prêts</h1>
                <p class="text-slate-500 text-sm mt-1">
                    <span class="font-semibold text-slate-700">${totalPrets}</span> prêts au total ·
                    <span class="text-blue-600 font-semibold">${countImmo} immobilier</span> ·
                    <span class="text-amber-600 font-semibold">${countAuto} automobile</span>
                </p>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-8">
            <!-- Donut type distribution -->
            <div class="card p-6">
                <h2 class="font-bold text-slate-800 text-sm mb-4">Répartition par Type</h2>
                <div class="flex items-center gap-6">
                    <div class="relative w-32 h-32 flex-shrink-0">
                        <canvas id="typePieChart"></canvas>
                    </div>
                    <div class="space-y-3">
                        <div class="flex items-center gap-2 text-sm">
                            <div class="w-3 h-3 rounded-full bg-blue-500"></div>
                            <span class="text-slate-600">Immobilier</span>
                            <span class="ml-auto font-bold text-slate-800">${countImmo}</span>
                        </div>
                        <div class="flex items-center gap-2 text-sm">
                            <div class="w-3 h-3 rounded-full bg-amber-400"></div>
                            <span class="text-slate-600">Automobile</span>
                            <span class="ml-auto font-bold text-slate-800">${countAuto}</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Bar chart avg rates -->
            <div class="card p-6">
                <h2 class="font-bold text-slate-800 text-sm mb-4">Taux Moyen par Type (%)</h2>
                <canvas id="tauxBarChart" height="90"></canvas>
            </div>
        </div>

        <!-- Filter Card -->
        <div class="card p-5 mb-6">
            <form action="listePrets" method="get" class="flex flex-wrap items-end gap-4">
                <input type="hidden" name="page" value="1">
                <div class="flex-1 min-w-[160px]">
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">ID Prêt</label>
                    <div class="relative">
                        <i data-lucide="hash" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                        <input type="number" name="searchIdPret" class="input-field pl-9" placeholder="ID..." value="${param.searchIdPret}">
                    </div>
                </div>
                <div class="flex-1 min-w-[160px]">
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Type</label>
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

        <!-- Table -->
        <div class="card overflow-hidden">
            <table class="w-full text-sm">
                <thead>
                    <tr class="border-b border-slate-100 bg-slate-50">
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">ID Prêt</th>
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Client</th>
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Mensualité</th>
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Durée</th>
                        <th class="text-center px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Type</th>
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Taux</th>
                        <th class="text-center px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Analyse IA</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50">
                    <c:forEach var="p" items="${prets}">
                        <tr class="hover:bg-slate-50 transition-colors duration-100">
                            <td class="px-6 py-4">
                                <span class="font-mono text-xs font-semibold bg-slate-100 text-slate-600 rounded-md px-2 py-1">#${p.idPret}</span>
                            </td>
                            <td class="px-6 py-4">
                                <a href="listePrets?searchIdClient=${p.clientId}" class="flex items-center gap-1.5 text-indigo-600 hover:text-indigo-800 font-semibold transition-colors">
                                    <i data-lucide="user" class="w-3.5 h-3.5"></i>
                                    #${p.clientId}
                                </a>
                            </td>
                            <td class="px-6 py-4">
                                <span class="font-bold text-emerald-700">${p.remboursement} €</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-1.5 text-slate-600">
                                    <i data-lucide="clock" class="w-3.5 h-3.5 text-slate-400"></i>
                                    <span class="font-medium">${p.duree} mois</span>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <c:choose>
                                    <c:when test="${p.type.toUpperCase() == 'IMMOBILIER'}">
                                        <span class="inline-flex items-center gap-1.5 badge-immo text-xs font-bold rounded-full px-3 py-1 uppercase tracking-wide">
                                            <i data-lucide="home" class="w-3 h-3"></i> Immobilier
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-1.5 badge-auto text-xs font-bold rounded-full px-3 py-1 uppercase tracking-wide">
                                            <i data-lucide="car" class="w-3 h-3"></i> Automobile
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-2">
                                    <span class="font-bold text-slate-800 w-10 text-right">${p.taux}%</span>
                                    <div class="flex-1 bg-slate-100 rounded-full h-1.5 min-w-[48px]">
                                        <div class="bg-indigo-400 h-1.5 rounded-full" style="width: min(${p.taux * 10}%, 100%)"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <a href="predire?idClient=${p.clientId}"
                                   class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg border border-indigo-200 text-indigo-600 text-xs font-bold hover:bg-indigo-600 hover:text-white hover:border-indigo-600 transition-all duration-150">
                                    <i data-lucide="brain-circuit" class="w-3.5 h-3.5"></i>
                                    Prédire
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty prets}">
                        <tr>
                            <td colspan="7" class="px-6 py-16 text-center">
                                <div class="flex flex-col items-center gap-3">
                                    <div class="w-12 h-12 bg-slate-100 rounded-full flex items-center justify-center">
                                        <i data-lucide="landmark" class="w-5 h-5 text-slate-400"></i>
                                    </div>
                                    <p class="text-slate-500 font-medium">Aucun prêt trouvé</p>
                                    <a href="listePrets" class="text-indigo-600 text-sm font-semibold hover:underline">Réinitialiser les filtres</a>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <!-- Pagination -->
            <div class="flex items-center justify-between px-6 py-4 border-t border-slate-100 bg-white">
                <span class="text-xs text-slate-500">
                    Page <span class="font-semibold text-slate-700">${currentPage}</span> sur <span class="font-semibold text-slate-700">${totalPages < 1 ? 1 : totalPages}</span>
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

    const immo = parseInt('${countImmo}') || 0;
    const auto  = parseInt('${countAuto}') || 0;
    const total = immo + auto;
    const avgImmo = parseFloat('${avgTauxImmo}') || 0;
    const avgAuto = parseFloat('${avgTauxAuto}') || 0;

    // Donut
    new Chart(document.getElementById('typePieChart'), {
        type: 'doughnut',
        data: {
            labels: ['Immobilier', 'Automobile'],
            datasets: [{ data: total > 0 ? [immo, auto] : [1,1], backgroundColor: ['#3b82f6','#fbbf24'], borderWidth: 2, borderColor: ['#2563eb','#f59e0b'], hoverOffset: 4 }]
        },
        options: { cutout: '68%', plugins: { legend: { display: false }, tooltip: { callbacks: { label: ctx => ` ${ctx.label}: ${total > 0 ? ctx.raw : 0}` } } } }
    });

    // Bar — Avg taux
    new Chart(document.getElementById('tauxBarChart'), {
        type: 'bar',
        data: {
            labels: ['Immobilier', 'Automobile'],
            datasets: [{
                label: 'Taux moyen (%)',
                data: [avgImmo, avgAuto],
                backgroundColor: ['rgba(59,130,246,0.15)', 'rgba(251,191,36,0.15)'],
                borderColor: ['#3b82f6', '#fbbf24'],
                borderWidth: 2,
                borderRadius: 8
            }]
        },
        options: {
            indexAxis: 'y',
            plugins: { legend: { display: false } },
            scales: {
                x: { beginAtZero: true, grid: { color: '#f1f5f9' }, ticks: { callback: v => v + '%', font: { size: 11 } } },
                y: { grid: { display: false }, ticks: { font: { size: 12, weight: '600' } } }
            }
        }
    });
</script>
</body>
</html>