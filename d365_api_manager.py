import requests
import json
import pyodbc
import re
from config_helper import *

from action_result import ActionResult
from log_helper import get_logger

""" Refrescar el token de conexion """
def refrescar_token(p_resource_url: str, p_client_id: str, p_client_secret: str, p_token_url: str) -> ActionResult:
    #TODO Agregar validacion de vigencia del token para no refrescarlo si no es necesario

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
        resultado.message = "No se pudo obtener el Token"

    
    return resultado


def sanitizar_valor(value)-> str:
    
    """Sanitiza los valores de entrada para evitar problemas por caracrteres especiales y los retorna en formato str"""
    valor = ''
    if not isinstance(value, str):
        valor = str(value)
    else:
        valor = value
    
    #Remove control characters
    valor = re.sub(r'[\x00-\x1F\x7F-\x9F]', '', valor)
    # Replace or remove other special characters as needed
    valor = valor.replace("'", "''")
    return valor


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


""" Busca las condiciones de creditos y las inserta en la BD """
def get_dir_clientes(p_conn: pyodbc.Connection, p_data_areaid: str, p_config: ConfigHelper) -> ActionResult:

    SERVICE_NAME = "COR_CustomerPostalAddresses"
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
                sql_query = f""" delete WS_CustomerPostalAddresses where dataAreaId = '{p_data_areaid}' """
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
                            #sql_query = "INSERT INTO WS_CustomerPostalAddresses (  odataetag, dataAreaId, CustomerAccountNumber, CustomerLegalEntityId, AddressLocationId, IsPrimary, IsRoleDelivery, AddressCity, AddressState, KCP_Freq, BusinessUnit_KCP, IsRoleInvoice, AddressLatitude, IsRoleHome, KCP_Days, AddressDescription, PersonnelNumber, AddressBuilding, Route_KCP, AddressStreet, VisitOrder_KCP, AddressCountyId, AddressLongitude, IsRoleBusiness, AddressZipCode, AddressCountryRegionId, AddressNum_KCP, KCP_FreqOrder, AddressStreetNumber, BuildingCompliment) VALUES ('{}', '{}', '{}', {})".format(
                            #    linea['dataAreaId'], linea['Name'], linea['Description'], linea['NumberOfDays']
                            #)

                            sql_query = '''
                            INSERT INTO WS_CustomerPostalAddresses (
                                odataetag, dataAreaId, CustomerAccountNumber, 
                                CustomerLegalEntityId, AddressLocationId, IsPrimary, 
                                IsRoleDelivery, AddressCity, AddressState, 
                                KCP_Freq, BusinessUnit_KCP, IsRoleInvoice, 
                                AddressLatitude, IsRoleHome, KCP_Days, 
                                AddressDescription, PersonnelNumber, 
                                Route_KCP, AddressStreet, VisitOrder_KCP, 
                                AddressCountyId, AddressLongitude, IsRoleBusiness, 
                                AddressZipCode, AddressCountryRegionId, AddressNum_KCP, 
                                KCP_FreqOrder, AddressStreetNumber, BuildingCompliment) 
                            VALUES ('{}', '{}', '{}', 
                                    '{}', '{}', '{}', 
                                    '{}', '{}', '{}',
                                    '{}', '{}', '{}', 
                                    '{}', '{}', '{}', 
                                    '{}', '{}',  
                                    '{}', '{}', '{}', 
                                    '{}', '{}', '{}', 
                                    '{}', '{}', '{}', 
                                    '{}', '{}', '{}')
                            '''.format(linea['@odata.etag'], linea['dataAreaId'], linea['CustomerAccountNumber'],
                                       linea['CustomerLegalEntityId'], linea['AddressLocationId'], linea['IsPrimary'],  
                                       linea['IsRoleDelivery'], linea['AddressCity'], linea['AddressState'],
                                       linea['KCP_Freq'], linea['BusinessUnit_KCP'], linea['IsRoleInvoice'],
                                       linea['AddressLatitude'], linea['IsRoleHome'], linea['KCP_Days'],
                                       linea['AddressDescription'], linea['PersonnelNumber'], 
                                       linea['Route_KCP'], linea['AddressStreet'], linea['VisitOrder_KCP'],
                                       linea['AddressCountyId'], linea['AddressLongitude'], linea['IsRoleBusiness'],
                                       linea['AddressZipCode'], linea['AddressCountryRegionId'], linea['AddressNum_KCP'],
                                       linea['KCP_FreqOrder'], linea['AddressStreetNumber'], linea['BuildingCompliment'])

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


import requests
import logging
import time

# Configura el logger
p_log = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

def solicitar_con_reintentos(p_url: str, p_headers: dict=None, 
                             p_max_reintentos: int=3, p_timeout: int=10, 
                             p_espera: int=5)-> ActionResult:
    """
    Realiza una solicitud HTTP GET a la URL proporcionada con reintentos en caso de error.
    '"""
    intentos = 0
    timeout = p_timeout * 60 # convertir a minutos
    resultado = ActionResult(success=True)

    while intentos < p_max_reintentos:
        try:
            request_response = requests.get(p_url, headers=p_headers, timeout=timeout)
            request_response.raise_for_status()
            resultado.value = request_response.json()
            return resultado
        except requests.exceptions.Timeout:
            resultado.success = False
            resultado.message = f"Timeout al solicitar {p_url}. Reintentando en {p_espera}s..."
        except requests.exceptions.RequestException as e:
            resultado.success = False
            resultado.message = f"Error en la solicitud {p_url}: {e}. Reintentando en {p_espera}s..."
            break  # Salimos si es otro error no recuperable

        intentos += 1
        time.sleep(p_espera)

    resultado.success = False
    resultado.message = f"No se pudo obtener la respuesta {p_url} tras {p_max_reintentos} intentos."
    return resultado



""" Busca los datos del servicio(o servicios) de la empresa desde la BD """
def get_servicio(p_conn: pyodbc.Connection, p_config: ConfigHelper, p_log: logging.Logger, 
                 p_url_servicio: str, p_token: str, p_servicio: str,
                 p_nombre_tabla: str, p_columnas_str: str, p_data_area_id: str) -> ActionResult:
    
    ar = ActionResult(success=True)
    total_registros = 0
    
    cursor = cursor = p_conn.cursor()

    #borramos los datos de la tabla
    p_log.info("Limpiando Tabla de Datos")
    sql_delete = f"delete {p_nombre_tabla} "
    if p_columnas_str.lower().find('dataareaid') >= 0:
        sql_delete = sql_delete + f"where dataAreaId = '{p_data_area_id}'" 

    count = cursor.execute(sql_delete).rowcount
    p_log.info(f"{count} registros borrados")

    #Preparamos los header
    request_headers = {
        'Authorization': 'Bearer ' + p_token,
        'OData-MaxVersion': '4.0',
        'OData-Version': '4.0',
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=utf-8',
        'Prefer': 'odata.maxpagesize=500',
        'Prefer': 'odata.include-annotations=OData.Community.Display.V1.FormattedValue'
    }


    #Este ciclo se mantiene haciendo llamadas al servicio Web mientras se recibaan nodos de paginacion O no haya un error
    url = p_url_servicio
    pagina = 0
    while url != '' and ar.success:
        pagina+=1
    
        p_log.info(f"Llamando a Servicio Web {url}")
        r = solicitar_con_reintentos(url, p_headers=request_headers, p_max_reintentos=3, p_timeout=5, p_espera=5)

        if r.success:

            request_results = r.value
            p_log.info(f"Procesando Pagina {pagina} ")
        
            #Guardar el json de respuesta
            with open(p_config.obtenerRutaArchivo(JSON_DIR, f"{p_servicio}_{pagina}.json"),"w") as file:
                json.dump(request_results, file)


            total_registros += len(request_results["value"])
                

            try:
                p_log.info("Insertando datos")
                for linea in request_results["value"]:

                    #creamos una lista con los nombres de las columnas y valiadamos que esas columnas existan en la lista de campos de la bd
                    campos_bd = [x.strip() for x in p_columnas_str.split(",")] #sacamos los campos de la bd sin espacios
                    cols = [x for x in campos_bd if x in linea.keys()] #nos aseguramos que los campos esten en el jsoon

                    #sacamos los valores y los formatemoas 
                    vals = [linea[key] for key in cols]
                    result = map(sanitizar_valor, vals)
                    
                    valores = list(result)

                    #creamos el insert con la tabla, las columans y los valores
                    sql_insert = "INSERT INTO {}({}) values ({})".format(
                        p_nombre_tabla, 
                        ", ".join(cols), 
                        ', '.join([f"'{item}'" for item in valores])
                        )
                    
                    try:
                        #ejecutamos el insert
                        cursor.execute(sql_insert)
                    except pyodbc.DatabaseError as err:
                        ar.success = False
                        ar.message = f"Error Base de Datos {err}"
                        p_log.error(ar.message)
                        p_log.error(sql_insert)
                p_conn.commit()
            except KeyError:
                ar.success = False
                ar.message = 'No se recibieron Datos'
                p_log.error(ar.message)
            except Exception as err:
                ar.success = False
                ar.message = f"Error general {err}"
                p_log.error(ar.message)
        
            #validamos si hay un proximo link para nuevos resultados
            url = request_results.get('@odata.nextLink','')
        else:
            ar.success = False
            ar.message = f"Error al procesar el servicio {p_servicio} {r.message}"
            p_log.error(ar.message)
            break

    ar.message = f"{total_registros} procesados Exitosamente" if ar.success else f"Error al procesar {total_registros} registros"
    p_log.info(ar.message)                
    return ar


def procesa_servicios_get(p_conn: pyodbc.Connection, p_data_areaid: str, p_config: ConfigHelper, p_servicio: str) -> ActionResult:
    
    #FIXME: Ver como se puede poner que el log se cerre por llamada a servicio en el caso de cada llamada 
    l = get_logger(p_servicio, p_config) #log de ejecucion

    ar = ActionResult(success=True)

    #si la coneccion esta abierta
    if (p_conn):
        #buscamos los datos de conexion del servicio
        l.info("Buscando los datos a procesar")

        sql_and = "and service_name = '{}'".format(p_servicio) if p_servicio != 'TODOS' else ''
        sql_query = """select data_area_id , service_name , service_url , 
                        client_id ,    client_secret , token_endpoint , 
                        token_resource , table_name, column_list
                        from d365_ws_control dwc  
                        where data_area_id  = '{}' {}
                        order by data_area_id, service_name
                    """.format(p_data_areaid, sql_and)
        

        cursor = p_conn.cursor()
        cursor.execute(sql_query)
        for row in cursor.fetchall(): 
            l.info(f"Procesando {row.service_name} de {row.data_area_id}")

            try:
                l.info("Refrescando Token")
                resultado = refrescar_token(row.token_resource, row.client_id, row.client_secret, row.token_endpoint)

                if (resultado.success):
                    accesstoken = str(resultado.value)

                    ar = get_servicio(p_conn, p_config, l, row.service_url, accesstoken, row.service_name, 
                                row.table_name, row.column_list, row.data_area_id)
                
                else:
                    ar.success = False
                    ar.message = f"No se pudo obetener el token, {resultado.message}"
                    l.error(ar.message)
                
            except pyodbc.DatabaseError as err:
                ar.success = False
                ar.message = f"No se pudo obtener la informacion desde la BD {err.message}"
                l.error(ar.message)            

        return ar