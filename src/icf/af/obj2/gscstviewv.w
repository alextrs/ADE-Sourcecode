&ANALYZE-SUSPEND _VERSION-NUMBER AB_v9r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          icfdb            PROGRESS
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
       {"af/obj2/gscstfullo.i"}.


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
  File: gscstviewv.w

  Description:  Service Type SmartDataViewer

  Purpose:      Service Type Static SmartDataViewer

  Parameters:   <none>

  History:
  --------
  (v:010000)    Task:    90000026   UserRef:    posse
                Date:   10/04/2001  Author:     Tammy St Pierre

  Update Notes: Created from Template rysttviewv.w

---------------------------------------------------------------------------------*/
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

&scop object-name       gscstviewv.w
DEFINE VARIABLE lv_this_object_name AS CHARACTER INITIAL "{&object-name}":U NO-UNDO.
&scop object-version    000000

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* Astra 2 object identifying preprocessor */
&glob   astra2-staticSmartDataViewer yes

{af/sup2/afglobals.i}
{af/sup2/afttcombo.i}

DEFINE VARIABLE gcUIBMode                  AS CHARACTER    NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDataViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER FRAME

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Update-Source,TableIO-Target,GroupAssign-Source,GroupAssign-Target

/* Include file with RowObject temp-table definition */
&Scoped-define DATA-FIELD-DEFS "af/obj2/gscstfullo.i"

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS RowObject.service_type_code ~
RowObject.service_type_description 
&Scoped-define ENABLED-TABLES RowObject
&Scoped-define FIRST-ENABLED-TABLE RowObject
&Scoped-Define ENABLED-OBJECTS fiShowRepositoryObjects 
&Scoped-Define DISPLAYED-FIELDS RowObject.service_type_obj ~
RowObject.service_type_code RowObject.service_type_description 
&Scoped-define DISPLAYED-TABLES RowObject
&Scoped-define FIRST-DISPLAYED-TABLE RowObject


/* Custom List Definitions                                              */
/* ADM-ASSIGN-FIELDS,List-2,List-3,List-4,List-5,List-6                 */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_dyncombo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_dynlookup AS HANDLE NO-UNDO.
DEFINE VARIABLE h_dynlookup-2 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE fiShowRepositoryObjects AS LOGICAL FORMAT "TRUE/FALSE":U INITIAL NO 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE .8 BY .19 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     RowObject.service_type_obj AT ROW 1 COL 1 NO-LABEL
          VIEW-AS FILL-IN 
          SIZE .8 BY .19
     fiShowRepositoryObjects AT ROW 1 COL 1
     RowObject.service_type_code AT ROW 1 COL 31.2 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 45.4 BY 1
     RowObject.service_type_description AT ROW 2.05 COL 31.2 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 78.4 BY 1
     SPACE(0.00) SKIP(3.19)
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY USE-DICT-EXPS 
         SIDE-LABELS NO-UNDERLINE THREE-D NO-AUTO-VALIDATE 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDataViewer
   Data Source: "af/obj2/gscstfullo.w"
   Allow: Basic,DB-Fields,Smart
   Container Links: Data-Target,Update-Source,TableIO-Target,GroupAssign-Source,GroupAssign-Target
   Frames: 1
   Add Fields to: Neither
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: RowObject D "?" ?  
      ADDITIONAL-FIELDS:
          {af/obj2/gscstfullo.i}
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
         HEIGHT             = 5.24
         WIDTH              = 110.6.
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

/* SETTINGS FOR FILL-IN fiShowRepositoryObjects IN FRAME frMain
   NO-DISPLAY ALIGN-L                                                   */
ASSIGN 
       fiShowRepositoryObjects:HIDDEN IN FRAME frMain           = TRUE
       fiShowRepositoryObjects:PRIVATE-DATA IN FRAME frMain     = 
                "TRUE".

/* SETTINGS FOR FILL-IN RowObject.service_type_obj IN FRAME frMain
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       RowObject.service_type_obj:HIDDEN IN FRAME frMain           = TRUE
       RowObject.service_type_obj:READ-ONLY IN FRAME frMain        = TRUE
       RowObject.service_type_obj:PRIVATE-DATA IN FRAME frMain     = 
                "NOLOOKUPS".

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
             INPUT  'DisplayedFieldryc_smartobject.object_filenameKeyFieldryc_smartobject.smartobject_objFieldLabelManagement Object FilenameFieldTooltipEnter Management Object Filename or Press F4 for Object LookupKeyFormat->>>>>>>>>>>>>>>>>9.999999999KeyDatatypedecimalDisplayFormatX(70)DisplayDatatypecharacterBaseQueryStringFOR EACH ryc_smartobject NO-LOCK, 
                     FIRST gsc_object_type WHERE gsc_object_type.object_type_obj = ryc_smartobject.object_type_obj NO-LOCK,
                     FIRST gsc_product_module WHERE gsc_product_module.product_module_obj = ryc_smartobject.product_module_obj NO-LOCK, 
                     FIRST gsc_product WHERE gsc_product.product_obj = gsc_product_module.product_obj 
                     BY gsc_product_module.product_module_code By gsc_object_type.object_type_code BY ryc_smartobject.object_filenameQueryTablesryc_smartobject,gsc_object_type,gsc_product_module,gsc_productBrowseFieldsgsc_product_module.product_module_code,gsc_object_type.object_type_code,ryc_smartobject.object_filename,ryc_smartobject.object_descriptionBrowseFieldDataTypescharacter,character,character,characterBrowseFieldFormatsX(10),X(15),X(70),X(35)RowsToBatch200BrowseTitleLookup ObjectsViewerLinkedFieldsLinkedFieldDataTypesLinkedFieldFormatsViewerLinkedWidgetsColumnLabelsColumnFormatSDFFileNameSDFTemplateLookupImageadeicon/select.bmpParentFieldfiShowRepositoryObjectsParentFilterQuery(IF ~'&1~' = ~'no~' THEN NOT gsc_product.product_code BEGINS ~'090~' ELSE TRUE)MaintenanceObjectMaintenanceSDOCustomSuperProcFieldNamemanagement_object_objDisplayFieldyesEnableFieldyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_dynlookup ).
       RUN repositionObject IN h_dynlookup ( 3.10 , 33.20 ) NO-ERROR.
       RUN resizeObject IN h_dynlookup ( 1.00 , 61.00 ) NO-ERROR.

       RUN constructObject (
             INPUT  'adm2/dynlookup.w':U ,
             INPUT  FRAME frMain:HANDLE ,
             INPUT  'DisplayedFieldryc_smartobject.object_filenameKeyFieldryc_smartobject.smartobject_objFieldLabelMaintenance Object FilenameFieldTooltipEnter Maintenance Object Filename or Press F4 for Object LookupKeyFormat->>>>>>>>>>>>>>>>>9.999999999KeyDatatypedecimalDisplayFormatX(70)DisplayDatatypecharacterBaseQueryStringFOR EACH ryc_smartobject NO-LOCK, 
                     FIRST gsc_object_type WHERE gsc_object_type.object_type_obj = ryc_smartobject.object_type_obj NO-LOCK,
                     FIRST gsc_product_module WHERE gsc_product_module.product_module_obj = ryc_smartobject.product_module_obj NO-LOCK, 
                     FIRST gsc_product WHERE gsc_product.product_obj = gsc_product_module.product_obj 
                     BY gsc_product_module.product_module_code By gsc_object_type.object_type_code BY ryc_smartobject.object_filenameQueryTablesryc_smartobject,gsc_object_type,gsc_product_module,gsc_productBrowseFieldsgsc_product_module.product_module_code,gsc_object_type.object_type_code,ryc_smartobject.object_filename,ryc_smartobject.object_descriptionBrowseFieldDataTypescharacter,character,character,characterBrowseFieldFormatsX(10),X(15),X(70),X(35)RowsToBatch200BrowseTitleLookup ObjectsViewerLinkedFieldsLinkedFieldDataTypesLinkedFieldFormatsViewerLinkedWidgetsColumnLabelsColumnFormatSDFFileNameSDFTemplateLookupImageadeicon/select.bmpParentFieldfiShowRepositoryObjectsParentFilterQuery(IF ~'&1~' = ~'no~' THEN NOT gsc_product.product_code BEGINS ~'090~' ELSE TRUE)MaintenanceObjectMaintenanceSDOCustomSuperProcFieldNamemaintenance_object_objDisplayFieldyesEnableFieldyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_dynlookup-2 ).
       RUN repositionObject IN h_dynlookup-2 ( 4.14 , 33.20 ) NO-ERROR.
       RUN resizeObject IN h_dynlookup-2 ( 1.00 , 61.00 ) NO-ERROR.

       RUN constructObject (
             INPUT  'adm2/dyncombo.w':U ,
             INPUT  FRAME frMain:HANDLE ,
             INPUT  'DisplayedFieldgsc_logical_service.logical_service_description,gsc_logical_service.logical_service_codeKeyFieldgsc_logical_service.logical_service_objFieldLabelDefault Logical ServiceFieldTooltipSelect a logical service from the listKeyFormat->>>>>>>>>>>>>>>>>9.999999999KeyDatatypedecimalDisplayFormatX(256)DisplayDatatypeCHARACTERBaseQueryStringFOR EACH gsc_logical_service NO-LOCK BY gsc_logical_service.logical_service_codeQueryTablesgsc_logical_serviceSDFFileNameSDFTemplateParentFieldservice_type_obj,service_type_objParentFilterQuery(IF DECIMAL(~'&1~') > 0 THEN gsc_logical_service.service_type_obj = DECIMAL(~'&1~') ELSE TRUE)DescSubstitute&1 (&2)CurrentKeyValueComboDelimiterListItemPairsCurrentDescValueInnerLines5ComboFlagNFlagValue0BuildSequence1SecurednoCustomSuperProcFieldNamedefault_logical_service_objDisplayFieldyesEnableFieldyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_dyncombo ).
       RUN repositionObject IN h_dyncombo ( 5.19 , 33.20 ) NO-ERROR.
       RUN resizeObject IN h_dyncombo ( 1.05 , 61.00 ) NO-ERROR.

       /* Adjust the tab order of the smart objects. */
       RUN adjustTabOrder ( h_dynlookup ,
             RowObject.service_type_description:HANDLE IN FRAME frMain , 'AFTER':U ).
       RUN adjustTabOrder ( h_dynlookup-2 ,
             h_dynlookup , 'AFTER':U ).
       RUN adjustTabOrder ( h_dyncombo ,
             h_dynlookup-2 , 'AFTER':U ).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields vTableWin 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER pcColValues AS CHARACTER NO-UNDO.

  RUN SUPER( INPUT pcColValues).

  /* Gather combo query, need to do this from displayFields because the
     combo query is filtered on service type and this will change for 
     every record. */
  PUBLISH 'getFilteredComboQuery':U (INPUT-OUTPUT TABLE ttComboData).

  /* Build combo list item pairs */
  IF CAN-FIND(FIRST ttComboData) THEN
    RUN af/app/afcobuildp.p ON gshAstraAppServer (INPUT-OUTPUT TABLE ttComboData).

  /* Populate combo */
  PUBLISH 'buildCombo':U (INPUT TABLE ttComboData).

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
DEFINE VARIABLE cNewRecord  AS CHARACTER    NO-UNDO.

  RUN SUPER.

  /* The servcie type code should only be enabled on add/copy */
  DO WITH FRAME {&FRAME-NAME}:
    cNewRecord = DYNAMIC-FUNCTION('getNewRecord':U).
    IF cNewRecord = 'No':U THEN RowObject.service_type_code:SENSITIVE = FALSE.
    ELSE RowObject.service_type_code:SENSITIVE = TRUE.
  END.  /* do with frame */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject vTableWin 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE cShowRepositoryData          AS CHARACTER            NO-UNDO.
  DEFINE VARIABLE rRowid                      AS ROWID                NO-UNDO.

  /* Determine whether the user wants to display repository data. */
  ASSIGN rRowid = ?.
  RUN getProfileData IN gshProfileManager ( INPUT        "General":U,
                                            INPUT        "DispRepos":U,
                                            INPUT        "DispRepos":U,
                                            INPUT        NO,
                                            INPUT-OUTPUT rRowid,
                                                  OUTPUT cShowRepositoryData).
  ASSIGN fiShowRepositoryObjects:SCREEN-VALUE IN FRAME {&FRAME-NAME} = cShowRepositoryData.

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */

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
  RUN "af\obj2\gsclsdcsfv.w *RTB-SmObj* ".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
