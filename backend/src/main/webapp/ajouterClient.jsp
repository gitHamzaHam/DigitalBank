<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_layout.jsp" %>
    <script>document.getElementById('nav-clients').classList.add('nav-link-active');</script>

    <main class="max-w-3xl mx-auto px-6 py-10">

        <!-- Breadcrumb -->
        <nav class="flex items-center gap-2 text-xs text-slate-400 mb-8">
            <a href="menu" class="hover:text-indigo-600 transition-colors">Accueil</a>
            <i data-lucide="chevron-right" class="w-3 h-3"></i>
            <a href="listeClients?page=1" class="hover:text-indigo-600 transition-colors">Clients</a>
            <i data-lucide="chevron-right" class="w-3 h-3"></i>
            <span class="text-slate-600 font-semibold">Nouveau Dossier</span>
        </nav>

        <!-- Page Header -->
        <div class="mb-8">
            <div class="flex items-center gap-3 mb-2">
                <div class="w-10 h-10 bg-indigo-50 rounded-xl flex items-center justify-center">
                    <i data-lucide="user-plus" class="w-5 h-5 text-indigo-600"></i>
                </div>
                <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">Nouveau Dossier Client</h1>
            </div>
            <p class="text-slate-500 text-sm ml-[52px]">Renseignez les informations du client et les détails du prêt associé.</p>
        </div>

        <!-- Form Card -->
        <form action="sauvegarderClient" method="post">
            <input type="hidden" name="action" value="add">

            <!-- Step Indicator -->
            <div class="flex items-center gap-0 mb-8">
                <div class="flex items-center gap-2">
                    <div class="w-7 h-7 rounded-full bg-indigo-600 text-white text-xs font-bold flex items-center justify-center">1</div>
                    <span class="text-sm font-semibold text-indigo-600">Informations Client</span>
                </div>
                <div class="flex-1 h-px bg-slate-200 mx-4"></div>
                <div class="flex items-center gap-2">
                    <div class="w-7 h-7 rounded-full bg-slate-200 text-slate-500 text-xs font-bold flex items-center justify-center">2</div>
                    <span class="text-sm font-semibold text-slate-400">Détails du Prêt</span>
                </div>
            </div>

            <!-- Section 1: Client Info -->
            <div class="card p-7 mb-5">
                <div class="flex items-center gap-2 mb-6">
                    <i data-lucide="user" class="w-4 h-4 text-indigo-600"></i>
                    <h2 class="font-bold text-slate-800 text-sm">Informations du Client</h2>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div>
                        <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Ville</label>
                        <div class="relative">
                            <i data-lucide="map-pin" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                            <select name="ville" class="input-field pl-9 appearance-none" required>
                                <option value="PARIS">Paris</option>
                                <option value="LYON">Lyon</option>
                                <option value="MARSEILLE">Marseille</option>
                                <option value="TOULOUSE">Toulouse</option>
                                <option value="NICE">Nice</option>
                                <option value="BORDEAUX">Bordeaux</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Code Postal</label>
                        <div class="relative">
                            <i data-lucide="mail" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                            <input type="text" name="cp" class="input-field pl-9" placeholder="Ex: 75000" required>
                        </div>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Revenu Mensuel</label>
                        <div class="relative">
                            <i data-lucide="euro" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                            <input type="number" step="0.01" name="revenu" class="input-field pl-9" placeholder="Ex: 3000" required>
                            <span class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-sm font-medium">€</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section 2: Prêt Details -->
            <div class="card p-7 mb-7">
                <div class="flex items-center gap-2 mb-6">
                    <i data-lucide="wallet" class="w-4 h-4 text-emerald-600"></i>
                    <h2 class="font-bold text-slate-800 text-sm">Détails du Prêt</h2>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Type de Prêt</label>
                        <div class="grid grid-cols-2 gap-3">
                            <label class="flex items-center gap-3 card p-4 cursor-pointer hover:border-indigo-300 border-2 border-transparent transition-all has-[:checked]:border-blue-500 has-[:checked]:bg-blue-50">
                                <input type="radio" name="type" value="IMMOBILIER" class="accent-blue-600" checked>
                                <div class="flex items-center gap-2">
                                    <i data-lucide="home" class="w-4 h-4 text-blue-600"></i>
                                    <span class="font-semibold text-sm text-slate-700">Immobilier</span>
                                </div>
                            </label>
                            <label class="flex items-center gap-3 card p-4 cursor-pointer hover:border-amber-300 border-2 border-transparent transition-all has-[:checked]:border-amber-500 has-[:checked]:bg-amber-50">
                                <input type="radio" name="type" value="AUTOMOBILE" class="accent-amber-500">
                                <div class="flex items-center gap-2">
                                    <i data-lucide="car" class="w-4 h-4 text-amber-600"></i>
                                    <span class="font-semibold text-sm text-slate-700">Automobile</span>
                                </div>
                            </label>
                        </div>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Mensualité</label>
                        <div class="relative">
                            <i data-lucide="credit-card" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                            <input type="number" step="0.01" name="remboursement" class="input-field pl-9" placeholder="Ex: 800" required>
                            <span class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-sm">€</span>
                        </div>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Durée</label>
                        <div class="relative">
                            <i data-lucide="clock" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                            <input type="number" name="duree" class="input-field pl-9" placeholder="Ex: 120" required>
                            <span class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-sm">mois</span>
                        </div>
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Taux d'intérêt</label>
                        <div class="relative">
                            <i data-lucide="percent" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                            <input type="number" step="0.01" name="taux" class="input-field pl-9" placeholder="Ex: 1.5" required>
                            <span class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-sm">%</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="flex items-center gap-3">
                <button type="submit" class="btn-primary flex items-center gap-2 text-sm">
                    <i data-lucide="save" class="w-4 h-4"></i>
                    Sauvegarder le Dossier
                </button>
                <a href="listeClients?page=1" class="px-5 py-2.5 rounded-xl text-slate-500 text-sm font-semibold hover:text-slate-700 transition-colors">
                    Annuler
                </a>
            </div>
        </form>
    </main>

<script>lucide.createIcons();</script>
</body>
</html>