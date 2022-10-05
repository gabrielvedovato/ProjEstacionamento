#INCLUDE "TOTVS.CH"

/*-----------------------------
Fun��o de cadastro de movimenta��es
Autor: Gabriel
Data: 19/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA005()
local cTitulo := "Movimenta��es"
AxCadastro("Z05",cTitulo)   
RETURN NIL

/*-----------------------------
Fun��o que verifica se tem vagas dispon�veis
Autor: Gabriel
Data: 04/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION VagaVerifica()
LOCAL lRet          := .T.
LOCAL nVagCar       := SuperGetMV("ES_VAGACAR",.T.,"30")
LOCAL nVagMoto      := SuperGetMV("ES_VAGAMOT",.T.,"30")
LOCAL nContCar      := 0
LOCAL nContMoto     := 0
LOCAL cCampo        := ReadVar()
LOCAL cInfo         := &(cCampo)

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordena��o
Z05->(DbGoTop()) // Posiciona no topo da tabela

WHILE Z05->(!EOF()) // Roda enquanto n�o for o fim da tabela
    IF VAZIO(Z05_DATSAI)
        IF (Z05->Z05_TIPO == "1")
            nContCar++
        ELSE
            nContMoto++
        ENDIF    
    ENDIF
Z05->(DbSkip())  
ENDDO

IF cInfo == "1" .and. (nContCar < nVagCar)
    lRet := .T.
ELSE
    lRet := .F.

    IF cInfo == "2" .and. (nContMoto < nVagMoto)
        lRet := .T.
    ENDIF

ENDIF

RETURN lRet

/*-----------------------------
Fun��o que verifica o carro ainda est� no estacionamento
Autor: Gabriel
Data: 03/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION PlacaVerifica()
LOCAL lRet := .T.

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(6)) // Seto o indice para ordena��o

IF Z05->(dbSeek(FWxFilial("Z05")+M->Z05_PLACA+dTOs(Z05_DATSAI)))
    lRet := .F.
    Alert("Ve�culo ainda n�o teve sa�da!")
ENDIF


RETURN lRet
