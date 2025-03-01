import requests
import json
import pyodbc
from config_helper import *

from action_result import ActionResult
from log_helper import get_logger

""" Refrescar el token de conexion """
def refrescar_token(p_resource_url: str, p_client_id: str, p_client_secret: str, p_token_url: str) -> ActionResult:

    username = ""
    userpassword = ""


    tokenpost = {
	    'client_id':p_client_id,
	    'resource':p_resource_url,
	    'client_secret': p_client_secret,
	    'username':username,
	    'password':userpassword,
	    'grant_type':'client_credentials'
	}
	 
	#make the token request
    tokenres = requests.post(p_token_url, data=tokenpost)
    json_data = tokenres.json()
	 
	#set accesstoken variable to empty string
    accesstoken = ''
	
    resultado = ActionResult()

	#extract the access token
    accesstoken = json_data.get('access_token', "")
    if (accesstoken != ""):
        #return accesstoken
        resultado.success = True
        resultado.value = accesstoken
    else:
        resultado.success = False
        message = "No se pudo obtener el Token"

    
    return resultado


""" Busca las condiciones de creditos y las inserta en la BD """
def get_cond_credito(p_conn: pyodbc.Connection, p_data_areaid: str, p_config: ConfigHelper) -> ActionResult:

    SERVICE_NAME = "COR_PaymentTerms"
    l = get_logger(SERVICE_NAME, p_config) #log de ejecucion

    ar = ActionResult(success=True)

    #si la coneccion esta abierta
    if (p_conn):
        #buscamos los datos de conexion del servicio
        l.info("Buscando los datos de ejecucion del servicio")
        sql_query = f"""select data_area_id , service_name , service_url , client_id , client_secret , token_endpoint , token_resource 
                    from d365_ws_control dwc  where data_area_id  = '{p_data_areaid}' and service_name = '{SERVICE_NAME}'"""

        cursor = p_conn.cursor()
        cursor.execute(sql_query)
        r = cursor.fetchone()

        #refrescamos el token
        if (r):
            l.info("Refrescando Token")
            resultado = refrescar_token(r.token_resource, r.client_id, r.client_secret, r.token_endpoint) 
        
            if (resultado.success):
                accesstoken = resultado.value

                #borramos los datos de la tabla
                l.info("Limpiando Tabla de Datos")
                sql_query = f""" delete WS_PaymentTerms where dataAreaId = '{p_data_areaid}' """
                count = cursor.execute(sql_query).rowcount
                l.info(f"{count} registros borrados")

            
                #conectamos y descargamos los datos desde D365
                #Preparamos los header
                request_headers = {
                    'Authorization': 'Bearer ' + accesstoken,
                    'OData-MaxVersion': '4.0',
                    'OData-Version': '4.0',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json; charset=utf-8',
                    'Prefer': 'odata.maxpagesize=500',
                    'Prefer': 'odata.include-annotations=OData.Community.Display.V1.FormattedValue'
                }
                


                url = ''
                url = r.service_url
                pagina = 0
                total_registros = 0
                
                #Este ciclo se mantiene haciendo llamadas al servicio Web mientras se recibaan nodos de paginacion
                while url != '':
                    pagina+=1

                    l.info(f"Llamando a Servicio Web {url}")
                    request_response = requests.get(url, headers=request_headers)

                    l.info(f"Recibiendo Respuesta {pagina} ")
                    request_results = request_response.json()

                    #Guardar el json de respuesta
                    p_config
                    with open(p_config.obtenerRutaArchivo(JSON_DIR, f"{SERVICE_NAME}.json"),"w") as file:
                        json.dump(request_results, file)
                    
                    total_registros += len(request_results["value"])
                    try:
                        l.info("Insertando datos")
                        for linea in request_results["value"]:
                            sql_query = "INSERT INTO Ws_PaymentTerms (dataAreaId,Name,Description,NumberOfDays) VALUES ('{}', '{}', '{}', {})".format(
                                linea['dataAreaId'], linea['Name'], linea['Description'], linea['NumberOfDays']
                            )
                            cursor.execute(sql_query)
                        p_conn.commit()
                    except KeyError:
                        ar.success = False
                        ar.message = 'No se recibieron Datos'
                        l.error(ar.message)
                    except pyodbc.DatabaseError as err:
                        ar.success = False
                        ar.message = f"Error Base de Datos {err}"
                        l.error(ar.message)

                    #validamos si hay un proximo link para nuevos resultados
                    url = request_results.get('@odata.nextLink','')

                ar.message = f"{total_registros} procesados Exitosamente"
                l.info(ar.message)
            else:
                ar.success = False
                ar.message = f"No se pudo obetener el token, {resultado.message}"
                l.error(ar.message)

        else:
            ar.success = False
            ar.message = f"No se pudo obtener la informacion desde la BD"
            l.error(ar.message)            

        return ar


def get_productos():
    #TODO: Pongamos algo de codigo
    pass


def post_pedidos():
    #TODO: Hay que poner esta vaina a funcionar
    pass