<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DigitalBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Plus Jakarta Sans', 'sans-serif'] },
                    colors: {
                        brand: { DEFAULT: '#4f46e5', light: '#eef2ff', dark: '#3730a3' }
                    }
                }
            }
        }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; -webkit-font-smoothing: antialiased; }
        .nav-link-active { color: #4f46e5 !important; font-weight: 600; }
        input:focus, select:focus, textarea:focus { outline: none; }
        .btn-primary { background: #4f46e5; color: white; border-radius: 0.75rem; padding: 0.625rem 1.25rem; font-weight: 600; transition: all 0.15s; }
        .btn-primary:hover { background: #3730a3; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(79,70,229,0.35); }
        .card { background: white; border-radius: 1rem; box-shadow: 0 1px 3px rgba(0,0,0,0.07), 0 4px 12px rgba(0,0,0,0.04); }
        .input-field { width: 100%; border: 1.5px solid #e2e8f0; border-radius: 0.75rem; padding: 0.625rem 0.875rem; font-size: 0.9rem; background: white; transition: border-color 0.15s, box-shadow 0.15s; }
        .input-field:focus { border-color: #4f46e5; box-shadow: 0 0 0 3px rgba(79,70,229,0.12); }
        .badge-immo { background: #dbeafe; color: #1e40af; }
        .badge-auto { background: #fef3c7; color: #92400e; }
        ::-webkit-scrollbar { width: 6px; } ::-webkit-scrollbar-track { background: #f1f5f9; } ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 3px; }
    </style>
</head>
<body class="bg-slate-50 text-slate-900 min-h-screen">

<!-- TOP NAVBAR -->
<nav class="bg-white border-b border-slate-100 sticky top-0 z-50" style="box-shadow: 0 1px 3px rgba(0,0,0,0.06);">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
        <a href="menu" class="flex items-center gap-2.5 font-extrabold text-xl text-indigo-600 tracking-tight">
            <div class="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center">
                <i data-lucide="landmark" class="w-4 h-4 text-white"></i>
            </div>
            DigitalBank
        </a>
        <div class="flex items-center gap-7 text-sm font-medium text-slate-500">
            <a href="menu" class="hover:text-indigo-600 transition-colors duration-150" id="nav-accueil">Accueil</a>
            <a href="listeClients?page=1" class="hover:text-indigo-600 transition-colors duration-150" id="nav-clients">Clients</a>
            <a href="listePrets" class="hover:text-indigo-600 transition-colors duration-150" id="nav-prets">Prêts</a>
            <div class="h-5 w-px bg-slate-200"></div>
            <span class="flex items-center gap-1.5 text-slate-400">
                <i data-lucide="user-circle" class="w-4 h-4"></i>
                <span class="text-slate-600 font-semibold">${sessionScope.adminConnecte}</span>
            </span>
            <a href="logout" class="flex items-center gap-1.5 text-rose-500 hover:text-rose-700 transition-colors duration-150 font-semibold">
                <i data-lucide="log-out" class="w-4 h-4"></i>
                Déconnexion
            </a>
        </div>
    </div>
</nav>
