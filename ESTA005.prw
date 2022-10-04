#INCLUDE "TOTVS.CH"

/*-----------------------------
Função de cadastro de movimentações
Autor: Gabriel
Data: 19/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA005()
local cTitulo   := "Movimentações"

IF (FVagaCarro() == .T.) .and. (FVagaMoto() == .T.)
    AxCadastro("Z05",cTitulo,/*u_cVldExc(),cVldAlt*/)
ELSE
    Alert("Não há mais vagas")
ENDIF

RETURN

/*-----------------------------
Função que verifica se tem vagas de carros disponíveis
Autor: Gabriel
Data: 27/09/2022
Projeto: Estacionamento
------------------------------*/

STATIC FUNCTION FVagaCarro()
LOCAL nVagCar       := SuperGetMV("ES_VAGACAR",.T.,"30")
LOCAL nContCar      := 0
LOCAL lRetCar       := .T.


DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordenação
Z05->(DbGoTop()) // Posiciona no topo da tabela

WHILE Z05->(!EOF()) // Roda enquanto não for o fim da tabela
    IF Z05->Z05_TIPO == "1"
        nContCar++
    ENDIF    
    Z05->(DbSkip())   
ENDDO

IF nVagCar > nContCar //Verifica se existe vagas
    lRet := .T.
ENDIF

RETURN lRetCar

/*-----------------------------
Função que verifica se tem vagas de motos disponíveis
Autor: Gabriel  
Data: 04/10/2022
Projeto: Estacionamento
------------------------------*/

STATIC FUNCTION FVagaMoto()
LOCAL nVagMot       := SuperGetMV("ES_VAGAMOT",.T.,"15")
LOCAL nContMoto      := 0
local lRetMoto      := .T.

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordenação
Z05->(DbGoTop()) // Posiciona no topo da tabela

WHILE Z05->(!EOF()) // Roda enquanto não for o fim da tabela
    IF Z05->Z05_TIPO == "2"
        nContMoto++
    ENDIF    
    Z05->(DbSkip())   
ENDDO

IF nVagMot > nContMoto //Verifica se existe vagas
    lRet := .T.
ENDIF

RETURN lRetMoto

/*-----------------------------
Função que verifica o carro ainda está no estacionamento
Autor: Gabriel
Data: 03/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION FVerifica()
LOCAL lRet := .T.

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(6)) // Seto o indice para ordenação

IF Z05->(dbSeek(FWxFilial("Z05")+M->Z05_PLACA+dTOs(Z05_DATSAI)))
    lRet := .F.
    Alert("Veículo ainda não teve saída!")
ENDIF


RETURN lRet
