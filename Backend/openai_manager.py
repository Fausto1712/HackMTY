import requests
import os
from dotenv import load_dotenv  
load_dotenv()

api_key = os.environ.get('OPENAI_API_KEY')

def get_response(prompt: str):

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}"
    }

    response_json = requests.post("https://api.openai.com/v1/chat/completions", headers=headers, json={
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": prompt}],
        "temperature": 0
    }).json()

    response = response_json['choices'][0]['message']['content']

    return response


