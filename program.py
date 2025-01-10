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

	
	l = log_helper.get_logger("app",
			datetime.now()
				.strftime("%Y%m%d%H%M%S")
		)

	l.info("Cargando configuracion del ambiente")
	SERVER = os.getenv('SERVER')
	DATABASE = os.getenv('DATABASE')
	USER_ID = os.getenv('USER_ID')
	PASSWORD = os.getenv('PASSWORD')


	connectionString = f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};TrustServerCertificate=yes;UID={USER_ID};PWD={PASSWORD}'
    
	try:
		l.info("Conectando a la Base de datos")
		conn = pyodbc.connect(connectionString)

		l.info("Buscando condiciones de credito")
		api_man.get_cond_credito(conn,'dico')

	except pyodbc.DatabaseError as dberror:
		l.error(f"No se pudo conectar a la bd {dberror}")
	finally:
		l.info("Cerrando conexion de Base de Datos")
		conn.close()


if __name__ == "__main__":
    main()
