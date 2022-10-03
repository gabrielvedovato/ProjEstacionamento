#INCLUDE "TOTVS.CH"

/*-----------------------------
Função de cadastro de marcas
Autor: Gabriel
Data: 14/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA001()
local cTitulo := "Cadastro de marcas"
AxCadastro("Z01",cTitulo)
RETURN

/*-----------------------------
Função para bloquear a escrita do nome da empresa
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
    Alert("Não pode conter o nome da empresa")
    lRetorno := .F.
ENDIF
RETURN lRetorno
