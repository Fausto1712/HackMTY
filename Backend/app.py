from openai_manager import *
from fastapi import FastAPI, Form
from fastapi.middleware.cors import CORSMiddleware
from data_management import app_info
# python -m uvicorn app:app --reload

app = FastAPI()

app.add_middleware(
  CORSMiddleware,
  allow_origins=["*"],
  allow_credentials=True,
  allow_methods=["*"],
  allow_headers=["*"],
)

@app.get("/")
def read_root():
    res = get_response("Hola gemini, responde con un chiste.")
    return {"response": res}

@app.get("/chat/{specialization}")
def chat(specialization: str, userData: str = Form(...), prompt: str = Form(...)): 


    new_prompt = f"Eres un chatbot de una app de banco especializado en {specialization}. Esto es algo de información del usuario: {userData}. Contesta la siguiente solicitud del usuario: {prompt}. SE ESPECIFICO Y SIN UTILIZAR EMOJIS O CARACTERES ESPECIALES COMO '**' o  '_' o '\n'"

    if specialization == "Dudas de la app":
        new_prompt = new_prompt + "ESTA ES LA INFORMACION DE LA APP: " + app_info
        response = get_response(prompt)
    else:
        response = get_response(new_prompt)

    return {"response": response}

@app.post("/chat2/{specialization}")
def chat2(specialization: str, userData: str = Form(...), prompt: str = Form(...)): 


    new_prompt = f"Eres un chatbot de una app de banco especializado en {specialization}. Esto es algo de información del usuario: {userData}. Contesta la siguiente solicitud del usuario: {prompt}. SE ESPECIFICO Y SIN UTILIZAR EMOJIS O CARACTERES ESPECIALES COMO '**' o  '_' o '\n'"


    if specialization == "Dudas de la app":
        new_prompt = new_prompt + "ESTA ES LA INFORMACION DE LA APP: " + app_info
        response = get_response(prompt)
    else:
        response = get_response(new_prompt)

    return {"response": response}
    
@app.get("/stats")
def stats(transactions: str = Form(...), userData: str = Form(...)):

    new_prompt = f"""
        Estos son los datos de las transacciones de un usuario en una cuenta de banco: {transactions}. Esta es la información del usuario: {userData}.
        
        Necesito que categorizes las transacciones en algunas de las categorias (Entretenimiento, Electrónica, Hogar, Otros, Restaurante, Salud, Servicios, Supermercado, Transporte, Viajes, Ropa y calzado) y me digas cuanto porcentaje de las transacciones se va a cada categoria. 
        
        Como resultado me tienes que dar un diccionario con el porcentaje de las transacciones que se va a cada categoria, si la categoria tiene 0% NO LA MENCIONES. El porcentaje lo tienes que dar en formato de decimal.

        SE CLARO Y SIN UTILIZAR EMOJIS O CARACTERES ESPECIALES COMO '**' o  '_' o '\n'"

    """

    stats = get_response(new_prompt)

    # convert str to dict
    stats = eval(stats)

    suggestions = get_response(f"Estos son los datos de las transacciones de un usuario en una cuenta de banco: {transactions}. Esta es la distribucion de sus transacciones en las categorias: {stats}. Basado en esto, dame sugerencias para que el usuario administre su dinero mejor. SE CLARO Y SIN UTILIZAR EMOJIS O CARACTERES ESPECIALES COMO '**' o  '_' o '\n'. Habla con el usuario en primera persona. Esta es la información del usuario: {userData}.")

    return {'stats': stats, 'suggestions': suggestions}

@app.post("/stats2")
def stats(transactions: str = Form(...), userData: str = Form(...)):

    new_prompt = f"""
        Estos son los datos de las transacciones de un usuario en una cuenta de banco: {transactions}. Esta es la información del usuario: {userData}.
        
        Necesito que categorizes las transacciones en algunas de las categorias (Entretenimiento, Electrónica, Hogar, Otros, Restaurante, Salud, Servicios, Supermercado, Transporte, Viajes, Ropa y calzado) y me digas cuanto porcentaje de las transacciones se va a cada categoria. 
        
        Como resultado me tienes que dar un diccionario con el porcentaje de las transacciones que se va a cada categoria, si la categoria tiene 0% NO LA MENCIONES. El porcentaje lo tienes que dar en formato de decimal.

        SE CLARO Y SIN UTILIZAR EMOJIS O CARACTERES ESPECIALES COMO '**' o  '_' o '\n'"

    """

    stats = get_response(new_prompt)

    # convert str to dict
    stats = eval(stats)

    suggestions = get_response(f"Estos son los datos de las transacciones de un usuario en una cuenta de banco: {transactions}. Esta es la distribucion de sus transacciones en las categorias: {stats}. Basado en esto, dame sugerencias para que el usuario administre su dinero mejor por cada categoria que hay en la distribucion. ASE CLARO Y SIN UTILIZAR EMOJIS O CARACTERES ESPECIALES COMO '**' o  '_' o '\n'. Habla con el usuario en primera persona. Esta es la información del usuario: {userData}.")

    return {'stats': stats, 'suggestions': suggestions}