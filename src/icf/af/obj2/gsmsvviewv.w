&ANALYZE-SUSPEND _VERSION-NUMBER AB_v9r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          asdb             PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Update-Object-Version" vTableWin _INLINE
/* Actions: ? ? ? ? af/sup/afverxftrp.p */
/* This has to go above the definitions sections, as that is what it modifies.
   If its not, then the definitions section will have been saved before the
   XFTR code kicks in and changes it */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Definition Comments Wizard" vTableWin _INLINE
/* Actions: ? af/cod/aftemwizcw.w ? ? ? */
/* Program Definition Comment Block Wizard
Welcome to the Program Definition Comment Block Wizard. Press Next to proceed.
af/cod/aftemwizpw.w
*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE RowObject
       {"af/obj2/gsmsvfullo.i"}.


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS vTableWin 
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
/*---------------------------------------------------------------------------------
  File: gsmsvviewv.w

  Description:  Session Service SmartDataViewer

  Purpose:      Session Service Static SmartDataViewer

                There is an enabled, hidden calculated field on this SmartDataViewer.  This is
                here to work around an ADM2 problem where having only SmartDataFields on
                a viewer prevents enableFields from running and removes the link from the
                Toolbar to the viewer.

  Parameters:   <none>

  History:
  --------
  (v:010000)    Task:    90000026   UserRef:    posse
                Date:   11/04/2001  Author:     Tammy St Pierre

  Update Notes: Created from Template rysttviewv.w

  (v:010001)    Task:    90000037   UserRef:    posse
                Date:   18/04/2001  Author:     Tammy St Pierre

  Update Notes: Added notes about the hidden calculated field

--------------------------------------------------------------------------------*/
/*                   This .W file was created with the Progress UIB.             */
/*-------------------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* MIP-GET-OBJECT-VERSION pre-processors
   The following pre-processors are maintained automatically when the object is
   saved. They pull the object and version from Roundtable if possible so that it
   can be displayed in the about window of the container */

&scop object-name       gsmsvviewv.w
DEFINE VARIABLE lv_this_object_name AS CHARACTER INITIAL "{&object-name}":U NO-UNDO.
&scop object-version    010003

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* Astra 2 object identifying preprocessor */
&glob   astra2-staticSmartDataViewer yes

{af/sup2/afglobals.i}

DEFINE VARIABLE ghForeignFieldLookup AS HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDataViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER FRAME

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Update-Source,TableIO-Target,GroupAssign-Source,GroupAssign-Target

/* Include file with RowObject temp-table definition */
&Scoped-define DATA-FIELD-DEFS "af/obj2/gsmsvfullo.i"

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS RowObject.workaround 
&Scoped-define ENABLED-TABLES RowObject
&Scoped-define FIRST-ENABLED-TABLE RowObject
&Scoped-Define DISPLAYED-FIELDS RowObject.workaround 
&Scoped-define DISPLAYED-TABLES RowObject
&Scoped-define FIRST-DISPLAYED-TABLE RowObject
&Scoped-Define DISPLAYED-OBJECTS fiLogicalServiceType fiPhysicalServiceType 

/* Custom List Definitions                                              */
/* ADM-ASSIGN-FIELDS,List-2,List-3,List-4,List-5,List-6                 */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_gsclsdynlookup AS HANDLE NO-UNDO.
DEFINE VARIABLE h_gsmpydynlookup AS HANDLE NO-UNDO.
DEFINE VARIABLE h_gsmsedynlookup AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE fiLogicalServiceType AS CHARACTER FORMAT "X(256)":U 
     LABEL "Service Type" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1 NO-UNDO.

DEFINE VARIABLE fiPhysicalServiceType AS CHARACTER FORMAT "X(256)":U 
     LABEL "Service Type" 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     RowObject.workaround AT ROW 1 COL 90.2 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 4.8 BY 1
     fiLogicalServiceType AT ROW 2.05 COL 102.6 COLON-ALIGNED
     fiPhysicalServiceType AT ROW 3.05 COL 102.6 COLON-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY USE-DICT-EXPS 
         SIDE-LABELS NO-UNDERLINE THREE-D NO-AUTO-VALIDATE 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDataViewer
   Data Source: "af/obj2/gsmsvfullo.w"
   Allow: Basic,DB-Fields,Smart
   Container Links: Data-Target,Update-Source,TableIO-Target,GroupAssign-Source,GroupAssign-Target
   Frames: 1
   Add Fields to: Neither
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: RowObject D "?" ?  
      ADDITIONAL-FIELDS:
          {af/obj2/gsmsvfullo.i}
      END-FIELDS.
   END-TABLES.
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW vTableWin ASSIGN
         HEIGHT             = 3.33
         WIDTH              = 151.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB vTableWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW vTableWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frMain
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME frMain:SCROLLABLE       = FALSE
       FRAME frMain:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN fiLogicalServiceType IN FRAME frMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiPhysicalServiceType IN FRAME frMain
   NO-ENABLE                                                            */
ASSIGN 
       RowObject.workaround:HIDDEN IN FRAME frMain           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME frMain
/* Query rebuild information for FRAME frMain
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME frMain */
&ANALYZE-RESUME




&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK vTableWin 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN initializeObject.
  &ENDIF         

  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE addRecord vTableWin 
PROCEDURE addRecord :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE cDisplayedField AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cField          AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cValue          AS CHARACTER    NO-UNDO.
DEFINE VARIABLE hDataSource     AS HANDLE       NO-UNDO.
DEFINE VARIABLE hLookupField    AS HANDLE       NO-UNDO.

  RUN SUPER.

  /* When adding a new record, the foreign field value needs to be displayed in
     the appropriate lookup field.  */

    /* Get the data source of the viewer */
    hDataSource = DYNAMIC-FUNCTION('getDataSource':U).
    /* Get the data source of the viewer's data source */
    hDataSource = DYNAMIC-FUNCTION('getDataSource':U IN hDataSource).

    /* Get the displayed field in the lookup that represents the foreign field.
       ghForeignFieldLookup is set in enableFields 
       Extract the field name from the DisplayedField and use it to get the 
       column string value in the data source */
    cDisplayedField = DYNAMIC-FUNCTION('getDisplayedField':U IN ghForeignFieldLookup).
    cField = ENTRY(NUM-ENTRIES(cDisplayedField, '.':U), cDisplayedField, '.':U).
    cValue = DYNAMIC-FUNCTION('columnStringValue':U IN hDataSource, INPUT cField).

    /* Set the screen value of the lookup to the appropriate foreign field value */
    hLookupField = DYNAMIC-FUNCTION('getLookupHandle':U IN ghForeignFieldLookup).
    ASSIGN hLookupField:SCREEN-VALUE = cValue.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects vTableWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEFINE VARIABLE currentPage  AS INTEGER NO-UNDO.

  ASSIGN currentPage = getCurrentPage().

  CASE currentPage: 

    WHEN 0 THEN DO:
       RUN constructObject (
             INPUT  'adm2/dynlookup.w':U ,
             INPUT  FRAME frMain:HANDLE ,
             INPUT  'DisplayedFieldgsm_session_type.session_type_codeKeyFieldgsm_session_type.session_type_objFieldLabelSession TypeFieldTooltipEnter Session Type or Press F4 for Session Type LookupKeyFormat->>>>>>>>>>>>>>>>>9.999999999KeyDatatypedecimalDisplayFormatX(20)DisplayDatatypecharacterBaseQueryStringFOR EACH gsm_session_type NO-LOCK
                     BY gsm_session_type.session_type_codeQueryTablesgsm_session_typeBrowseFieldsgsm_session_type.session_type_code,gsm_session_type.session_type_descriptionBrowseFieldDataTypescharacter,characterBrowseFieldFormatsX(20),X(35)RowsToBatch200BrowseTitleLookup Session TypesViewerLinkedFieldsLinkedFieldDataTypesLinkedFieldFormatsViewerLinkedWidgetsColumnLabelsColumnFormatSDFFileNameSDFTemplateLookupImageadeicon/select.bmpParentFieldParentFilterQueryMaintenanceObjectMaintenanceSDOCustomSuperProcFieldNamesession_type_objDisplayFieldyesEnableFieldyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_gsmsedynlookup ).
       RUN repositionObject IN h_gsmsedynlookup ( 1.00 , 25.40 ) NO-ERROR.
       RUN resizeObject IN h_gsmsedynlookup ( 1.00 , 64.40 ) NO-ERROR.

       RUN constructObject (
             INPUT  'adm2/dynlookup.w':U ,
             INPUT  FRAME frMain:HANDLE ,
             INPUT  'DisplayedFieldgsc_logical_service.logical_service_codeKeyFieldgsc_logical_service.logical_service_objFieldLabelLogical Service CodeFieldTooltipEnter Logical Service or Press F4 for Logical Service LookupKeyFormat->>>>>>>>>>>>>>>>>9.999999999KeyDatatypedecimalDisplayFormatX(20)DisplayDatatypecharacterBaseQueryStringFOR EACH gsc_logical_service NO-LOCK,
                     FIRST gsc_service_type
                     WHERE gsc_service_type.service_type_obj = gsc_logical_service.service_type_obj NO-LOCK
                     BY gsc_logical_service.logical_service_codeQueryTablesgsc_logical_service,gsc_service_typeBrowseFieldsgsc_logical_service.logical_service_code,gsc_logical_service.logical_service_description,gsc_service_type.service_type_codeBrowseFieldDataTypescharacter,character,characterBrowseFieldFormatsX(20),X(35),X(20)RowsToBatch200BrowseTitleLookup Logical ServicesViewerLinkedFieldsgsc_service_type.service_type_codeLinkedFieldDataTypescharacterLinkedFieldFormatsX(20)ViewerLinkedWidgetsfiLogicalServiceTypeColumnLabelsColumnFormatSDFFileNameSDFTemplateLookupImageadeicon/select.bmpParentFieldParentFilterQueryMaintenanceObjectMaintenanceSDOCustomSuperProcFieldNamelogical_service_objDisplayFieldyesEnableFieldyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_gsclsdynlookup ).
       RUN repositionObject IN h_gsclsdynlookup ( 2.00 , 25.40 ) NO-ERROR.
       RUN resizeObject IN h_gsclsdynlookup ( 1.00 , 64.40 ) NO-ERROR.

       RUN constructObject (
             INPUT  'adm2/dynlookup.w':U ,
             INPUT  FRAME frMain:HANDLE ,
             INPUT  'DisplayedFieldgsm_physical_service.physical_service_codeKeyFieldgsm_physical_service.physical_service_objFieldLabelPhysical Service CodeFieldTooltipEnter Physical Service or Press F4 for Physical Service LookupKeyFormat->>>>>>>>>>>>>>>>>9.999999999KeyDatatypedecimalDisplayFormatX(20)DisplayDatatypecharacterBaseQueryStringFOR EACH gsm_physical_service NO-LOCK,
                     FIRST gsc_service_type
                     WHERE gsc_service_type.service_type_obj = gsm_physical_service.service_type_obj
                     BY gsm_physical_service.physical_service_codeQueryTablesgsm_physical_service,gsc_service_typeBrowseFieldsgsm_physical_service.physical_service_code,gsm_physical_service.physical_service_description,gsc_service_type.service_type_codeBrowseFieldDataTypescharacter,character,characterBrowseFieldFormatsX(20),X(35),X(20)RowsToBatch200BrowseTitleLookup Physical ServicesViewerLinkedFieldsgsc_service_type.service_type_codeLinkedFieldDataTypescharacterLinkedFieldFormatsX(20)ViewerLinkedWidgetsfiPhysicalServiceTypeColumnLabelsColumnFormatSDFFileNameSDFTemplateLookupImageadeicon/select.bmpParentFieldParentFilterQueryMaintenanceObjectMaintenanceSDOCustomSuperProcFieldNamephysical_service_objDisplayFieldyesEnableFieldyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_gsmpydynlookup ).
       RUN repositionObject IN h_gsmpydynlookup ( 3.00 , 25.40 ) NO-ERROR.
       RUN resizeObject IN h_gsmpydynlookup ( 1.00 , 64.40 ) NO-ERROR.

       /* Adjust the tab order of the smart objects. */
       RUN adjustTabOrder ( h_gsmsedynlookup ,
             RowObject.workaround:HANDLE IN FRAME frMain , 'BEFORE':U ).
       RUN adjustTabOrder ( h_gsclsdynlookup ,
             RowObject.workaround:HANDLE IN FRAME frMain , 'AFTER':U ).
       RUN adjustTabOrder ( h_gsmpydynlookup ,
             fiLogicalServiceType:HANDLE IN FRAME frMain , 'AFTER':U ).
    END. /* Page 0 */

  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI vTableWin  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME frMain.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enableFields vTableWin 
PROCEDURE enableFields :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE cEnabledHandles AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cField          AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cForeignField   AS CHARACTER    NO-UNDO.
DEFINE VARIABLE hDataSource     AS HANDLE       NO-UNDO.
DEFINE VARIABLE hDisabledLookup AS HANDLE       NO-UNDO.
DEFINE VARIABLE hDisabledField  AS HANDLE       NO-UNDO.
DEFINE VARIABLE hField          AS HANDLE       NO-UNDO.
DEFINE VARIABLE hLookupField    AS HANDLE       NO-UNDO.
DEFINE VARIABLE iNumLookup      AS INTEGER      NO-UNDO.

  RUN SUPER.

  /* When maintaining session services, the lookup for the foreign field value 
     is disabled.  For example, when maintaining session services for 
     session types, the session type lookup is disabled and when maintaining
     session services for logical services, the logical service lookup is 
     disabled.  This is done so that the key value is assigned appropriately 
     from its foreign field value.  */
  cEnabledHandles = DYNAMIC-FUNCTION('getEnabledHandles':U).
  hDataSource = DYNAMIC-FUNCTION('getDataSource':U).
  IF VALID-HANDLE(hDataSource) THEN DO:
    cForeignField = ENTRY(1, DYNAMIC-FUNCTION('getForeignFields':U IN hDataSource)).

    DO iNumLookup = 1 TO NUM-ENTRIES(cEnabledHandles):
      hField = WIDGET-HANDLE(ENTRY(iNumLookup, cEnabledHandles)).
      IF hField:TYPE = 'PROCEDURE':U THEN
      DO:
        cField = DYNAMIC-FUNCTION('getFieldName':U IN hField).
        /* If field is equal to the foreign field then we want to disable the
           lookup so that the value for the field comes from the foreign field. */
        IF cField = cForeignField THEN 
        DO:
          RUN disableField IN hField.
          hLookupField = DYNAMIC-FUNCTION('getLookupHandle':U IN hField).
          hLookupField:TAB-STOP = FALSE.
          hDisabledLookup = hField.
          hDisabledField = hLookupField.
          ASSIGN ghForeignFieldLookup = hField.
        END.  /* if cField = cForeignField */
      END.  /* if field is procedure */
    END.  /* do iNumLookup */

    IF hDisabledLookup = h_gsmsedynlookup THEN 
      RUN applyEntry IN h_gsclsdynlookup( '':U).

  END.  /* if hDataSource valid */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE RTB_xref_generator vTableWin 
PROCEDURE RTB_xref_generator :
/* -----------------------------------------------------------
Purpose:    Generate RTB xrefs for SMARTOBJECTS.
Parameters: <none>
Notes:      This code is generated by the UIB.  DO NOT modify it.
            It is included for Roundtable Xref generation. Without
            it, Xrefs for SMARTOBJECTS could not be maintained by
            RTB.  It will in no way affect the operation of this
            program as it never gets executed.
-------------------------------------------------------------*/
  RUN "adm2\dynlookup.w *RTB-SmObj* ".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
