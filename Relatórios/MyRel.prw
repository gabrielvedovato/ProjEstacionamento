#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH" //biblioteca para relatório

 

User Function MyRel()
Local oReport := NIL

reportDef( @oReport )
oReport:PrintDialog() //tela de configuração do relatório

Return NIL


Static Function ReportDef(oReport)
local oSection1 := NIL
local clReport  := ""
local clPerg    := ""                       // Pergunte
local clTitulo  := "Relatório de Cadastro de Clientes "
local clDescri  := "Este programa irá emitir um relatório de conferência de Clientes cadastrados no sistema."
local blReport  := {|oReport| reportPrint( @oReport , @oSection1) } //Bloco de código que chama outra função


oReport     := TReport():New( clReport, clTitulo, clPerg, blReport, clDescri ) //cria o relatório
oSection1   := TRSection():New( oReport, "Clientes", {"SA1"}, /*aOrd*/ ) //cria a seção


TRCell():New( oSection1, "A1_COD"       , "SA1", "Código"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_NOME"      , "SA1", "Nome" ,       /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_END"       , "SA1", "Endereço"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_BAIRRO"    , "SA1", "Bairro"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_CEP"       , "SA1", "CEP"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_MUN"       , "SA1", "Município"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_EST"       , "SA1", "UF"   , /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


Return oReport


Static Function reportPrint(oReport, oSection1)
Local clAliasRel := "SA1"


dbSelectArea(clAliasRel)
(clAliasRel)->(dbSetOrder(1))
(clAliasRel)->(dbGoTop())

oSection1:init()   // Inicia seção
 
while (clAliasRel)->(!eof())
    if (oReport:cancel()) //se cancelar da exit
        alert("Relatório foi Cancelado!")
        exit
    endif

    oSection1:Cell("A1_COD"):SetValue(( clAliasRel )->A1_COD) //Da valor para a célula
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
oSection1:finish()  // finalizo a minha seção

Return NIL
