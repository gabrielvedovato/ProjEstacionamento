#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"

USER FUNCTION RelMod()
LOCAL oReport := NIL

reportDef(@oReport)
oReport:PrintDialog()

RETURN NIL

STATIC FUNCTION ReportDef(oReport)
LOCAL oSection1     := NIL
LOCAL clReport      := ""
LOCAL clPerg        := ""
LOCAL clTitulo      := "Relatório de Cadastro de Modelos"
LOCAL clDesc        := "Este programa irá emitir um relatório de conferência de Modelos cadastrados no sistema."
LOCAL blReport      := {|oReport| reportPrint(@oReport ,@oSection1)}


oReport     := TReport():New(clReport,clTitulo,clPerg,blReport,clDesc) 
oSection1   := TRSection():New(oReport,"Modelos",{"Z02"},/*aOrd*/)

TRCell():New(oSection1,"Z02_COD",   "Z02","Código", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z02_NOME",  "Z02","Nome do modelo", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z02_CODMAR","Z02","Código da marca", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"Z02_NOMMAR","Z02","Nome da marca", /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


RETURN oReport

STATIC FUNCTION reportPrint(oReport, oSection1)

dbSelectArea("Z02")
Z02->(dbSetOrder(1))
Z02->(dbGoTop())

oSection1:init()

WHILE Z02->(!EOF())
    IF (oReport:cancel()) //se cancelar da exit
        alert("Relatório foi Cancelado!")
        EXIT
    ENDIF

oSection1:Cell("Z02_COD"):SetValue(Z02->Z02_COD)
oSection1:Cell("Z02_NOME"):SetValue(Z02->Z02_NOME)
oSection1:Cell("Z02_CODMAR"):SetValue(Z02->Z02_CODMAR)
oSection1:Cell("Z02_NOMMAR"):SetValue(Z02->Z02_NOMMAR)
oSection1:PrintLine()


oReport:incMeter()
Z02->(dbSkip())
ENDDO

Z02->(dbCloseArea())
oSection1:finish()

RETURN NIL
