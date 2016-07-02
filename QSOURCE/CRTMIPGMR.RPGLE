                                 //  ===============================================================
         //  = Program....... CrtMIPgmR                                      =
         //  = Description... Create Machine Interface Program               =
         //  = Source type... RPGLE                                          =
         //  = Compile....... CrtBndRPG  Pgm(YourLib/CrtMIPgmR)              =
         //  =                           DftActGrp(*No)                      =
         //  =                           ActGrp(*Caller)                     =
         //  =================================================================

     FMISrc     IF   F   92        Disk    UsrOpn
     F                                     ExtFile( SrcF )
     F                                     ExtMbr( SrcMbr )

         //  =================================================================
         //  = Entry parameters                                              =
         //  =================================================================

     D EntryParms      Pr                  ExtPgm( 'CRTMIPGMR' )
     D  ParameterIn                  20
     D  ParameterIn                  20
     D  ParameterIn                  10
     D  ParameterIn                  50
     D  ParameterIn                  10
     D  ParameterIn                  10
     D  ParameterIn                  10
     D  ParameterIn                        LikeDS( GenOptInModel )
     D  ParameterIn                  13
     D  ParameterIn                  10P 0
     D  ParameterOut                  7
     D  ParameterOut                256

     D EntryParms      PI
     D  Pgm                          20
     D  SrcFile                      20
     D  SrcMbr                       10
     D  Text                         50
     D  UsrPrf                       10
     D  Replace                      10
     D  Aut                          10
     D  GenOptIn                           LikeDS( GenOptInModel )
     D  SrcChgDate                   13
     D  NbrCurRcd                    10P 0
     D  MsgID                         7
     D  MsgDta                      256

         //  =================================================================
         //  = Procedure prototypes                                          =
         //  =================================================================

     D CreateProgram   Pr                  ExtPgm( 'QPRCRTPG' )
     D  ParameterIn                  80    Dim( 32767 )
     D  ParameterIn                  10I 0
     D  ParameterIn                  20
     D  ParameterIn                  50
     D  ParameterIn                  20
     D  ParameterIn                  10
     D  ParameterIn                  13
     D  ParameterIn                  20
     D  ParameterIn                  10I 0
     D  ParameterIn                  10
     D  ParameterIn                 176
     D  ParameterIn                  10I 0
     D  ParameterIO                        LikeDS( StdErrorModel )


         //  =================================================================
         //  = Data definitions                                              =
         //  =================================================================

     D StdErrorModel   DS                  Qualified
     D                               10I 0 Inz( %Size( StdErrorModel ))
     D  BytesAvail                   10I 0 Inz( *Zero )
     D  MsgID                         7    Inz( *Blank )
     D                                1    Inz( X'00' )
     D  MsgDta                      256    Inz( *Blank )

     D GenOptInModel   DS                  Based( GenOptInModelPtr )
     D                                     Qualified
     D  NbrOpts                       5I 0
     D  Opt                         154

     D StdError        DS                  LikeDS( StdErrorModel )
     D                                     Inz( *LikeDS )

     D GenOpt          S            176
     D NbrGenOpts      S             10I 0

     D Src             S             80    Dim( 32767 )

     D SrcF            S             21
     D SrcLen          S             10I 0
     D PrtF            S             20    Inz( 'QSYSPRT   *LIBL' )
     D StrPage         S             10I 0 Inz( 1 )
     D Pos             S              3I 0
     D Index           S              5I 0

     IMISrc     NS
     I                                 13   92  SrcInfo

        /Free

         //  =================================================================
         //  = Open source file                                              =
         //  =================================================================

             SrcF = %Trim( %Subst( SrcFile : 11 : 10 ) ) +
                    '/'                                  +
                    %Trim( %Subst( SrcFile : 1 : 10 ) ) ;
             Open MISrc ;

         //  =================================================================
         //  = Set parameters for API to create program                      =
         //  =================================================================

             SrcLen = NbrCurRcd * 80 ;

             Pos = ( GenOptIn.NbrOpts * 11 ) ;
             If GenOptIn.NbrOpts > *Zero ;
               GenOpt = %Subst( GenOptIn.Opt : 1 : Pos ) ;
             EndIf ;
             Pos = Pos + 1 ;
             %Subst( GenOpt : Pos : 11 ) = Replace ;
             Pos = Pos + 11 ;
             %Subst( GenOpt : Pos : 11 ) = UsrPrf ;

             NbrGenOpts = GenOptIn.NbrOpts + 2 ;


         //  =================================================================
         //  = Load source to instruction stream parameter                   =
         //  =================================================================

             Read MISrc ;
               DoW Not( %EOF( MISrc ) ) ;
                 Index = Index + 1 ;
                 Src( Index ) = SrcInfo ;
                 Read MISrc ;
               EndDo ;

         //  =================================================================
         //  = Close source file                                             =
         //  =================================================================

             Close MISrc ;

         //  =================================================================
         //  = Call API to create the MI program                             =
         //  =================================================================

             CreateProgram
             (
               Src        :
               SrcLen     :
               Pgm        :
               Text       :
               SrcFile    :
               SrcMbr     :
               SrcChgDate :
               PrtF       :
               StrPage    :
               Aut        :
               GenOpt     :
               NbrGenOpts :
               StdError
             ) ;

             If StdError.BytesAvail <> *Zero ;
               MsgID = StdError.MsgID ;
               MsgDta = StdError.MsgDta ;
             EndIf ;

             *InLR = *On ;

        /End-Free
