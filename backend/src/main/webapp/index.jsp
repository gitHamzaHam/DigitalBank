<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DigitalBank — Connexion</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = { theme: { extend: { fontFamily: { sans: ['Plus Jakarta Sans', 'sans-serif'] } } } }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; -webkit-font-smoothing: antialiased; }
        .input-field { width: 100%; border: 1.5px solid #e2e8f0; border-radius: 0.75rem; padding: 0.75rem 1rem 0.75rem 2.75rem; font-size: 0.9rem; background: white; transition: border-color 0.2s, box-shadow 0.2s; color: #0f172a; }
        .input-field:focus { outline: none; border-color: #4f46e5; box-shadow: 0 0 0 3px rgba(79,70,229,0.12); }
        .btn-login { width: 100%; background: #4f46e5; color: white; border-radius: 0.75rem; padding: 0.8rem; font-weight: 700; font-size: 0.95rem; letter-spacing: 0.01em; transition: all 0.2s; border: none; cursor: pointer; }
        .btn-login:hover { background: #3730a3; transform: translateY(-1px); box-shadow: 0 6px 20px rgba(79,70,229,0.4); }
        .btn-login:active { transform: translateY(0); }
    </style>
</head>
<body class="min-h-screen flex">

    <!-- LEFT PANEL — Branding -->
    <div class="hidden lg:flex flex-col justify-between w-1/2 bg-indigo-600 p-12 relative overflow-hidden">
        <!-- Background decoration -->
        <div class="absolute top-0 left-0 w-full h-full opacity-10">
            <svg viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg" class="w-full h-full">
                <circle cx="300" cy="80" r="180" fill="white"/>
                <circle cx="50" cy="350" r="120" fill="white"/>
                <circle cx="200" cy="200" r="80" fill="white"/>
            </svg>
        </div>
        <!-- Logo -->
        <div class="relative z-10 flex items-center gap-3">
            <div class="w-10 h-10 bg-white bg-opacity-20 rounded-xl flex items-center justify-center">
                <i data-lucide="landmark" class="w-5 h-5 text-white"></i>
            </div>
            <span class="text-white font-extrabold text-2xl tracking-tight">DigitalBank</span>
        </div>
        <!-- Main content -->
        <div class="relative z-10 space-y-6">
            <div class="w-12 h-1 bg-white bg-opacity-40 rounded-full"></div>
            <h1 class="text-white font-extrabold text-4xl leading-tight">
                Votre plateforme<br>bancaire intelligente.
            </h1>
            <p class="text-indigo-200 text-lg leading-relaxed max-w-sm">
                Gérez vos clients, analysez les dossiers de prêts et obtenez des prédictions de risque en temps réel.
            </p>
            <!-- Feature pills -->
            <div class="flex flex-wrap gap-3 pt-2">
                <div class="flex items-center gap-2 bg-white bg-opacity-15 rounded-full px-4 py-2">
                    <i data-lucide="users" class="w-4 h-4 text-indigo-100"></i>
                    <span class="text-indigo-100 text-sm font-medium">Gestion Clients</span>
                </div>
                <div class="flex items-center gap-2 bg-white bg-opacity-15 rounded-full px-4 py-2">
                    <i data-lucide="brain-circuit" class="w-4 h-4 text-indigo-100"></i>
                    <span class="text-indigo-100 text-sm font-medium">Analyse IA</span>
                </div>
                <div class="flex items-center gap-2 bg-white bg-opacity-15 rounded-full px-4 py-2">
                    <i data-lucide="shield-check" class="w-4 h-4 text-indigo-100"></i>
                    <span class="text-indigo-100 text-sm font-medium">Sécurisé</span>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <div class="relative z-10">
            <p class="text-indigo-300 text-sm">© 2026 DigitalBank. Tous droits réservés.</p>
        </div>
    </div>

    <!-- RIGHT PANEL — Login Form -->
    <div class="flex-1 flex items-center justify-center p-8 bg-slate-50">
        <div class="w-full max-w-md">
            <!-- Mobile logo -->
            <div class="lg:hidden flex items-center gap-2 mb-8">
                <div class="w-9 h-9 bg-indigo-600 rounded-xl flex items-center justify-center">
                    <i data-lucide="landmark" class="w-4 h-4 text-white"></i>
                </div>
                <span class="font-extrabold text-xl text-indigo-600">DigitalBank</span>
            </div>

            <div class="mb-8">
                <h2 class="text-3xl font-extrabold text-slate-900 tracking-tight">Bon retour 👋</h2>
                <p class="text-slate-500 mt-2 text-sm">Connectez-vous à votre espace administration.</p>
            </div>

            <!-- Error alert -->
            <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="flex items-center gap-3 bg-rose-50 border border-rose-200 text-rose-700 rounded-xl px-4 py-3 mb-6 text-sm">
                <i data-lucide="circle-alert" class="w-4 h-4 flex-shrink-0"></i>
                <span>Identifiant ou mot de passe incorrect. Veuillez réessayer.</span>
            </div>
            <% } else if ("db".equals(request.getParameter("error"))) { %>
            <div class="flex items-center gap-3 bg-rose-50 border border-rose-200 text-rose-700 rounded-xl px-4 py-3 mb-6 text-sm">
                <i data-lucide="server-crash" class="w-4 h-4 flex-shrink-0"></i>
                <span>Erreur de connexion à la base de données.</span>
            </div>
            <% } %>

            <form action="login" method="post" class="space-y-5">
                <!-- Identifiant -->
                <div>
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Identifiant</label>
                    <div class="relative">
                        <i data-lucide="user" class="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2"></i>
                        <input type="text" name="login" class="input-field" placeholder="admin" required autocomplete="username">
                    </div>
                </div>
                <!-- Mot de passe -->
                <div>
                    <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2">Mot de passe</label>
                    <div class="relative">
                        <i data-lucide="lock" class="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2"></i>
                        <input type="password" name="password" id="passwordField" class="input-field" placeholder="••••••••" required autocomplete="current-password">
                        <button type="button" onclick="togglePwd()" class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600">
                            <i data-lucide="eye" class="w-4 h-4" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>
                <!-- Submit -->
                <div class="pt-2">
                    <button type="submit" class="btn-login">
                        Se connecter
                    </button>
                </div>
            </form>

            <p class="text-center text-slate-400 text-xs mt-8">Accès réservé aux administrateurs autorisés.</p>
        </div>
    </div>

<script>
    lucide.createIcons();
    function togglePwd() {
        const f = document.getElementById('passwordField');
        const icon = document.getElementById('eyeIcon');
        if (f.type === 'password') { f.type = 'text'; icon.setAttribute('data-lucide', 'eye-off'); }
        else { f.type = 'password'; icon.setAttribute('data-lucide', 'eye'); }
        lucide.createIcons();
    }
</script>
</body>
</html>