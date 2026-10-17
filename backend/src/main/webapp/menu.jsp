<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="_layout.jsp" %>
    <script>
        // Highlight active nav link
        document.getElementById('nav-accueil').classList.add('nav-link-active');
    </script>

    <main class="max-w-7xl mx-auto px-6 py-10">

        <!-- Welcome Banner -->
        <div class="mb-8">
            <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">
                Tableau de Bord
            </h1>
            <p class="text-slate-500 mt-1 text-sm">
                Bienvenue, <span class="font-semibold text-indigo-600">${sessionScope.adminConnecte}</span> — voici un aperçu de votre activité.
            </p>
        </div>

        <!-- KPI Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-5 mb-10">
            <!-- Total Clients -->
            <div class="card p-6 flex items-center gap-5">
                <div class="w-12 h-12 bg-indigo-50 rounded-xl flex items-center justify-center flex-shrink-0">
                    <i data-lucide="users" class="w-6 h-6 text-indigo-600"></i>
                </div>
                <div>
                    <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Total Clients</p>
                    <p class="text-2xl font-extrabold text-slate-900 mt-0.5">${empty totalClients ? '—' : totalClients}</p>
                </div>
            </div>
            <!-- Total Prêts -->
            <div class="card p-6 flex items-center gap-5">
                <div class="w-12 h-12 bg-emerald-50 rounded-xl flex items-center justify-center flex-shrink-0">
                    <i data-lucide="landmark" class="w-6 h-6 text-emerald-600"></i>
                </div>
                <div>
                    <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Total Prêts</p>
                    <p class="text-2xl font-extrabold text-slate-900 mt-0.5">${empty totalPrets ? '—' : totalPrets}</p>
                </div>
            </div>
            <!-- Répartition -->
            <div class="card p-6 flex items-center gap-5">
                <div class="w-12 h-12 bg-amber-50 rounded-xl flex items-center justify-center flex-shrink-0">
                    <i data-lucide="pie-chart" class="w-6 h-6 text-amber-500"></i>
                </div>
                <div>
                    <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Répartition Types</p>
                    <p class="text-sm font-bold text-slate-700 mt-0.5">
                        <span class="text-blue-600">${empty countImmo ? '0' : countImmo} Immo</span>
                        <span class="text-slate-300 mx-1">·</span>
                        <span class="text-amber-600">${empty countAuto ? '0' : countAuto} Auto</span>
                    </p>
                </div>
            </div>
        </div>

        <!-- Main Content: Modules + Chart -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

            <!-- Left: Module Cards -->
            <div class="lg:col-span-1 space-y-5">
                <!-- Clients Module -->
                <a href="listeClients?page=1" class="card p-6 flex flex-col gap-4 hover:shadow-md transition-all duration-200 hover:-translate-y-0.5 block group">
                    <div class="flex items-center justify-between">
                        <div class="w-11 h-11 bg-indigo-50 rounded-xl flex items-center justify-center group-hover:bg-indigo-600 transition-colors duration-200">
                            <i data-lucide="users" class="w-5 h-5 text-indigo-600 group-hover:text-white transition-colors duration-200"></i>
                        </div>
                        <i data-lucide="arrow-right" class="w-4 h-4 text-slate-300 group-hover:text-indigo-600 transition-colors duration-200"></i>
                    </div>
                    <div>
                        <h3 class="font-bold text-slate-900 text-base">Gestion des Clients</h3>
                        <p class="text-slate-500 text-xs mt-1 leading-relaxed">Accédez au répertoire complet, filtrez et gérez vos dossiers clients.</p>
                    </div>
                </a>
                <!-- Prêts Module -->
                <a href="listePrets" class="card p-6 flex flex-col gap-4 hover:shadow-md transition-all duration-200 hover:-translate-y-0.5 block group">
                    <div class="flex items-center justify-between">
                        <div class="w-11 h-11 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-500 transition-colors duration-200">
                            <i data-lucide="wallet" class="w-5 h-5 text-emerald-600 group-hover:text-white transition-colors duration-200"></i>
                        </div>
                        <i data-lucide="arrow-right" class="w-4 h-4 text-slate-300 group-hover:text-emerald-500 transition-colors duration-200"></i>
                    </div>
                    <div>
                        <h3 class="font-bold text-slate-900 text-base">Analyse des Prêts</h3>
                        <p class="text-slate-500 text-xs mt-1 leading-relaxed">Consultez les dossiers, analysez les risques et déclenchez la prédiction IA.</p>
                    </div>
                </a>
            </div>

            <!-- Right: Donut Chart -->
            <div class="lg:col-span-2 card p-6">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h2 class="font-bold text-slate-900 text-base">Répartition des Prêts</h2>
                        <p class="text-slate-500 text-xs mt-0.5">Distribution par type de financement</p>
                    </div>
                    <span class="text-xs font-semibold text-slate-400 bg-slate-100 rounded-full px-3 py-1">En temps réel</span>
                </div>
                <div class="flex items-center gap-8">
                    <div class="relative w-44 h-44 flex-shrink-0">
                        <canvas id="donutChart"></canvas>
                    </div>
                    <div class="flex flex-col gap-4">
                        <div class="flex items-center gap-3">
                            <div class="w-3 h-3 rounded-full bg-blue-500 flex-shrink-0"></div>
                            <div>
                                <p class="font-semibold text-slate-800 text-sm">Immobilier</p>
                                <p class="text-slate-500 text-xs">${empty countImmo ? 0 : countImmo} prêts enregistrés</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-3">
                            <div class="w-3 h-3 rounded-full bg-amber-400 flex-shrink-0"></div>
                            <div>
                                <p class="font-semibold text-slate-800 text-sm">Automobile</p>
                                <p class="text-slate-500 text-xs">${empty countAuto ? 0 : countAuto} prêts enregistrés</p>
                            </div>
                        </div>
                        <div class="mt-2 pt-4 border-t border-slate-100">
                            <p class="text-xs text-slate-400 font-medium">Total</p>
                            <p class="text-xl font-extrabold text-slate-900">${empty totalPrets ? 0 : totalPrets} <span class="text-sm font-normal text-slate-400">prêts</span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

<script>
    lucide.createIcons();

    // Donut chart
    const immo = parseInt('${empty countImmo ? 0 : countImmo}') || 0;
    const auto = parseInt('${empty countAuto ? 0 : countAuto}') || 0;
    const total = immo + auto;

    new Chart(document.getElementById('donutChart'), {
        type: 'doughnut',
        data: {
            labels: ['Immobilier', 'Automobile'],
            datasets: [{
                data: total > 0 ? [immo, auto] : [1, 1],
                backgroundColor: ['#3b82f6', '#fbbf24'],
                borderColor: ['#2563eb', '#f59e0b'],
                borderWidth: 2,
                hoverOffset: 6
            }]
        },
        options: {
            cutout: '72%',
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        label: ctx => ` ${ctx.label}: ${total > 0 ? ctx.raw : 0} prêts`
                    }
                }
            }
        },
        plugins: [{
            id: 'centerText',
            afterDraw(chart) {
                const { ctx, chartArea: { left, top, right, bottom } } = chart;
                const cx = (left + right) / 2, cy = (top + bottom) / 2;
                ctx.save();
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                ctx.font = 'bold 22px Plus Jakarta Sans';
                ctx.fillStyle = '#0f172a';
                ctx.fillText(total, cx, cy - 8);
                ctx.font = '11px Plus Jakarta Sans';
                ctx.fillStyle = '#94a3b8';
                ctx.fillText('prêts', cx, cy + 12);
                ctx.restore();
            }
        }]
    });
</script>
</body>
</html>