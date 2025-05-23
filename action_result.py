class ActionResult:
    def __init__(self, success=False, message="", value=None):
        """
        Indica el resultado de una operación.
        
        :param success: Si el resultado de la operación fue exitoso, el valor es verdadero.
        :param message: Si ocurrió un fallo al ejecutar la operación, contiene el mensaje de error.
        :param value: Contiene el objeto esperado en la operación.
        """
        self.success = success
        self.message = message
        self.value = value

    def __repr__(self):
        return f"ActionResult(success={self.success}, message={self.message}, value={self.value})"

