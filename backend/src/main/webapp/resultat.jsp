<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_layout.jsp" %>
    <title>DigitalBank — Résultat IA</title>

    <main class="min-h-[calc(100vh-64px)] flex items-center justify-center px-6 py-12">
        <div class="w-full max-w-lg">

            <!-- Header -->
            <div class="text-center mb-8">
                <div class="w-14 h-14 bg-indigo-50 rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <i data-lucide="brain-circuit" class="w-7 h-7 text-indigo-600"></i>
                </div>
                <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">Analyse de Solvabilité IA</h1>
                <p class="text-slate-500 text-sm mt-2">Résultat généré par le moteur prédictif</p>
                <span class="inline-block mt-3 font-mono text-xs font-semibold bg-slate-100 text-slate-600 rounded-full px-3 py-1">
                    Client #${idClient}
                </span>
            </div>

            <!-- Score Gauge Chart -->
            <div class="card p-8 mb-6">
                <div class="relative w-48 h-48 mx-auto mb-6">
                    <canvas id="gaugeChart"></canvas>
                    <div class="absolute inset-0 flex flex-col items-center justify-center">
                        <span id="gaugeLabel" class="text-2xl font-extrabold"></span>
                        <span class="text-xs text-slate-400 mt-1 font-medium">Score Risque</span>
                    </div>
                </div>

                <!-- Verdict -->
                <% String score = (String) request.getAttribute("score");
                   boolean isFaible = score != null && score.contains("Faible");
                %>
                <div class="rounded-xl p-5 text-center <%= isFaible ? "bg-emerald-50 border border-emerald-200" : "bg-rose-50 border border-rose-200" %>">
                    <div class="flex items-center justify-center gap-2 mb-2">
                        <i data-lucide="<%= isFaible ? "shield-check" : "shield-x" %>" class="w-5 h-5 <%= isFaible ? "text-emerald-600" : "text-rose-600" %>"></i>
                        <span class="text-lg font-extrabold uppercase tracking-wide <%= isFaible ? "text-emerald-700" : "text-rose-700" %>">
                            ${score}
                        </span>
                    </div>
                    <p class="text-sm <%= isFaible ? "text-emerald-600" : "text-rose-600" %>">
                        <% if (isFaible) { %>
                            Ce client présente un profil de remboursement fiable. Le dossier peut être approuvé avec confiance.
                        <% } else { %>
                            Ce client présente un risque de défaut élevé. Une analyse approfondie est recommandée avant approbation.
                        <% } %>
                    </p>
                </div>
            </div>

            <!-- Info Card -->
            <div class="card p-5 mb-6">
                <div class="flex items-start gap-3">
                    <div class="w-8 h-8 bg-slate-100 rounded-lg flex items-center justify-center flex-shrink-0 mt-0.5">
                        <i data-lucide="info" class="w-4 h-4 text-slate-500"></i>
                    </div>
                    <div>
                        <p class="text-xs font-semibold text-slate-700 mb-1">À propos de cette analyse</p>
                        <p class="text-xs text-slate-500 leading-relaxed">
                            Cette prédiction est générée par un modèle de machine learning entraîné sur des historiques de remboursement. Elle est basée sur le revenu, le taux, la durée et le type de prêt du client.
                        </p>
                    </div>
                </div>
            </div>

            <!-- CTA Buttons -->
            <div class="flex flex-col gap-3">
                <a href="menu" class="btn-primary flex items-center justify-center gap-2 text-sm">
                    <i data-lucide="layout-dashboard" class="w-4 h-4"></i>
                    Retour au Tableau de Bord
                </a>
                <a href="listePrets" class="flex items-center justify-center gap-2 px-5 py-2.5 rounded-xl border border-slate-200 text-slate-500 text-sm font-semibold hover:bg-slate-50 transition-colors">
                    <i data-lucide="landmark" class="w-4 h-4"></i>
                    Consulter les autres prêts
                </a>
            </div>
        </div>
    </main>

<script>
    lucide.createIcons();
    const isFaible = '${score}'.includes('Faible');
    const score = isFaible ? 22 : 78; // visual score for gauge
    const color = isFaible ? '#10b981' : '#f43f5e';
    const bgColor = isFaible ? '#d1fae5' : '#fee2e2';
    document.getElementById('gaugeLabel').textContent = isFaible ? 'Faible' : 'Élevé';
    document.getElementById('gaugeLabel').style.color = color;

    new Chart(document.getElementById('gaugeChart'), {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [score, 100 - score],
                backgroundColor: [color, '#f1f5f9'],
                borderWidth: 0,
                circumference: 240,
                rotation: 240
            }]
        },
        options: {
            cutout: '78%',
            plugins: { legend: { display: false }, tooltip: { enabled: false } }
        }
    });
</script>
</body>
</html>