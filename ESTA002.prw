#INCLUDE "TOTVS.CH"

/*-----------------------------
Fun��o de cadastro de modelos
Autor: Gabriel
Data:14/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA002()
local cTitulo := "Cadastro de modelos"
AxCadastro("Z02",cTitulo)
RETURN

/*-----------------------------
Fun��o de valida��o de modelos
Autor: Gabriel
Data: 14/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION FVCodeMod()
LOCAL lRet := .T.
LOCAL cCampo := ReadVar()
LOCAL cInfo := &(cCampo)
lRet := FCondLaco(cInfo)
RETURN lRet

//
STATIC FUNCTION FCondLaco(cInfo)
LOCAL lRet := .T.
LOCAL nTamanho := Len(cInfo)
LOCAL nCount := 1
WHILE nTamanho > nCount
    IF Upper(SubStr(cInfo,nCount,1)) == "X"
        Alert("N�o aceitamos X")
        lRet := .F.
        EXIT
    ENDIF
    nCount ++
END DO
RETURN lRet

/*-----------------------------
Fun��o para bloquear a escrita do nome da empresa
Autor: Gabriel
Data: 14/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION FVNomeMod()
LOCAL lRetorno := .T.
LOCAL cCampo := ReadVar()
LOCAL cInfo := &(cCampo)
LOCAL cEspaco := AllTrim(cInfo)
IF ("DS2U" $ cEspaco)
    Alert("N�o pode colocar o nome da empresa")
    lRetorno := .F.
ENDIF
RETURN lRetorno
