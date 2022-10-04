#INCLUDE "TOTVS.CH"

/*-----------------------------
Fun��o de cadastro de movimenta��es
Autor: Gabriel
Data: 19/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA005()
local cTitulo := "Movimenta��es"

IF FVerVagas()
    AxCadastro("Z05",cTitulo,/*u_cVldExc(),cVldAlt*/)
ELSE
    Alert("N�o h� mais vagas")
ENDIF

RETURN

/*-----------------------------
Fun��o que verifica se tem vagas dispon�veis
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
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordena��o
Z05->(DbGoTop()) // Posiciona no topo da tabela

WHILE Z05->(!EOF()) // Roda enquanto n�o for o fim da tabela
    IF Z05->Z05_TIPO == "1"
        nContCar++
    ELSE
        nContMot++
    ENDIF    
        Z05->(DbSkip())   
ENDDO

IF nVagCar > nContCar .or. nVagMot > nContMot //Verifica se existe vagas
    lRet := .T.
ENDIF

RETURN lRet

/*-----------------------------
Fun��o que verifica o carro ainda est� no estacionamento
Autor: Gabriel
Data: 03/10/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION FVerifica()
LOCAL lRet := .T.

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(6)) // Seto o indice para ordena��o

IF Z05->(dbSeek(FWxFilial("Z05")+M->Z05_PLACA+dTOs(Z05_DATSAI)))
    lRet := .F.
    Alert("Ve�culo ainda n�o teve sa�da!")
ENDIF


RETURN lRet
