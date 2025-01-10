import requests
import json
import pyodbc

from action_result import ActionResult


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
def get_cond_credito(p_conn: pyodbc.Connection, p_data_areaid: str):
    #TODO: modificar con log de ejecucion, 
    SERVICE_NAME = "COR_PaymentTerms"

    #si la coneccion esta abierta
    if (p_conn):
        #buscamos los datos de conexion del servicio
        sql_query = f"""select data_area_id , service_name , service_url , client_id , client_secret , token_endpoint , token_resource 
                    from d365_ws_control dwc  where data_area_id  = '{p_data_areaid}' and service_name = '{SERVICE_NAME}'"""

        cursor = p_conn.cursor()
        cursor.execute(sql_query)
        r = cursor.fetchone()

        #refrescamos el token
        resultado = refrescar_token(r.token_resource, r.client_id, r.client_secret, r.token_endpoint) 
        
        if (resultado.success):
            accesstoken = resultado.value

            #borramos los datos de la tabla
            sql_query = f""" delete WS_PaymentTerms where dataAreaId = '{p_data_areaid}' """
            count = cursor.execute(sql_query).rowcount
            print (f"{count} registros borrados")

         
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
            request_response = requests.get(url, headers=request_headers)
            #TODO: guardar el json de peticion

            while url != '':
                request_results = request_response.json()        
                #TODO: Guardar el json de respuesta
                     
                try:
                    for linea in request_results["value"]:
                        sql_query = "INSERT INTO Ws_PaymentTerms (dataAreaId,Name,Description,NumberOfDays) VALUES ('{}', '{}', '{}', {})".format(
                            linea['dataAreaId'], linea['Name'], linea['Description'], linea['NumberOfDays']
                        )
                        cursor.execute(sql_query)
                    p_conn.commit()
                except KeyError:
	                #handle any missing key errors
	                print('No se recibieron Datos')
                except pyodbc.DatabaseError as err:
                    print(err)

                #validamos si hay un proximo link para nuevos resultados
                url = request_results.get('@odata.nextLink','')




        #insertamos en la tabla


        #si hay mas registros continuamos


def get_productos():
    #TODO: Pongamos algo de codigo
    pass


def post_pedidos():
    #TODO: Hay que poner esta vaina a funcionar
    pass