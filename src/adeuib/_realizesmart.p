&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Procedure 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
/*------------------------------------------------------------------------
    File        : adeuib/_undsmar.p 
    Purpose     : realize (undelete) a SmartObject.  
    Syntax      : Run adeuib/_undsmar.p persistent set h.
                  
                  Run realizeSMO in h (recid(_u), yes).
                  
                  
    Description : This is a recreation of _undsmar.p. 
                       
                  The main-block logic is moved into realize-smo.
                  
                  The purpose to make it persistent was to achieve the 
                  necessary flexibility to skip initializeObject in some 
                  cases. 
                  
                  The performance in qssuckr -> cdsuckr -> _rdsmart is also
                  improved (when an object with several SmartObjects
                  is opened)
                   
    Author(s)   : H. Danielsen 
    Created     : 9/9/99 
    Notes       : The procedure is NOT "normalized" because it has been
                  converted from a non-persistent procedure. All IPs have 
                  dependencies of temp-tables being found in realizeSMO 
                  and variables being updated in validateSmartObject. 
                  
                  Most of the IPs are subsequently PRIVATE. 
                   
   public  API:   procedure realizeSMO(recid(_U),initialize) 
                            Main logic, realizes a SmartObject in the Appbuilder
                            Second param specifies whether initializeObject 
                            shall be called in the SMO. 
                              
                  procedure initializeSMO(recid(_U))            
                            run initializeObject in the SMO. 
                             
                  function setCurrent(recid(_U)) 
                           find _U and all other temp-tables.                   
----------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

{adeuib/uniwidg.i}   /* Universal Widget Records */
{adeuib/layout.i}    /* Layout information */
{adeuib/sharvars.i}  /* Standard Shared Variables */
{adeuib/custwidg.i}  /* Define Palette-Items (and their images) */
{adecomm/adefext.i} 

DEFINE BUFFER parent_U FOR _U.

 /* Variables used for adm version */
{adeuib/vsookver.i}

DEFINE VARIABLE glRemote     AS LOGICAL NO-UNDO.
DEFINE VARIABLE glEditAttr   AS LOGICAL NO-UNDO.
DEFINE VARIABLE glMovable    AS LOGICAL NO-UNDO INITIAL yes.
DEFINE VARIABLE glResizable  AS LOGICAL NO-UNDO INITIAL yes. 

&SCOPED-DEFINE hideobject  _L._REMOVE-FROM-LAYOUT~
                            OR ((_P._page-current ne ?) AND ~
                                (_S._page-number ne _P._page-current) AND~
                                (_S._page-number ne 0))

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Procedure
&Scoped-define DB-AWARE no



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&IF DEFINED(EXCLUDE-setCurrent) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setCurrent Procedure 
FUNCTION setCurrent RETURNS LOGICAL
  (pU_REcid AS RECID)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Procedure
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: CODE-ONLY COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Procedure ASSIGN
         HEIGHT             = 15
         WIDTH              = 60.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Procedure 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&IF DEFINED(EXCLUDE-createAffordance) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE createAffordance Procedure 
PROCEDURE createAffordance PRIVATE :
/* --------------------------------------------------------------
     We create a button with a popup-menu in the UPPER-LEFT
     corner of smartObjects that appear in the UIB.  This is our
     affordance handle.
   -------------------------------------------------------------*/   
  DEFINE VARIABLE h AS HANDLE NO-UNDO. 
  /* Create a frame and an image in the frame */
  CREATE BUTTON _S._affordance-handle 
   ASSIGN
    FRAME      = _U._HANDLE
    HIDDEN     = yes
    X          = IF glResizable THEN 4 ELSE 0
    Y          = IF glResizable THEN 4 ELSE 0
    SENSITIVE  = yes
    BGCOLOR    = ?
    TOOLTIP    = "SmartObject Options"
    . 
   
  /* Create an "dropdown" image on the button, and display the button. */
  h = _S._affordance-handle. 
  h:LOAD-IMAGE ("adeicon/dropdown", 0, 0, 10, 9) .

  /* View the button, if we are pretty sure it will fit in its parent. */
  IF h:X + h:WIDTH-P < _U._HANDLE:WIDTH-P AND 
     h:Y + h:HEIGHT-P < _U._HANDLE:HEIGHT-P
  THEN ASSIGN _S._affordance-handle:HIDDEN = no NO-ERROR.
    
  /* Add the popup menu to the icon -- on the left button */
  RUN createPopupMenu (INPUT _S._affordance-handle).
  _S._affordance-handle:MENU-MOUSE = 1. 
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-createDesignTriggers) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE createDesignTriggers Procedure 
PROCEDURE createDesignTriggers PRIVATE :
/* --------------------------------------------------------------
     We have standard behavior for a SmartObject in the UIB.
     The object's contents are disabled, and it has triggers on 
     it to popup its property sheet.
   -------------------------------------------------------------*/
 
  /* Add other triggers */
  ON SELECTION    OF _U._HANDLE PERSISTENT RUN setselect      IN _h_uib.
  ON DESELECTION  OF _U._HANDLE PERSISTENT RUN setdeselection IN _h_uib.
  ON END-MOVE     OF _U._HANDLE PERSISTENT RUN endmove        IN _h_uib.
  ON END-RESIZE   OF _U._HANDLE PERSISTENT RUN endresize      IN _h_uib.    
  ON MOUSE-SELECT-DBLCLICK OF _U._HANDLE 
                                PERSISTENT RUN property_sheet IN _h_uib (_U._HANDLE).
  
  /* Allow drawing in the object */
  ON MOUSE-SELECT-DOWN, MOUSE-EXTEND-DOWN   OF _U._HANDLE
                          PERSISTENT RUN setxy                IN _h_uib.
  ON MOUSE-SELECT-CLICK, MOUSE-EXTEND-CLICK OF _U._HANDLE
                          PERSISTENT RUN drawobj              IN _h_uib.
  ON CURSOR-LEFT, CURSOR-RIGHT, CURSOR-UP, CURSOR-DOWN OF _U._HANDLE
                          PERSISTENT RUN tapit                IN _h_uib.
 
  /* NOTE: Whenever we set design triggers on a _U record, we note that
     the PRIVATE-DATA of the object is "UIB/_U".  This is so adeuib/_sanitiz.p
     can recognize objects we need to be aware of later.  (Any widget with
     "UIB/_U" in PRIVATE-DATA must have a valid _U record, or something is 
     wrong. */
  _U._HANDLE:PRIVATE-DATA = "{&UIB-Private}" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-createPopUpMenu) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE createPopUpMenu Procedure 
PROCEDURE createPopUpMenu PRIVATE :
/* --------------------------------------------------------------
   Create a menu of the form:           
        *Instance Properties for Version9 SmartObjects

      +------------------------+
      | Properties...          |
      | Instance Attributes... |
      | SmartInfo...           |
      | SmartLinks...          |
      |------------------------|
      | Edit Master            |
      |------------------------|  
      | Delete Instance        |
      +------------------------+
   Attach the menu to the parent. 
   7
   NOTE: For an alternate layout....
     1) disable the Instance Attributes dialog
     2) change the name of the Delete button to "Remove from Layout".
     
   -------------------------------------------------------------*/
  DEFINE INPUT PARAMETER phParent AS WIDGET NO-UNDO.

  DEF VAR cSOInfoFile AS CHAR NO-UNDO.
  DEF VAR hMenu       AS WIDGET  NO-UNDO.
  DEF VAR h           AS WIDGET  NO-UNDO.
  DEF VAR cLOMaster   AS LOGICAL NO-UNDO.
  
  ASSIGN /* Is this a Master Layout. */
         cLOMaster   = (_U._LAYOUT-NAME eq "Master Layout":U)
         cSOInfoFile = IF admVersion LT "ADM2":U 
                       THEN  "adm/support/_so-info.w":U
                       ELSE  "adm2/support/_so-info.w":U.

  /* Create a popup menu for the window */
  CREATE MENU hMenu ASSIGN
    POPUP-ONLY = YES
    TRIGGERS: 
      ON MENU-DROP PERSISTENT 
        RUN changewidg IN _h_uib (_U._HANDLE, 
                                  yes /* Deselect other objects */ 
                                  ).
    END TRIGGERS  
    .
    
  /* The first menu item is different in the treeview */
  IF VALID-HANDLE(_p._tv-proc) THEN
    CREATE MENU-ITEM h ASSIGN
      parent = hMenu
      label  = "&Choose SmartDataObject..."
      TRIGGERS: 
        ON CHOOSE PERSISTENT 
          RUN chooseDataObject IN _P._tv-proc.
       END TRIGGERS
      . 
  ELSE 
    CREATE MENU-ITEM h ASSIGN
      parent = hMenu
      label  = "&Properties..."
      TRIGGERS: 
        ON CHOOSE PERSISTENT 
          RUN property_sheet IN _h_uib (_U._HANDLE).
       END TRIGGERS
      . 
  
  CREATE menu-item h assign
    parent = hMenu
    label  = IF admVersion LT "ADM2":U THEN
                "Instance &Attributes..."
             ELSE
                "I&nstance Properties..."
    sensitive = glEditAttr AND cLOMaster
    .
  /* We cannot always attach this trigger because _S._HANDLE might be invalid. 
     (and trying to attach would dump core) */
  IF glEditAttr AND _S._valid-object
  THEN ON CHOOSE OF h PERSISTENT RUN adeuib/_edtsmar.p (INTEGER(RECID(_U))). 

  CREATE menu-item h ASSIGN
    parent = hMenu
    label  = "Smart&Info..."
    TRIGGERS: 
      ON CHOOSE PERSISTENT 
        RUN VALUE(cSOInfoFile) (_S._HANDLE,"":U).
    END TRIGGERS
    . 
  
  IF NOT VALID-HANDLE(_p._tv-proc) THEN
    CREATE menu-item h ASSIGN
      parent = hMenu
      label  = "Smart&Links..."
    TRIGGERS: 
      ON CHOOSE PERSISTENT 
        RUN adeuib/_linked.w (RECID(_P), RECID(_U)).
     END TRIGGERS
     . 
  
  IF NOT glRemote THEN
  DO:
    CREATE menu-item h assign
      parent = hMenu  
      subtype = "RULE"
      .   
    
    CREATE menu-item h assign
      parent = hMenu
      label  = "&Edit Master"
      TRIGGERS: 
        ON CHOOSE PERSISTENT 
          RUN adeuib/_edtmstr.p (RECID(_U)).
      END TRIGGERS
      .
  
  END. /* not lremote */
  
  CREATE menu-item h assign
    parent = hMenu  
    subtype = "RULE"
   .   
  
  CREATE menu-item h assign
    parent = hMenu
    label  = (IF cLOMaster THEN "&Delete Instance" ELSE "&Remove from Layout")
    TRIGGERS: 
      ON CHOOSE PERSISTENT 
        RUN choose_erase IN _h_uib.
    END TRIGGERS
    .    
  
  /* Now attach the menu */
  phParent:POPUP-MENU = hMenu.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-createVisualization) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE createVisualization Procedure 
PROCEDURE createVisualization PRIVATE :
/* --------------------------------------------------------------
     We create an visualization for an object that we can't visualize
     in the uib. 
     This visualization is a frame with an image to represent the non-visual 
     object (eg. a SmartQuery).
-------------------------------------------------------------*/ 
  DEFINE VAR hFrame AS WIDGET NO-UNDO.
  DEFINE VAR hdl    AS WIDGET NO-UNDO.


  /* Font used for the visualization */
  &Scoped-Define Text-Font 4  

  /* Create a frame big enough for the image and one line of text */
  CREATE FRAME hFrame ASSIGN
    HEIGHT-P     = {&ImageSize} + FONT-TABLE:GET-TEXT-HEIGHT-P ({&Text-Font}) + 2
    WIDTH-P      = {&ImageSize} + 30    
    HIDDEN       = YES
    OVERLAY      = YES
    BOX          = NO
    THREE-D      = YES
    BGCOLOR      = ?
    SCROLLABLE   = NO
    .    
   
  /* Do we know the size? (We do if we are in a TTY layout, for instance.
     We want to show the size)  Resize the visualization to its correct size. */
  IF _L._HEIGHT ne ? AND _L._ROW-MULT ne ? THEN 
    hFrame:HEIGHT = MAX(hFrame:HEIGHT, _L._HEIGHT * _L._ROW-MULT).
  IF _L._WIDTH ne ? AND _L._COL-MULT ne ? THEN 
    hFrame:WIDTH = MAX(hFrame:WIDTH, _L._WIDTH * _L._COL-MULT).
 
  /* This will be the widget that the UIB uses to reference the
     object. Use the image itself as the visualization within the UIB */
  _U._HANDLE = hFrame.

  IF parent_U._TYPE eq "WINDOW" THEN 
    _U._HANDLE:PARENT = parent_U._HANDLE.
  ELSE 
    _U._HANDLE:FRAME  = parent_U._HANDLE. 
  
  IF VALID-HANDLE(_P._tv-proc) THEN
  DO:
    ASSIGN _U._HANDLE:ROW        = 1.0 
           _U._HANDLE:COLUMN     = 1.0
           _U._HANDLE:SELECTABLE = FALSE
           _U._HANDLE:MOVABLE    = FALSE 
           _U._HANDLE:RESIZABLE  = FALSE. 
  END. /* if valid-handle(_p._tv-proc) */
  ELSE DO:
    /* Place this object on the screen. */
    ASSIGN _U._HANDLE:ROW        = 1.0 + ((_L._ROW - 1.0) * _L._ROW-MULT) 
           _U._HANDLE:COLUMN     = 1.0 + ((_L._COL - 1.0) * _L._COL-MULT)
           _U._HANDLE:SELECTABLE = YES
           _U._HANDLE:MOVABLE    = glMovable 
           _U._HANDLE:RESIZABLE  = glResizable
           . 
  
    /* Create an "visualization" image on the object followed by two rows of
       text. (Hide the text for now). */
    CREATE TEXT hdl ASSIGN
        WIDTH-P      = 2
        FONT         = {&Text-Font}
        FORMAT       = "X(128)":U
        SCREEN-VALUE = _U._SUBTYPE /* e.g. "SmartViewer" */
        FRAME        = hFrame
        HIDDEN       = yes
        PRIVATE-DATA = "Type"
        .
    CREATE TEXT hdl ASSIGN
        WIDTH-P      = 2
        FONT         = {&Text-Font}
        FORMAT       = "X(128)":U
        SCREEN-VALUE = _U._NAME  /* e.g. "h_v-cust" */
        FRAME        = hFrame
        HIDDEN       = yes
        PRIVATE-DATA = "Name"
        .
    CREATE IMAGE hdl ASSIGN 
        FRAME             = hFrame  
        HEIGHT-P          = {&ImageSize}
        WIDTH-P           = {&ImageSize}
        HIDDEN            = false
        CONVERT-3D-COLORS = TRUE
        PRIVATE-DATA      = "Image"
        .
    /* The image name is stored in _palette_item for many known types.
       Otherwise, just use a default icon for valid objects and the "no run"
       icon for bad objects. */
    IF _U._SUBTYPE NE "SmartDataObject" THEN
      FIND _palette_item WHERE _palette_item._name eq _U._SUBTYPE NO-ERROR. 
    ELSE 
      FIND _palette_item WHERE _palette_item._name eq "SmartDataObject" NO-ERROR.
    
    /* Objects that are SmartContainers have no explicit palette icon.
       (for example, SmartWindows and SmartFrames should be SmartContainers).
       In this case, use the SmartContainer icon, if available.  We see if
       it is container by checking to see if it is has "adm-create-objects".*/     
    IF (NOT AVAILABLE _palette_item) AND 
       (_S._valid-object AND 
        CAN-DO (_S._HANDLE:INTERNAL-ENTRIES, "adm-create-objects":U))
    THEN FIND _palette_item WHERE _palette_item._name eq "SmartContainer":U NO-ERROR. 

    IF AVAILABLE _palette_item THEN 
      hdl:LOAD-IMAGE (_palette_item._icon_up,
                      _palette_item._icon_up_x + 1,
                      _palette_item._icon_up_y + 1,
                      {&ImageSize} - 2,
                      {&ImageSize} - 2).
    ELSE 
      hdl:LOAD-IMAGE (IF _S._valid-object 
                      THEN "adeicon/smartobj"
                      ELSE "adeicon/badsmo", 
                      0, 
                      0, 
                      {&ImageSize}, 
                      {&ImageSize}).

  END. /* not treeview*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-initializeSMO) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeSMO Procedure 
PROCEDURE initializeSMO :
/*------------------------------------------------------------------------------
  Purpose: Initialize the SmartObject    
  Parameters:  pu_recid - recid(_U)
                          unknown menas that the current tables will be used 
                              
  Notes:      Called from realizeSMO with unknown to use the current temp-tables. 
              Called from _rdsmart with recid in order to initialize AFTER
              the links has been created.     
              Note that there's no validation to check if this is a valid 
              SmartObject. This is because this procedure is called from
              or AFTER realizeSMO, which takes care of the checking. 
------------------------------------------------------------------------------*/
 DEFINE INPUT PARAMETER pu_RecId AS RECID NO-UNDO.

 IF pU_Recid <> ? THEN 
 DO:
   setCurrent(pu_Recid).
   /* Determine the version of the object */
   {adeuib/admver.i _S._HANDLE admVersion}.
 END.
  
 IF VALID-HANDLE(_S._HANDLE) AND 
    (_S._visual OR _U._SubType = "SmartBusinessObject":U) THEN 
 DO:
    INITIALIZE-BLOCK:
    DO ON STOP  UNDO INITIALIZE-BLOCK, LEAVE INITIALIZE-BLOCK
       ON ERROR UNDO INITIALIZE-BLOCK, LEAVE INITIALIZE-BLOCK:

       IF admVersion LT "ADM2":U THEN
       DO:
         RUN dispatch IN _S._HANDLE ("initialize":U).
         /* Hide it, if it needs to be hidden in the UIB.   We could have
            set HIDE-ON-INIT (a standard ADM attribute), but this would have
            been added to the permanent attribute list.  As it stands now, a
            SmartObject will be first viewed, and then hidden if it is on 
            another page or layout. */
         IF {&hideobject} THEN 
           RUN dispatch IN _S._HANDLE ("hide":U).
       END. /* ADM1 */
       ELSE
       DO:
         /* Start the super-procedure with design-time overrides 
            (getFilterTarget, getDataSource) */
         RUN start-super-proc IN _S._HANDLE ("adm2/design.p":U). 
                  
         /* Workaround for the problem caused with menus on hidden pages 
           by the fact that everything is both viewed and hidden here 
           (See details in design.p and toolbar.p viewObject)   
           Tried to solve it with hideOninit but then the 'ventilator' 
           disappears! */
         
         IF _U._subtype MATCHES "*Toolbar*":U THEN 
            DYNAMIC-FUNCTION('setDesignTimeHideMenu':U IN _s._handle,
                              {&hideobject}) NO-ERROR.
         
         RUN initializeObject IN _S._HANDLE.
         /* Hide it, if it needs to be hidden in the UIB.   We could have
            set HIDE-ON-INIT (a standard ADM attribute), but this would have
            been added to the permanent attribute list.  As it stands now, a
            SmartObject will be first viewed, and then hidden if it is on 
            another page or layout. */         
         IF {&hideobject} THEN
           RUN hideObject IN _S._HANDLE.
         
         /* Turn it off so it works when swithing pages.  */
         IF _U._subtype MATCHES "*Toolbar*":U THEN 
            DYNAMIC-FUNCTION('setDesignTimeHideMenu':U IN _s._handle,
                              FALSE) NO-ERROR.


       END. /* > ADM1 */
    END. /* INITIALIZE-BLOCK */
  END. /* valid _S and _S._visual */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-realizeSMO) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE realizeSMO Procedure 
PROCEDURE realizeSMO :
/*------------------------------------------------------------------------------
  Purpose: Realize (undelete) the SmartObject. 
           This is the main procedure that calls all the others 
  Parameters:  pu_Recid   -  RECID(_U)
               plInitialize - yes - initialize the SmartObject.
                            - no  - don't initialize the SmartObject .
  Notes:       
------------------------------------------------------------------------------*/
 DEFINE INPUT PARAMETER pu_RecId     AS RECID NO-UNDO.
 DEFINE INPUT PARAMETER plInitialize AS LOGICAL NO-UNDO.

 DEFINE VARIABLE cFilePrfx     AS CHAR    NO-UNDO.
 DEFINE VARIABLE cFileBase     AS CHAR    NO-UNDO.
 DEFINE VARIABLE cFileExt      AS CHAR    NO-UNDO.
 DEFINE VARIABLE cFileName     AS CHAR    NO-UNDO.
 DEFINE VARIABLE iCnt          AS INT     NO-UNDO.
 DEFINE VARIABLE lAlreadyRetry AS LOG     NO-UNDO.
 DEFINE VARIABLE lHidden       AS LOG     NO-UNDO.
 DEFINE VARIABLE iOrigHeightP  AS INTEGER NO-UNDO.
 DEFINE VARIABLE iOrigWidthP   AS INTEGER NO-UNDO.
 DEFINE VARIABLE hFldGrp       AS HANDLE  NO-UNDO.
 DEFINE VARIABLE hFldWdgt      AS HANDLE  NO-UNDO.
      
 IF pU_Recid <> ? THEN 
   setCurrent(pu_Recid).
 
   /* Break the file name into its component parts. For example:
    c:\bin.win\gui\test.r => file-prfx "c:\bin.win\gui\",  file-base "test.r"
                             file-ext  "r" 
 */

 RUN adecomm/_osprefx.p (_S._FILE-NAME, OUTPUT cFilePrfx, OUTPUT cFileBase).

 ASSIGN iCnt     = NUM-ENTRIES(cFileBase, ".")
        cFileExt = IF iCnt < 2 THEN "" ELSE ENTRY(iCnt, cFileBase, "." ).

 REALIZE-BLOCK:
 /* Note that STOP will occur if we try to compile a SmartObject that uses
   a database that is not connected (for example). */
 DO ON STOP  UNDO REALIZE-BLOCK, LEAVE REALIZE-BLOCK
    ON ERROR UNDO REALIZE-BLOCK, LEAVE REALIZE-BLOCK:

   RUN adecomm/_relfile.p (_S._FILE-NAME,
                        VALID-HANDLE(_p._tv-proc), /* check remote if preferences is set */
                        "":U, /* no message here */ 
                        OUTPUT cFileName).
   
   /* Error conditions: Object not found -- LEAVE the block. */
   IF cFileName eq ? THEN 
   DO:
     IF cFileExt ne "r" THEN 
     DO:
       /* cnt = NUM-ENTRIES (file-base, ".") -- so is the file-base name "", "x",
          or "x.w" */
       CASE iCnt:
         WHEN 0 THEN cFileName = ?.
         WHEN 1 THEN cFileName = cFilePrfx + cFileBase + ".r".
         OTHERWISE DO:
          /* Replace the .r at the end of the file name. */
           ASSIGN cFileName = cFileBase
                  ENTRY(iCnt, cFileName, ".") = "r"
                  cFileName = cFilePrfx + cFileName.
         END.
       END CASE.     
     END.
     RUN adecomm/_relfile.p 
         (cFileName,
          VALID-HANDLE(_p._tv-proc), /* check remote if preferences is set */
       "MESSAGE:" + _S._FILE-NAME + CHR(10) +
       "This SmartObject master file could not be found&1." + CHR(10) + CHR(10) +      
       "A running instance of SmartObject" + _U._NAME + "could not" + CHR(10) +
       "be created.  The" + "{&UIB_NAME}" + "will display a placeholder to" 
                                                                      + CHR(10) +
       "represent the SmartObject.", 
          OUTPUT cFileName).
     
     IF cFileName = ? THEN 
       LEAVE REALIZE-BLOCK.   
   END. /* IF SEARCH(_S._FILE-NAME) eq ? */
    
   /* Temporarily reset the CURRENT-WINDOW (in case the SmartObject uses
      it when it runs. (This is only an emergency option and it should never
      matter.  Doing this however, just stops random items from appearing
      in the UIB's main window.)  NOTE: _h_win can be a frame if parent_U
      is a dialog-box. */
   CURRENT-WINDOW = (IF _h_win:TYPE eq "FRAME" THEN _h_win:PARENT ELSE _h_win).

   /* Run and initialize the SmartObject. */ 
   {adeuib/undsmar.i _S._FILE-NAME 
                     _S._HANDLE 
                     "'The AppBuilder will present a placeholder to represent the SmartObject.'" 
                     glRemote}
   
   RUN adecomm/_setcurs.p ("WAIT"). /* Be sure the wait cursor is on. */
   IF NOT VALID-HANDLE(_S._HANDLE) THEN 
     LEAVE REALIZE-BLOCK.
 
   {adeuib/admver.i _S._HANDLE admVersion}.

   /* Check to make sure this is a UIB supported SmartObject */
   RUN validSmartObject (INPUT _S._HANDLE, OUTPUT lOK).
   
   IF NOT lOK THEN 
   DO:
     RUN adeuib/_delet_u.p (RECID(_U), yes /* TRASH */ ).
     RETURN "Error".
   END.
   ELSE DO:
     IF admVersion LT "ADM2":U THEN 
     DO:
       /* Set the UIB mode for the object.  Do this FIRST thing, in case the
          SmartObject does anything based on this. */
       RUN set-attribute-list IN _S._HANDLE ("UIB-mode=Design").
    
       /* If the SmartObject supports the current layout, then set it as the
          "Default-Layout" attribute. */
       RUN get-attribute IN _S._HANDLE ('Layout-Options':U) NO-ERROR.
       IF NOT ERROR-STATUS:ERROR AND CAN-DO(RETURN-VALUE, _U._LAYOUT-NAME) THEN
       RUN set-attribute-list IN _S._HANDLE ("Default-Layout=":U + _U._LAYOUT-NAME).
       /* Get the current handle of the main widget in the SmartObject. */
       RUN get-attribute IN _S._HANDLE ('ADM-OBJECT-HANDLE':U).
       ASSIGN _U._HANDLE = WIDGET-HANDLE(RETURN-VALUE) NO-ERROR.
     END. /* ADM1 */
     ELSE DO:
       /* Set the UIB mode for the object.  Do this FIRST thing, in case the
          SmartObject does anything based on this. */
       DYNAMIC-FUNCTION("setUIBMode":U IN _S._HANDLE,"Design":U).
    
       /* If the SmartObject supports the current layout, then set it as the
          "Default-Layout" attribute. */
       cValue = DYNAMIC-FUNCTION("getLayoutOptions":U IN _S._HANDLE) NO-ERROR.
       IF NOT ERROR-STATUS:ERROR AND CAN-DO(cValue, _U._LAYOUT-NAME) THEN
         DYNAMIC-FUNCTION("setDefaultLayout":U IN _S._HANDLE, _U._LAYOUT-NAME).
       /* Get the current handle of the main widget in the SmartObject. */
       cValue = DYNAMIC-FUNCTION("getContainerHandle":U IN _S._HANDLE) NO-ERROR.
       IF NOT ERROR-STATUS:ERROR THEN 
         ASSIGN _U._HANDLE = WIDGET-HANDLE(cValue) NO-ERROR.
     END. /* > ADM1 */
     

     /* Change the parent record if the object is a WINDOW or DIALOG-BOX */
     IF VALID-HANDLE(_U._HANDLE) 
     AND CAN-DO("DIALOG-BOX,WINDOW", _U._HANDLE:TYPE)
     AND parent_U._TYPE ne "WINDOW" THEN 
     DO:
       FIND parent_U WHERE parent_U._HANDLE eq _P._WINDOW-HANDLE.
       _U._parent-recid = RECID(parent_U).
     END.
    
     /* Parent the frame, set its attributes and position, and realize it. */
     IF VALID-HANDLE(_U._HANDLE) AND _U._HANDLE:PARENT eq ? THEN DO:
       IF admVersion LT "ADM2":U THEN 
         RUN set-attribute-list IN _S._HANDLE 
           ( 'ADM-PARENT = ':U + STRING(parent_U._HANDLE))  NO-ERROR.
       ELSE
         lValue = dynamic-function("setObjectParent":U IN _S._HANDLE,STRING(parent_U._HANDLE))  NO-ERROR.
     END. /* valid handle and parent = ? */
     IF admVersion LT "ADM2":U THEN 
     DO:
       RUN set-attribute-list IN _S._HANDLE (_S._settings) NO-ERROR. 
       RUN set-position IN _S._HANDLE (_L._ROW, _L._COL) NO-ERROR. 
     END.  /* IF < ADM2 */
     ELSE DO: 
       DO icnt = 1 TO NUM-ENTRIES(_S._settings,CHR(3)):
          cValue = ENTRY(icnt,_S._settings,CHR(3)).
          lValue = DYNAMIC-FUNCTION("set":U + ENTRY(1,cValue,CHR(4)) IN _S._HANDLE, 
                                       ENTRY(2,cValue,CHR(4))) NO-ERROR.
       END. /* entries in settings */
       RUN repositionObject IN _S._HANDLE (_L._ROW, _L._COL) NO-ERROR. 
     END. /* > ADM1 */

     /* The object still seems ok, make sure it matches with the container */
     IF (_P._adm-version < "ADM2" AND admVersion >= "ADM2") OR
        (_P._adm-version >= "ADM2" AND admVersion < "ADM2") THEN 
     DO:
       MESSAGE _S._FILE-NAME "is an" admVersion "SmartObject and can not be"
              "run in an" _P._adm-version "container." SKIP (1)
              "You should replace" _S._FILE-NAME "with a valid" _P._adm-version
              "object."
             VIEW-AS ALERT-BOX ERROR.
       DELETE PROCEDURE _S._HANDLE.
     END.
   END. /* Else it was a valid-SmartObject */
 END. /* Realize-Block */

  
 /* Restore the cursor */
 RUN adecomm/_setcurs.p ("").

 /* Reset the CURRENT-WINDOW */
 CURRENT-WINDOW = _h_menu_win. 

 /* If we get here, and the widget has not been created, then mark it as
    an invalid object, but save all the other information about it.  */
 IF NOT VALID-HANDLE(_S._HANDLE) THEN DO:  
   ASSIGN _S._valid-object = NO
          _S._visual       = NO
          _U._SUBTYPE      = ""
         .
 END.  
 ELSE DO:    
   /* It ran --- hurray */
   _S._valid-object = YES.

  /* Get the subtype. [If it is not in the object, then don't overwrite
     the value which was set to _next_draw in _drwobj.p.] */
   IF admVersion LT "ADM2":U THEN DO:
      RUN get-attribute IN _S._HANDLE (INPUT "TYPE").  
      IF RETURN-VALUE ne "" THEN _U._SUBTYPE = RETURN-VALUE.
   END. /* ADM1 */
   ELSE DO:
     cValue = dynamic-function("getObjectType":U IN _S._HANDLE).  
     IF cValue ne "" THEN _U._SUBTYPE = cValue.
   END. /* > ADM1 */
   IF _U._SUBTYPE eq "":U  THEN _U._SUBTYPE = "SmartObject":U.  /* [default subtype = type] */
           
   /* If this is not a handle, then it has no visualization. 
      (or that handle is not a container)... and we don't have to scale
      row and column. Our own visualizations are always movable and resizable. */       
   IF (VALID-HANDLE (_U._HANDLE) AND _U._HANDLE:TYPE eq "FRAME") THEN 
   DO:
     _S._visual = (_L._ROW-MULT eq 1.0) AND (_L._COL-MULT eq 1.0).
     /* If we can't visualize it because of the layout multiplier, but it is still 
        a valid-object, read its size from object itself.  This does not need 
        to be multiplied by _L._COL-MULT and _L._ROW-MULT because the
        object is returning its "desired" true size. */
     IF NOT _S._visual THEN 
     DO:
       IF _L._WIDTH eq ?  THEN _L._WIDTH  = _U._HANDLE:WIDTH. 
       IF _L._HEIGHT eq ? THEN _L._HEIGHT = _U._HANDLE:HEIGHT.
     END. 
   END.
   ELSE ASSIGN glMovable = yes       /* If object is not visual, make our...  */
               glResizable = yes     /* ...internal visualization move/resize */
              . 

 END.
 
 /* If the object is not VISUAL, then we we need to make a dummy 
    visualization. This will replace the object in _U._HANDLE. */
 IF NOT _S._visual THEN 
   RUN createVisualization.  

 /* If the master was edited and the frame was made bigger, reset the _L
   record.  Otherwise, things won't fit in the frame.  98-09-30-051     */
 IF _U._HANDLE:TYPE = "FRAME" AND _U._SUBTYPE = "SmartDataBrowser":U THEN 
 DO:
   /* Make sure things fit 98-09-30-051 */
   hFldGrp  = _U._HANDLE:FIRST-CHILD.
   hFldWdgt = hFldGrp:FIRST-CHILD.
   DO WHILE VALID-HANDLE(hFldWdgt):
     IF hFldWdgt:TYPE NE "BROWSE" THEN DO:
       IF _L._HEIGHT NE ? THEN _L._HEIGHT = MAX(_L._HEIGHT,hFldWdgt:ROW - 1 + hFldWdgt:HEIGHT).
       IF _L._WIDTH NE ?  THEN _L._WIDTH  = MAX(_L._WIDTH,hFldWdgt:COLUMN - 1 + hFldWdgt:WIDTH).
     END.  /* IF this isn't a browser */
     hFldWdgt = hFldWdgt:NEXT-SIBLING.
   END.  /* If we have a valid widget in the frame */
 END.  /* If we have a frame */

 /* Run the code to size our visualizations of SmartObjects. */
 IF NOT VALID-HANDLE(_P._tv-proc) THEN
   RUN adeuib/_setsize.p (RECID(_U), _L._HEIGHT, _L._WIDTH).

 /* Assign Handles that we now know (including _h_cur_widg). */
 ASSIGN  {adeuib/std_ul.i &section = "HANDLES"} .

 /* Place object within parent's boundaries. Note that realizing the
    object can fail in many circumstances.  Try to deal with as many of
    these as possible. For example, if the object does not fit in the
    frame, try making it SCROLLABLE. */       
 ASSIGN lAlreadyRetry = NO
        iOrigWidthP  = _U._HANDLE:VIRTUAL-WIDTH-P
        iOrigHeightP = _U._HANDLE:VIRTUAL-HEIGHT-P.

 IF NOT VALID-HANDLE(_P._tv-proc) THEN
 VIEW-OBJECT:
 DO ON ERROR UNDO VIEW-OBJECT, RETRY VIEW-OBJECT:
   IF RETRY THEN 
   DO:
     /* If this is the second retry, then just kill the object. */
     IF lAlreadyRetry THEN 
     DO:    
       RUN adeuib/_delet_u.p (RECID(_U), yes /* TRASH */).
       RETURN "Error".
     END.  
     /* If the first try failed, make the object scrollable. */
     ASSIGN lAlreadyRetry               = YES
            _U._HANDLE:SCROLLABLE       = YES
            _U._HANDLE:VIRTUAL-WIDTH-P  = iOrigWidthP
            _U._HANDLE:VIRTUAL-HEIGHT-P = iOrigHeightP.
   END.
    
   /* We might not be able to visualize the widget (if for example, it
      won't fit in the frame.)  Note that the object is hidden if it is not
      in this layout, or if it is not on the current page. */
   lHidden = {&hideobject}.

   { adeuib/onframe.i
       &_whFrameHandle = "parent_U._HANDLE"
       &_whObjHandle   = "_U._HANDLE"
       &_lvHidden      = lHidden }
   
   IF plInitialize THEN 
     RUN initializeSMO(?).
    
 END. /* VIEW-OBJECT */

 /* Make sure the Universal Widget Record is "correct" by reading the actually
   instantiated values. */
 ASSIGN  {adeuib/std_ul.i &section = "GEOMETRY"} .

 /* If the object is a valid SmartObject, read some more attributes from
    it.  NOTE - we do this after initialization in case the SmartObject is
    self modifying and changes its links or tables.  */
 IF _S._valid-object THEN DO:
/*   &MESSAGE [_realizesmart.p] Remove _S._LINKS, and tables, from _S record (wood) */

   IF admVersion LT "ADM2":U THEN 
   DO:
     /* Get the links and tables supported by the object. */
     RUN get-attribute IN _S._HANDLE (INPUT "SUPPORTED-LINKS":U).  
     _S._links = IF RETURN-VALUE ne ? THEN RETURN-VALUE ELSE "":U.

     /* Tables are stored in SmartObjects in space-delimited lists. 
      * Internally to the UIB uses commas. */
     RUN get-attribute IN _S._HANDLE (INPUT "EXTERNAL-TABLES":U).  
     _S._external-tables = IF RETURN-VALUE ne ? 
                        THEN REPLACE(RETURN-VALUE," ":U,",":U)  
                        ELSE "":U.
     RUN get-attribute IN _S._HANDLE (INPUT "INTERNAL-TABLES":U).  
     _S._internal-tables = IF RETURN-VALUE ne ? 
                        THEN REPLACE(RETURN-VALUE," ":U,",":U)  
                        ELSE "":U.   
   END. /* ADM1 */
   ELSE IF NOT VALID-HANDLE(_P._tv-proc) THEN
   DO:
     /* Get the links and tables supported by the object. */
     cValue = dynamic-function("getSupportedLinks":U IN _S._HANDLE) NO-ERROR.
     ASSIGN _S._links = IF ERROR-STATUS:ERROR OR cValue ne ? THEN 
                             cValue 
                        ELSE "":U.

     /* Tables are stored in SmartObjects in space-delimited lists. 
      * Internally to the UIB uses commas. */
     _S._external-tables = "".
     cValue = dynamic-function("getInternalTables":U IN _S._HANDLE) NO-ERROR.  
     _S._internal-tables = IF (NOT ERROR-STATUS:ERROR) AND cValue ne ? 
                        THEN REPLACE(cValue," ":U,",":U)  
                        ELSE "":U.   
   END. /* > ADM1 */
 END. /* IF...valid-object... */
      
 /* Add on our "affordances": a button with a popup-menu */
 IF NOT VALID-HANDLE(_P._tv-proc) THEN
   RUN createAffordance.
  
 /* Add a popup menu to the base object 
    This will also be used for the TreeView */
 RUN createPopupMenu (_U._HANDLE).
  
 /* Set triggers on the moving and clicking of the object itself */
 IF NOT VALID-HANDLE(_P._tv-proc) THEN
 DO: 
   RUN createDesignTriggers.                                                     

   /* Make sure the affordance button is on top (by Moving it to the top after
     everything else has realized.) */
   lOK = _S._affordance-handle:MOVE-TO-TOP ().  

   /* Make sure the widget is truly hidden.  Adding the affordance can make the
     window visible. */
   IF lHidden AND _U._HANDLE:VISIBLE THEN _U._HANDLE:HIDDEN = yes.
 END. /* if not valid-handle(_p._tv-proc) */
 ELSE DO: 
   ASSIGN 
     _U._HANDLE:HIDDEN = yes    
    /* Avoid this in the treeview, because its not selected */                               
     _h_cur_widg       = ?.      
   RUN createSoNode IN _P._tv-proc (RECID(_U)).
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-validSmartObject) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validSmartObject Procedure 
PROCEDURE validSmartObject PRIVATE :
/*------------------------------------------------------------------------------
  Purpose: Check that the procedure handle has all the pieces that make
           it a valid SmartObject that can be used by the UIB.
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT  PARAMETER pSmart AS HANDLE  NO-UNDO.
  DEFINE OUTPUT PARAMETER pOK    AS LOGICAL NO-UNDO.

  DEFINE VARIABLE cMethods   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cNotFound AS CHARACTER NO-UNDO.

  cMethods = pSmart:INTERNAL-ENTRIES.

  IF admVersion LT "ADM2":U THEN DO:  /* We are attempting to instantiate an ADM1 SO */
    /* Assume its OK, until we find otherwise */
    pOK = CAN-DO (cMethods, "dispatch").
    IF NOT pOK THEN cNotFound = "dispatch".
    ELSE DO: /* Still ok 1 */
      pOK =    CAN-DO (cMethods, "adm-initialize") OR
               CAN-DO (cMethods, "local-initialize") OR
               CAN-DO (cMethods, "initialize").
      IF NOT pOK THEN cNotFound = "initialize".
      ELSE DO: /* Still OK 2 */
        pOK =    CAN-DO (cMethods, "adm-destroy") OR
                 CAN-DO (cMethods, "local-destroy") OR
                 CAN-DO (cMethods, "destroy").
        IF NOT pOK THEN cNotFound = "destroy".
        ELSE DO: /* Still OK 3 */
          /* A smartObject must be able to set and get attributes (esp. UIB-mode). */
          pOK = CAN-DO (cMethods, "set-attribute-list").
          IF NOT pOK THEN cNotFound = "set-attribute-list".
          ELSE DO: /* Still OK 4 */
            pOK = CAN-DO (cMethods, "get-attribute-list").
            IF NOT pOK THEN cNotFound = "get-attribute-list".
            ELSE DO:  /* Still OK 5 */
              pOK = CAN-DO (cMethods, "get-attribute").
              IF NOT pOK THEN cNotFound = "get-attribute".
            END. /* Still ok 5 */
          END. /* Still ok 4 */
        END. /* Still ok 3 ..set-attribute-list */
      END. /* Still ok 2 ..destroy */
    END. /* Still ok 1 initialize */
  END. /* IF an ADM1 SO */
  ELSE DO: /* ADM2 or higher */
    pOK = TRUE.
  END. /* > ADM1 */
  
  /* Report any error */
  IF NOT pOK THEN DO:
    MESSAGE "The Persistent Object '" + pSmart:FILE-NAME + "' could not"  {&SKP}
            "be used as a SmartObject in the " "{&UIB_NAME}" ".  It is missing a" {&SKP}
            "'" + cNotFound + "' method."
            VIEW-AS ALERT-BOX ERROR.
  END.  
  ELSE DO:
    /* The object is OK": check if it has methods to allow various aspects of
       design time behavior (i.e. Movable, Resizable, and Edit Attributes) */
    IF admVersion LT "ADM2":U THEN 
       ASSIGN glMovable   = CAN-DO (cMethods, "set-position":U)
              glResizable = CAN-DO (cMethods, "set-size":U)
              glEditAttr  = CAN-DO (cMethods, "adm-edit-attribute-list") OR
                            CAN-DO (cMethods, "local-edit-attribute-list") OR
                            CAN-DO (cMethods, "edit-attribute-list").
    ELSE DO: /* admVersion >= ADM2 */
       ASSIGN glMovable   = CAN-DO (cMethods, "repositionObject":U)
              glResizable = CAN-DO (cMethods, "resizeObject":U).
       ASSIGN cValue = dynamic-function("getPropertyDialog":U IN pSmart) NO-ERROR.
       IF (NOT ERROR-STATUS:ERROR) AND cValue <> "":U AND cValue <> ? THEN
         ASSIGN glEditAttr  = TRUE.
    END.

  END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

/* ************************  Function Implementations ***************** */

&IF DEFINED(EXCLUDE-setCurrent) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setCurrent Procedure 
FUNCTION setCurrent RETURNS LOGICAL
  (pU_REcid AS RECID) :
/*------------------------------------------------------------------------------
  Purpose: Find all temp-tables used in this object. 
    Notes: realizeSMO and initializeSMO will call this if they receive a 
           recid.  
           NO errors allowed (this is brought over from the old _undsmar.p)
------------------------------------------------------------------------------*/
 FIND _U       WHERE RECID(_U)       eq pu_RecId.
 FIND _L       WHERE RECID(_L)       eq _U._lo-recid.
 FIND _S       WHERE RECID(_S)       eq _U._x-recid.
 FIND parent_U WHERE RECID(parent_U) eq _U._parent-recid.

 /* Get the current Procedure. See if we are trying to recreate this on the
   current page. */
 FIND _P WHERE _P._WINDOW-HANDLE eq parent_U._WINDOW-HANDLE.
 
 RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF
