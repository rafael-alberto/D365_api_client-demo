import requests
import d365_api_manager as api_man

import logging
from datetime import datetime
import log_helper

from dotenv import load_dotenv
import os
import pyodbc


load_dotenv()

 
def main():
	#TODO: parametros desde linea de comando

	#creamos el logger principal de la aplicacion, con la hora de ejecucion como posfijo del archivo log
	time_of_exec = datetime.now().strftime("%Y%m%d%H%M%S")
	l = log_helper.get_logger("app", time_of_exec)

	l.info("Cargando configuracion del ambiente")
	SERVER = os.getenv('SERVER')
	DATABASE = os.getenv('DATABASE')
	USER_ID = os.getenv('USER_ID')
	PASSWORD = os.getenv('PASSWORD')


	connectionString = f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};TrustServerCertificate=yes;UID={USER_ID};PWD={PASSWORD}'
    
	try:
		
		l.info("Conectando a la Base de datos")
		with pyodbc.connect(connectionString) as conn:
			
			#TODO: Dependiento de los parametros enviados en la linea de comandos ejecutamos las llamadas.

			l.info("Buscando condiciones de credito")
			api_man.get_cond_credito(conn,'dico')


		l.info("Proceso Finalizado")

	except pyodbc.DatabaseError as dberror:
		l.error(f"No se pudo conectar a la bd {dberror}")


if __name__ == "__main__":
    main()
