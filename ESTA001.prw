#INCLUDE "TOTVS.CH"

/*-----------------------------
Fun��o de cadastro de marcas
Autor: Gabriel
Data: 14/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA001()
local cTitulo := "Cadastro de marcas"
AxCadastro("Z01",cTitulo)
RETURN

/*-----------------------------
Fun��o para bloquear a escrita do nome da empresa
Autor: Gabriel
Data: 14/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION FVNomeMar()
LOCAL lRetorno  := .T.
LOCAL cCampo    := ReadVar()
LOCAL cInfo     := &(cCampo)
LOCAL cEspaco   := AllTrim(cInfo)
IF ("DS2U" $ cEspaco)
    Alert("N�o pode conter o nome da empresa")
    lRetorno := .F.
ENDIF
RETURN lRetorno
