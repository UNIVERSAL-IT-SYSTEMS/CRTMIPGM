  /*  ===============================================================  */
  /*  = Command....... CrtMIPgm                                     =  */
  /*  = Description... Create Machine Interface Program             =  */
  /*  = CPP........... CrtMIPgmC                                    =  */
  /*  = Source type... Cmd                                          =  */
  /*  = Compile....... CrtCmd     Cmd(YourLib/CrtMIPgm)             =  */
  /*  =                           Pgm(YourLib/CrtMIPgmC)            =  */
  /*  =                           PrdLib(YourLib)                   =  */
  /*  ===============================================================  */

             Cmd        Prompt( 'Create MI Program' )

             Parm       Kwd( Pgm ) Type( QPgm ) Min( 1 ) Prompt( 'Program' )

             Parm       Kwd( SrcFile ) Type( QSrcFile ) Prompt( 'Source file' )

             Parm       Kwd( SrcMbr ) Type( *Name ) Len( 10 ) Dft( *Pgm ) SpcVal( ( *Pgm ) ) +
                          Expr( *Yes ) Prompt( 'Source member' )

             Parm       Kwd( Text ) Type( *Char ) Len( 50 ) Dft( *SrcMbrTxt ) SpcVal( ( +
                          *SrcMbrTxt ) ) Expr( *Yes ) Prompt( 'Text ''description''' )

             Parm       Kwd( UsrPrf ) Type( *Name ) Len( 10 ) Rstd( *Yes ) Dft( *User ) +
                          SpcVal( ( *User ) ( *Adopt ) ( *Owner ) ) Expr( *Yes ) PmtCtl( +
                          *PmtRqs ) Prompt( 'User profile' )

             Parm       Kwd( Replace ) Type( *Char ) Len( 10 ) Rstd( *Yes ) Dft( *Yes ) +
                          SpcVal( ( *Yes *Replace ) ( *No *NoReplace ) ) Expr( *Yes ) PmtCtl( +
                          *PmtRqs ) Prompt( 'Replace program' )

             Parm       Kwd( Aut ) Type( *Name ) Len( 10 ) Dft( *LibCrtAut ) SpcVal( ( +
                          *LibCrtAut ) ( *Change ) ( *All ) ( *Use ) ( *Exclude ) ) Expr( *Yes +
                          ) PmtCtl( *PmtRqs ) Prompt( 'Authority' )

             Parm       Kwd( GenOpt ) Type( *Char ) Len( 11 ) Dft(  ) Rstd( *Yes ) SpcVal( ( +
                          *Gen ) ( *NoGen ) ( *NoList ) ( *List ) ( *NoXRef ) ( *XRef ) ( +
                          *NoAtr ) ( *Atr ) ( *AdpAut ) ( *NoAdpAut ) ( *SubScr ) ( *NoSubScr +
                          ) ( *UnCon ) ( *SubStr ) ( *NoSubStr ) ( *ClrPSSA ) ( *NoClrPSSA ) ( +
                          *ClrPASA ) ( *NoClrPASA ) ( *NoIgnDec ) ( *IgnDec ) ( *NoIgnBin ) ( +
                          *IgnBin ) ( *NoOverlap ) ( *Overlap ) ( *NoDup ) ( *Dup ) ( *Opt ) ( +
                          *NoOpt ) ) Max( 14 ) Expr( *Yes ) PmtCtl( *PmtRqs ) Prompt( +
                          'Generation options' )

 QPgm:       Qual       Type( *Name ) Len( 10 ) Min( 1 ) Expr( *Yes )

             Qual       Type( *Name ) Len( 10 ) Dft( *CurLib ) SpcVal( ( *CurLib ) ) Expr( +
                          *Yes ) Prompt( 'Library' )

 QSrcFile:   Qual       Type( *Name ) Len( 10 ) Dft( QMISrc ) Expr( *Yes )

             Qual       Type( *Name ) Len( 10 ) Dft( *LibL ) SpcVal( ( *LibL ) ( *CurLib ) ) +
                          Expr( *Yes ) Prompt( 'Library' )
