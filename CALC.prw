#INCLUDE "TOTVS.CH"

/*---------------------------------------
Função que calcula Valor a ser cobrado pelo cliente
Autor: Gabriel
Data: 21/09/2022
Projeto: Estacionamento
--------------------------------------- */

<<<<<<< HEAD
=======
//CLONE

>>>>>>> main
User Function ESTCALC(dDtEnt,cHrEnt,dDtSai,cHrSai)
LOCAL cQtdHor   := ""
LOCAL aHoras    := {}
LOCAL nHoras    := 0
LOCAL nMinutos  := 0
LOCAL nValor    := 0
LOCAL nCount    := 1
LOCAL nDias     := 0
LOCAL nV1aHr    := SUPERGETMV("ES_VL1AHOR",.T.,"20")
LOCAL nVDemHr   := SUPERGETMV("ES_VLDHOR",.T.,"5")
LOCAL nVDiar    := SUPERGETMV("ES_VLDIA",.T.,"30")
LOCAL cTempCort := SUPERGETMV("ES_TEMPCOR",.T.,"15")

// ----------------------------
// Mesmo dia
IF dDtEnt == dDtSai

       // Tratamento variaveis de hora
    IF  Len(cHrEnt) .and. Len(cHrSai) == 5
        cHrEnt := (cHrEnt+":00")
        cHrSai := (cHrSai+":00")
    ENDIF

// Uso funcao elaptime que me da o retorno de soma de dois horarios
    cQtdHor := ELAPTIME(cHrEnt,cHrSai)
   
// Uso a funcao separa para me retornar um Array com as horas, minutos e segundos / poderia usar tbm, substr()
    aHoras := Separa(cQtdHor,":")

// Jogo para uma variavel as informacoes ja transformando em numero, através da funcao VAL()
    nHoras     := Val(aHoras[1])
    nMinutos   := Val(aHoras[2])

//Calculo

//Tratamento para diária
    IF nHoras >= 12
        nValor := nVDiar
    ELSE
// Verifico se é primeira hora - pelo meu contador
        WHILE ((nHoras > 0) .AND. (nCount <=  nHoras))
            IF nCount == 1
                nValor := nValor + nV1aHr
            ELSE
                nValor := nValor + nVDemHr
            ENDIF
                nCount++
        END DO
            IF nMinutos > 0
// Basta que eu tenha 1 minuto que eu cobro uma hora a mais
                nValor += nVDemHr
            ENDIF
//Calcular menos de uma hora
            IF nHoras == 0
                nValor := nV1aHr
//Tempo de cortesia
                IF nMinutos <= cTempCort
                    nValor := 0
                ENDIF 
            ENDIF
    ENDIF    
ELSE
    nDias  := (dDtSai - dDtEnt)
    nValor := (nVDiar * nDias)    
ENDIF

RETURN nValor
