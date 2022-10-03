#INCLUDE "TOTVS.CH"

/*-----------------------------
Função de cadastro de movimentações
Autor: Gabriel
Data: 19/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA005()
local cTitulo := "Movimentações"

IF FVerVagas()
    AxCadastro("Z05",cTitulo,/*u_cVldExc(),cVldAlt*/)
ELSE
    Alert("Não há mais vagas")
ENDIF

RETURN

/*-----------------------------
Função que verifica se tem vagas disponíveis
Autor: Gabriel
Data: 27/09/2022
Projeto: Estacionamento
------------------------------*/

STATIC FUNCTION FVerVagas()
LOCAL lRet      := .F.
LOCAL nVagCar   := SuperGetMV("ES_VAGACAR",.T.,"30")
LOCAL nVagMot   := SuperGetMV("ES_VAGAMOT",.T.,"15")
LOCAL nContCar     := 0
LOCAL nContMot     := 0

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordenação
Z05->(DbGoTop()) // Posiciona no topo da tabela

WHILE Z05->(!EOF()) // Roda enquanto não for o fim da tabela
    IF Z05->Z05_TIPO == "1"
        nContCar++
    ELSE
        nContMot++
    ENDIF    
    Z05->(DbSkip())   
ENDDO

IF (nVagCar > nContCar) .or. (nVagMot > nContMot) //Verifica se existe vagas
    lRet := .T.
ENDIF

RETURN lRet
