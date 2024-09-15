import requests
import os
from dotenv import load_dotenv  
load_dotenv()

api_url = os.environ.get('API_URL')

def get_response(prompt: str):
    
    try:

        payload = {
            "contents": [{
                "parts": [{
                    "text": prompt
                }]
            }]
        }

        # Llamada a la API de Gemini
        response_ai = requests.post(api_url, json=payload)
        response_ai.raise_for_status()
        ai_response = response_ai.json()

        # Extraer el texto de la respuesta de Gemini
        if 'candidates' in ai_response and ai_response['candidates']:
            res = ai_response['candidates'][0]['content']['parts'][0]['text']
            return {"response": res}
        else:
            return {"error": "No se recibió una respuesta válida de la IA"}
        
    except requests.RequestException as e:
        return {"error": f"Error en la solicitud: {str(e)}"}
    except Exception as e:
        return {"error": f"Error inesperado: {str(e)}"}
