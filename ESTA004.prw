#INCLUDE "TOTVS.CH"

/*-----------------------------
Fun√ß√£o de cadastro de operadores
Autor: Gabriel
Data: 14/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA004()
local cTitulo := "Cadastro de operadores"
AxCadastro("Z04",cTitulo)
RETURN


/*------------------------
FUN«√O PARA BLOQUEAR O NOME DS2U
Autor: Gabriel
Data: 28/09/2022
Projeto: Estacionamento
--------------------------*/

USER FUNCTION FVNomeOpe()
LOCAL lRetorno := .T.
LOCAL cCampo := ReadVar()
LOCAL cInfo := &(cCampo)
LOCAL cEspaco := AllTrim(cInfo)
IF ("DS2U" $ cEspaco)
    Alert("N„o pode conter o nome da empresa")
    lRetorno := .F.
ENDIF
RETURN lRetorno
