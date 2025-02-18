import logging
from datetime import datetime
from config_helper import *


""" Crear una instancia de la clase logger con la configuracion esperada """
def get_logger(p_name: str, p_config: ConfigHelper) -> logging.Logger:


    #obtener la instancia
    logger = logging.getLogger(p_name)
    logger.setLevel("INFO")

    #crear los manejadores
    console_handler = logging.StreamHandler()
    file_handler = logging.FileHandler(p_config.obtenerRutaArchivo(LOGS_DIR, f"{p_name}.log"), 
                                        mode="a", 
                                        encoding="utf-8")

    logger.addHandler(console_handler)
    logger.addHandler(file_handler)

    #dar formato
    formatter = logging.Formatter(
        "{asctime} - {levelname} - {message}",
        style="{",
        datefmt="%Y-%m-%d %H:%M:%S",
        )    

    console_handler.setFormatter(formatter)
    file_handler.setFormatter(formatter)

    return logger


