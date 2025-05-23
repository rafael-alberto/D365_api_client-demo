from datetime import datetime
import os

from dotenv import load_dotenv

LOGS_DIR = 'logs'
JSON_DIR = 'json'


class ConfigHelper:
    log_level = "INFO"

    def __init__(self):
        self.current_time = datetime.now()
        self.time_of_exec = self.current_time.strftime("%Y%m%d%H%M%S")
        self.server = ""
        self.database = ""
        self.user_id = ""
        self.password = ""


    def cargarConfiguracion(self):
        load_dotenv()
        
        self.server = os.getenv('SERVER')
        self.database = os.getenv('DATABASE')
        self.user_id = os.getenv('USER_ID')
        self.password = os.getenv('PASSWORD')

        self.crearDir(LOGS_DIR)
        self.crearDir(JSON_DIR)


    
    def obtenerCadenaBD(self) -> str:
        return f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={self.server};DATABASE={self.database};TrustServerCertificate=yes;UID={self.user_id};PWD={self.password}'


    def obtenerRutaArchivo(self, p_dir: str, p_archivo: str, p_agregar_tiempo: bool = True) -> str:
        
        nombre = p_archivo.split(".")[0]
        extension = p_archivo.split(".")[1]
        
        if (p_agregar_tiempo):
            nombre.join(f"-{self.time_of_exec}")

        return os.path.join(p_dir, f"{nombre}.{extension}")

	
    #crea el directorio si no existe
    def crearDir(self, p_nombre_dir: str):
	    if not os.path.exists(p_nombre_dir):
		    os.makedirs(p_nombre_dir)


