#INCLUDE "TOTVS.CH"

/*-----------------------------
Fun��o de cadastro de movimenta��es
Autor: Gabriel
Data: 19/09/2022
Projeto: Estacionamento
------------------------------*/

USER FUNCTION ESTA005()
local cTitulo       := "Movimenta��es"
LOCAL nVagCar       := SuperGetMV("ES_VAGACAR",.T.,"30")
LOCAL nVagMoto      := SuperGetMV("ES_VAGAMOT",.T.,"30")
LOCAL nContCar      := VagaCarro()
LOCAL nContMoto     := VagaMoto()

IF (nContCar < nVagCar) .or. (nContMoto < nVagMoto) 
    AxCadastro("Z05",cTitulo)   
ELSE
    Alert("N�o possuem vagas dispon�veis")
ENDIF

RETURN

/*-----------------------------
Fun��o que verifica se tem vagas de carros dispon�veis
Autor: Gabriel
Data: 04/10/2022
Projeto: Estacionamento
------------------------------*/

STATIC FUNCTION VagaCarro()
LOCAL nContCar     := 0

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordena��o
Z05->(DbGoTop()) // Posiciona no topo da tabela

WHILE Z05->(!EOF()) // Roda enquanto n�o for o fim da tabela
    IF Z05->Z05_TIPO == "1"
        nContCar++
    ENDIF    
        Z05->(DbSkip())   
ENDDO

RETURN nContCar

/*-----------------------------
Fun��o que verifica se tem vagas de motos dispon�veis
Autor: Gabriel
Data: 04/10/2022
Projeto: Estacionamento
------------------------------*/

STATIC FUNCTION VagaMoto()
LOCAL nContMoto     := 0

DbSelectArea("Z05") // Abre a tabela Z05
Z05->(DbSetOrder(1)) // Seto o indice 1 para ordena��o
Z05->(DbGoTop()) // Posiciona no topo da tabela

WHILE Z05->(!EOF()) // Roda enquanto n�o for o fim da tabela
    IF Z05->Z05_TIPO == "2"
        nContMoto++
    ENDIF    
        Z05->(DbSkip())   
ENDDO

RETURN nContMoto

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
