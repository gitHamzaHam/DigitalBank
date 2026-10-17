from flask import Flask, request, jsonify
import joblib
import numpy as np
app = Flask(__name__)
# CHARGEMENT DU MODÈLE ET DU SCALER
model = joblib.load('modele_banque.pkl')
scaler = joblib.load('scaler_banque.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json
        # 1. Extraction des données brutes de Java
        raw_features = [
            float(data['revenu']),
            float(data['remboursement']),
            float(data['duree']),
            float(data['taux']),
            int(data['type'])
        ]
        # On transforme la liste en tableau 2D pour le scaler
        features_scaled = scaler.transform([raw_features])
        
        # 3. Prédiction avec les données normalisées
        prediction = model.predict(features_scaled)[0]
        
        return jsonify({"risk_score": str(prediction)})
        
    except Exception as e:
        return jsonify({"risk_score": "Erreur : " + str(e)})

if __name__ == '__main__':
    app.run(port=5000, debug=True)