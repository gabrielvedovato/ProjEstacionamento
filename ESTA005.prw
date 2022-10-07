#INCLUDE "TOTVS.CH"

/*-----------------------------
Função de cadastro de movimentações
Autor: Gabriel
Data: 19/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA005()
local cTitulo := "Movimentações"
AxCadastro("Z05",cTitulo)   
RETURN NIL

/*-----------------------------
Função que verifica se tem vagas disponíveis
Autor: Gabriel
Data: 04/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION VagaVerifica()
LOCAL lRet          := .T.
LOCAL nVagCar       := SuperGetMV("ES_VAGACAR",.T.,"30")
LOCAL nVagMoto      := SuperGetMV("ES_VAGAMOT",.T.,"10")
LOCAL nContCar      := 0
LOCAL nContMoto     := 0
LOCAL cCampo        := ReadVar()
LOCAL cInfo         := &(cCampo)

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordenação
Z05->(DbGoTop()) // Posiciona no topo da tabela

IF Z05->(dbSeek(cFilAnt))
    WHILE Z05->(!EOF()) .and. (Z05_FILIAL == cFilAnt)
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
        ELSE
            lRet := .F.
        ENDIF
    ENDIF
ENDIF
RETURN lRet

/*-----------------------------
Função que verifica o carro ainda está no estacionamento
Autor: Gabriel
Data: 03/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION PlacaVerifica()
LOCAL lRet := .T.

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(6)) // Seto o indice para ordenação

IF Z05->(dbSeek(FWxFilial("Z05")+M->Z05_PLACA+dTOs(Z05_DATSAI)))
    lRet := .F.
    Alert("Veículo ainda não teve saída!")
ENDIF

RETURN lRet

/*-----------------------------
Função que verifica se a placa está com todos os campos preenchidos
Autor: Gabriel
Data: 05/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION PlacaCampo()
LOCAL lRet          := .T.
LOCAL cCampo        := ReadVar()
LOCAL cTrim         := &(cCampo)
LOCAL cInfo         := AllTrim(cTrim)
LOCAL aTamanho      := TAMSX3("Z05_PLACA")
LOCAL nTamanho      := aTamanho[1]

IF Len(cInfo) # nTamanho
    lRet := .F.
    Alert("Placa não atende requistitos!")
ENDIF

RETURN lRet

/*-----------------------------
Função que verifica se a data não é anterior a da entrada
Autor: Gabriel
Data: 05/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION DataVerifica()

LOCAL lRet   := .T.
LOCAL dDtEnt := Z05->Z05_DATENT
LOCAL dDtSai := M->Z05_DATSAI

    IF (dDtSai-dDtEnt) < 0
        lRet := .F.
        Alert("Insira a data de saída correta!")
    ENDIF

RETURN lRet
