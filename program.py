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
	parser.add_argument("-p","--proceso", 
					 default="TODOS", 
					 help="El proceso a realizar: el parametro TODOS ejecuta todas las llamadas de la empresa, de lo contrario hay que poner el nombre del servicio")
	parser.add_argument("-d","--data_area_id", 
					 help="La empresa (Data AreaId en Dynamics) a procesar")
	parser.add_argument("-l","--log",
					 default="INFO", 
					 help="El nivel de log a utilizar: DEBUG, INFO, WARNING, ERROR, CRITICAL")
	args=parser.parse_args()
	
	#carga de la configuracion
	cf = ConfigHelper()
	cf.log_level = args.log
	cf.cargarConfiguracion()


	#creamos el logger principal de la aplicacion, con la hora de ejecucion como posfijo del archivo log
	time_of_exec = datetime.now().strftime("%Y%m%d%H%M%S")
	l = log_helper.get_logger("app", cf)


	try:
		
		l.info("Conectando a la Base de datos")
		with pyodbc.connect(cf.obtenerCadenaBD()) as conn:
			proceso = args.proceso
			dataAreaId = args.data_area_id

			#Dependiento de los parametros enviados en la linea de comandos ejecutamos las llamadas.			
			l.info("Procesando Servicios Get")
			r = api_man.procesa_servicios_get(conn,dataAreaId, cf, proceso) #FIXME: Modificar la funcion para que reciba la instancia del logger de la aplicacion
			l.info(r.message) if r.success else l.error(r.message)

			

		l.info("Proceso Finalizado")

	except pyodbc.DatabaseError as dberror:
		l.error(f"No se pudo conectar a la bd {dberror}")


if __name__ == "__main__":
	main()
