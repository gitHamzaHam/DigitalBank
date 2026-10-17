# 🏦 DigitalBank — Loan Management System

A full-stack banking loan management application built with **Java EE** and an **AI-powered risk prediction** engine.

---

## 📁 Project Structure

```
DigitalBank/
├── backend/        → Java EE Web App (Servlets + JSP + MySQL)
└── ai/             → Python AI Risk Prediction Service (Flask + Scikit-learn)
```

---

## 🖥️ Backend — Java EE

### Tech Stack
- **Java EE** — Servlets, JSP, JSTL
- **MySQL** — Database (`gestion_prets.sql`)
- **Tomcat** — Application Server (via SmartTomcat plugin)
- **Bootstrap 5.3** — Frontend styling
- **Font Awesome 6.4** — Icons

### Features
- 🔐 Admin login / logout
- 👥 Client management (CRUD, search, pagination)
- 💰 Loan (Prêt) listing with type filtering (Immobilier / Automobile)
- 📊 AI Risk prediction per client

### Setup
1. Import project into **IntelliJ IDEA**
2. Create the MySQL database using `backend/dataBase/gestion_prets.sql`
3. Configure DB credentials in `DBConnection.java`
4. Deploy on **Tomcat** using the SmartTomcat plugin
5. Access at `http://localhost:8080/ProjetGestionprets`

---

## 🤖 AI — Risk Prediction Service

### Tech Stack
- **Python 3**
- **Flask** — REST API
- **Scikit-learn** — ML model (`.pkl`)
- **Jupyter Notebook** — Model training (`PredictionRisque.ipynb`)

### Features
- Predicts loan risk (Risque Faible / Risque Élevé) for a given client
- Exposes a REST endpoint consumed by the Java EE backend

### Setup
```bash
cd ai
python -m venv venv
venv\Scripts\activate      # Windows
pip install flask scikit-learn
python app.py
```
API runs at `http://localhost:5000`

---

## 🗄️ Database

Import the SQL schema:
```bash
mysql -u root -p < backend/dataBase/gestion_prets.sql
```

---

## 👤 Author
**Hamza** — [@gitHamzaHam](https://github.com/gitHamzaHam)
