#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH" //biblioteca para relat�rio

 

User Function MyRel()
Local oReport := NIL

reportDef( @oReport )
oReport:PrintDialog() //tela de configura��o do relat�rio

Return NIL


Static Function ReportDef(oReport)
local oSection1 := NIL
local clReport  := ""
local clPerg    := ""                       // Pergunte
local clTitulo  := "Relat�rio de Cadastro de Clientes "
local clDescri  := "Este programa ir� emitir um relat�rio de confer�ncia de Clientes cadastrados no sistema."
local blReport  := {|oReport| reportPrint( @oReport , @oSection1) } //Bloco de c�digo que chama outra fun��o


oReport     := TReport():New( clReport, clTitulo, clPerg, blReport, clDescri ) //cria o relat�rio
oSection1   := TRSection():New( oReport, "Clientes", {"SA1"}, /*aOrd*/ ) //cria a se��o


TRCell():New( oSection1, "A1_COD"       , "SA1", "C�digo"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_NOME"      , "SA1", "Nome" ,       /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_END"       , "SA1", "Endere�o"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_BAIRRO"    , "SA1", "Bairro"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_CEP"       , "SA1", "CEP"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_MUN"       , "SA1", "Munic�pio"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_EST"       , "SA1", "UF"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


Return oReport


Static Function reportPrint(oReport, oSection1)
Local clAliasRel := "SA1"


dbSelectArea(clAliasRel)
(clAliasRel)->(dbSetOrder(1))
(clAliasRel)->(dbGoTop())

oSection1:init()   // Inicia se��o
 
while (clAliasRel)->(!eof())
    if (oReport:cancel()) //se cancelar da exit
        alert("Relat�rio foi Cancelado!")
        exit
    endif

    oSection1:Cell("A1_COD"):SetValue(( clAliasRel )->A1_COD) //Da valor para a c�lula
    oSection1:Cell("A1_NOME"):SetValue(( clAliasRel )->A1_NOME)
    oSection1:Cell("A1_END"):SetValue(( clAliasRel )->A1_END)
    oSection1:Cell("A1_BAIRRO"):SetValue(( clAliasRel )->A1_BAIRRO)
    oSection1:Cell("A1_CEP"):SetValue(( clAliasRel )->A1_CEP)
    oSection1:Cell("A1_MUN"):SetValue(( clAliasRel )->A1_MUN)
    oSection1:Cell("A1_EST"):SetValue(( clAliasRel )->A1_EST)
    oSection1:PrintLine()

   
    oReport:incMeter()

    (clAliasRel)->( dbSkip() )
endDo

(clAliasRel)->( dbCloseArea() )     // Fecho minha tabela
oSection1:finish()  // finalizo a minha se��o

Return NIL
