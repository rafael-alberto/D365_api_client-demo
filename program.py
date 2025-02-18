import requests
import d365_api_manager as api_man

import logging
from datetime import datetime

import log_helper
from config_helper import ConfigHelper

import argparse
import pyodbc



def main():
	#Configuracion de parametros desde linea de comando
	parser=argparse.ArgumentParser(description="Cliente para consumo de Apis D365")
	parser.add_argument("-p","--proceso", default="td", choices=['td', 'pd', 'cc', 'pr'], help="El proceso a realizar: td= todos, cc=condicion credito, pr=productos, pd=pedidos")
	args=parser.parse_args()
	
	#carga de la configuracion
	cf = ConfigHelper()
	cf.cargarConfiguracion()


	#creamos el logger principal de la aplicacion, con la hora de ejecucion como posfijo del archivo log
	time_of_exec = datetime.now().strftime("%Y%m%d%H%M%S")
	l = log_helper.get_logger("app", cf)


	try:
		
		l.info("Conectando a la Base de datos")
		with pyodbc.connect(cf.obtenerCadenaBD()) as conn:
		
			#Dependiento de los parametros enviados en la linea de comandos ejecutamos las llamadas.
			if (args.proceso=="td") or (args.proceso=="cc"):
				l.info("Buscando condiciones de credito")
				r = api_man.get_cond_credito(conn,'dico', cf)
				l.info(r.message) if r.success else l.error(r.message)

			if (args.proceso=="td") or (args.proceso=="pr"):
				l.info("Buscando maestro de pedidos")
				r = api_man.get_productos(conn,'dico', cf)
				l.info(r.message) if r.success else l.error(r.message)

			if (args.proceso=="td") or (args.proceso=="pd"):
				l.info("Enviando pedidos")
				r = api_man.post_pedidos(conn,'dico', cf)
				l.info(r.message) if r.success else l.error(r.message)

		l.info("Proceso Finalizado")

	except pyodbc.DatabaseError as dberror:
		l.error(f"No se pudo conectar a la bd {dberror}")


if __name__ == "__main__":
	main()
