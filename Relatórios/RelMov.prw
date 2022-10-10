#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"

USER FUNCTION RelMov()
LOCAL oReport := NIL

reportDef(@oReport)
oReport:PrintDialog()

RETURN NIL

STATIC FUNCTION ReportDef(oReport)
LOCAL oSection1     := NIL
LOCAL oSection2     := NIL
LOCAL clReport      := ""
LOCAL clPerg        := ""
LOCAL clTitulo      := "Relatório de Cadastro de Movimentos"
LOCAL clDesc        := "Este programa irá emitir um relatório de conferência de Movimentos cadastrados no sistema."
LOCAL blReport      := {|oReport| reportPrint(@oReport ,@oSection1,@oSection2)}


oReport     := TReport():New(clReport,clTitulo,clPerg,blReport,clDesc) 
oSection1   := TRSection():New(oReport,"Movimentos",{"Z01","Z02","Z05"},/*aOrd*/)
oSection2   := TRSection():New(oReport,"Totalizadores",{"Z05"},/*aOrd*/)

TRCell():New(oSection1,"Z05_DATENT","Z05","Data de entrada", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_DATSAI","Z05","Data de saída", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_HORENT","Z05","Hora de entrada", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_HORSAI","Z05","Hora de saida", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_TEMPO","Z05","Tempo de estadia", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_VALOR","Z05","Valor", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_PLACA","Z05","Placa", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_NOMOPE","Z05","Nome do operador", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_NOMMOD","Z05","Nome do modelo", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z05_NOMMAR","Z05","Nome da marca", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"Z05_TMPMED","Z05","Tempo médio de estadia", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"Z05_SOMVAL","Z05","Total ganho", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


RETURN oReport

STATIC FUNCTION reportPrint(oReport, oSection1,oSection2)
LOCAL cHrEnt    := ""
LOCAL cHrSai    := ""
LOCAL cQtdHor   := ""
LOCAL nTotHr    := 0
LOCAL nMedia    := 0
LOCAL nContHr   := 0
LOCAL nSoma     := 0
LOCAL nValor    := 0
LOCAL cTotal    := ""


dbSelectArea("Z01")
Z01->(dbSetOrder(1))
Z01->(dbGoTop())

dbSelectArea("Z02")
Z02->(dbSetOrder(1))
Z02->(dbGoTop())

dbSelectArea("Z05")
Z05->(dbSetOrder(1))
Z05->(dbGoTop())


oSection1:init()
oSection2:init()

WHILE Z05->(!EOF())
    IF (oReport:cancel()) //se cancelar da exit
        alert("Relatório foi Cancelado!")
        EXIT
    ENDIF

    cHrEnt  := (Z05->Z05_HORENT+":00")
    cHrSai  := (Z05->Z05_HORSAI+":00")

    IF !VAZIO(Z05->Z05_HORSAI)
        cQtdHor := ELAPTIME(cHrEnt,cHrSai)
        nContHr++
        nTotHr  := nTotHr + VAL(cQtdHor)
        nValor  := (Z05->Z05_VALOR)
        nSoma   := nSoma + nValor
        cTotal  := "R$ " + CValToChar(nSoma)


        oSection1:Cell("Z05_DATENT"):SetValue(Z05->Z05_DATENT)
        oSection1:Cell("Z05_DATSAI"):SetValue(Z05->Z05_DATSAI)
        oSection1:Cell("Z05_HORENT"):SetValue(Z05->Z05_HORENT)
        oSection1:Cell("Z05_HORSAI"):SetValue(Z05->Z05_HORSAI)
        oSection1:Cell("Z05_TEMPO"):SetValue(cQtdHor)
        oSection1:Cell("Z05_VALOR"):SetValue(Z05->Z05_VALOR)
        oSection1:Cell("Z05_PLACA"):SetValue(Z05->Z05_PLACA)
        oSection1:Cell("Z05_NOMOPE"):SetValue(Z05->Z05_NOMOPE)
        oSection1:Cell("Z05_NOMMOD"):SetValue(Z05->Z05_NOMMOD)
        oSection1:Cell("Z05_NOMMAR"):SetValue(Z05->Z05_NOMMAR)


        oSection1:PrintLine()
        oReport:incMeter()
        ENDIF

Z05->(dbSkip())

ENDDO

nMedia  := cValtoChar(ROUND((nTotHr/nContHr),1)) + " HORAS"

oSection2:Cell("Z05_TMPMED"):SetValue(nMedia)
oSection2:Cell("Z05_SOMVAL"):SetValue(cTotal)
oSection2:PrintLine()    
oReport:incMeter()

Z01->(dbCloseArea())
Z02->(dbCloseArea())
Z05->(dbCloseArea())

oSection1:finish()

RETURN NIL
