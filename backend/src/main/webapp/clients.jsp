<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="_layout.jsp" %>
    <script>document.getElementById('nav-clients').classList.add('nav-link-active');</script>

    <main class="max-w-7xl mx-auto px-6 py-10">

        <!-- Page Header -->
        <div class="flex items-center justify-between mb-8">
            <div>
                <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Répertoire Clients</h1>
                <p class="text-slate-500 text-sm mt-1">
                    <span class="font-semibold text-slate-700">${totalClients}</span> clients enregistrés
                </p>
            </div>
            <a href="ajouterClient.jsp" class="flex items-center gap-2 btn-primary text-sm">
                <i data-lucide="user-plus" class="w-4 h-4"></i>
                Nouveau Client
            </a>
        </div>

        <!-- Filter Card -->
        <div class="card p-5 mb-6">
            <form action="listeClients" method="get" class="flex flex-wrap items-end gap-4">
                <input type="hidden" name="page" value="1">
                <div class="flex-1 min-w-[180px]">
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">ID Client</label>
                    <div class="relative">
                        <i data-lucide="hash" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                        <input type="number" name="searchId" class="input-field pl-9" placeholder="Rechercher par ID..." value="${param.searchId}">
                    </div>
                </div>
                <div class="flex-1 min-w-[180px]">
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Ville</label>
                    <div class="relative">
                        <i data-lucide="map-pin" class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2"></i>
                        <select name="searchVille" class="input-field pl-9 appearance-none">
                            <option value="">Toutes les villes</option>
                            <c:forEach var="v" items="${villes}">
                                <option value="${v}" ${param.searchVille == v ? 'selected' : ''}>${v}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="flex gap-2">
                    <button type="submit" class="btn-primary flex items-center gap-2 text-sm">
                        <i data-lucide="search" class="w-4 h-4"></i>
                        Filtrer
                    </button>
                    <a href="listeClients?page=1" class="flex items-center gap-2 px-4 py-2.5 rounded-xl border border-slate-200 text-slate-500 text-sm font-semibold hover:bg-slate-50 transition-colors">
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
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Identifiant</th>
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Ville</th>
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Code Postal</th>
                        <th class="text-left px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Revenu Mensuel</th>
                        <th class="text-center px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50">
                    <c:forEach var="c" items="${clients}">
                        <tr class="hover:bg-slate-50 transition-colors duration-100">
                            <td class="px-6 py-4">
                                <span class="font-mono text-xs font-semibold bg-slate-100 text-slate-600 rounded-md px-2 py-1">#${c.id}</span>
                            </td>
                            <td class="px-6 py-4">
                                <span class="inline-flex items-center gap-1.5 bg-indigo-50 text-indigo-700 text-xs font-semibold rounded-full px-3 py-1 uppercase tracking-wide">
                                    <i data-lucide="map-pin" class="w-3 h-3"></i>
                                    ${c.ville}
                                </span>
                            </td>
                            <td class="px-6 py-4 text-slate-600 font-medium">${c.cp}</td>
                            <td class="px-6 py-4">
                                <span class="font-bold text-slate-800">${c.revenu}</span>
                                <span class="text-slate-400 text-xs ml-1">€ / mois</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center justify-center gap-2">
                                    <a href="listePrets?searchIdClient=${c.id}" title="Voir les prêts"
                                       class="w-8 h-8 rounded-lg border border-slate-200 flex items-center justify-center text-slate-500 hover:bg-indigo-50 hover:border-indigo-200 hover:text-indigo-600 transition-all duration-150">
                                        <i data-lucide="landmark" class="w-3.5 h-3.5"></i>
                                    </a>
                                    <a href="editerClient.jsp?id=${c.id}&ville=${c.ville}&cp=${c.cp}&revenu=${c.revenu}" title="Modifier"
                                       class="w-8 h-8 rounded-lg border border-slate-200 flex items-center justify-center text-slate-500 hover:bg-indigo-50 hover:border-indigo-200 hover:text-indigo-600 transition-all duration-150">
                                        <i data-lucide="pencil" class="w-3.5 h-3.5"></i>
                                    </a>
                                    <a href="supprimerClient?id=${c.id}" title="Supprimer"
                                       onclick="return confirm('Supprimer définitivement le client #${c.id} ?')"
                                       class="w-8 h-8 rounded-lg border border-slate-200 flex items-center justify-center text-slate-500 hover:bg-rose-50 hover:border-rose-200 hover:text-rose-600 transition-all duration-150">
                                        <i data-lucide="trash-2" class="w-3.5 h-3.5"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty clients}">
                        <tr>
                            <td colspan="5" class="px-6 py-16 text-center">
                                <div class="flex flex-col items-center gap-3">
                                    <div class="w-12 h-12 bg-slate-100 rounded-full flex items-center justify-center">
                                        <i data-lucide="users" class="w-5 h-5 text-slate-400"></i>
                                    </div>
                                    <p class="text-slate-500 font-medium">Aucun client trouvé</p>
                                    <a href="listeClients?page=1" class="text-indigo-600 text-sm font-semibold hover:underline">Réinitialiser les filtres</a>
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
                    <a href="listeClients?page=${currentPage - 1}&searchId=${param.searchId}&searchVille=${param.searchVille}"
                       class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg border border-slate-200 text-xs font-semibold text-slate-600 transition-all hover:bg-slate-50 ${currentPage <= 1 ? 'opacity-40 pointer-events-none' : ''}">
                        <i data-lucide="chevron-left" class="w-3.5 h-3.5"></i> Précédent
                    </a>
                    <a href="listeClients?page=${currentPage + 1}&searchId=${param.searchId}&searchVille=${param.searchVille}"
                       class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg border border-slate-200 text-xs font-semibold text-slate-600 transition-all hover:bg-slate-50 ${currentPage >= totalPages ? 'opacity-40 pointer-events-none' : ''}">
                        Suivant <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
                    </a>
                </div>
            </div>
        </div>
    </main>

<script>lucide.createIcons();</script>
</body>
</html>