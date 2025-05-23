proyecto en Python para conectar a servicios odata de Dynamics 365. para instalación se requiere tener UV como manejador de paquetes y luego correr la instrucción siguiente dentro de la carpeta del proyecto: uv run program.py

Este proyecto se conecta a sqlserver usando pyodbc por lo que hay que tener instalados los drivers y un archivo .env con las variables siguientes 

    SERVER
    DATABASE
    USER_ID
    PASSWORD
