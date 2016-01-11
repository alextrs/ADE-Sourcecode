&ANALYZE-SUSPEND _VERSION-NUMBER AB_v9r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          icfdb            PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
{adecomm/appserv.i}
DEFINE VARIABLE h_Astra                    AS HANDLE          NO-UNDO.
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS dTables 
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

  File:  

  Description: from DATA.W - Template For SmartData objects in the ADM

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Modified:     February 24, 1999
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDataObject
&Scoped-define DB-AWARE yes

&Scoped-define ADM-SUPPORTED-LINKS Data-Source,Data-Target,Navigation-Target,Update-Target,Commit-Target,Filter-Target


/* Db-Required definitions. */
&IF DEFINED(DB-REQUIRED) = 0 &THEN
    &GLOBAL-DEFINE DB-REQUIRED TRUE
&ENDIF
&GLOBAL-DEFINE DB-REQUIRED-START   &IF {&DB-REQUIRED} &THEN
&GLOBAL-DEFINE DB-REQUIRED-END     &ENDIF


&Scoped-define QUERY-NAME Query-Main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ryc_object_instance ryc_smartobject ~
gsc_object_type gsc_product_module gsc_product ryc_page_object ryc_page

/* Definitions for QUERY Query-Main                                     */
&Scoped-Define ENABLED-FIELDS  container_filename container_smartobject_obj layout_position~
 smartobject_obj system_owned layout_obj object_type_obj product_module_obj~
 sdo_smartobject_obj smartobject_obj-2 object_type_obj-2~
 physical_smartobject_obj product_module_obj-2 security_smartobject_obj~
 object_type_obj-3 product_module_obj-3 product_obj product_obj-2~
 container_smartobject_obj-2 object_instance_obj-2 page_obj page_object_obj~
 container_smartobject_obj-3 layout_obj-2 page_obj-2
&Scoped-define ENABLED-FIELDS-IN-ryc_object_instance ~
container_smartobject_obj layout_position smartobject_obj system_owned 
&Scoped-define ENABLED-FIELDS-IN-ryc_smartobject layout_obj object_type_obj ~
product_module_obj sdo_smartobject_obj smartobject_obj-2 object_type_obj-2 ~
physical_smartobject_obj product_module_obj-2 security_smartobject_obj 
&Scoped-define ENABLED-FIELDS-IN-gsc_object_type object_type_obj-3 
&Scoped-define ENABLED-FIELDS-IN-gsc_product_module product_module_obj-3 ~
product_obj 
&Scoped-define ENABLED-FIELDS-IN-gsc_product product_obj-2 
&Scoped-define ENABLED-FIELDS-IN-ryc_page_object ~
container_smartobject_obj-2 object_instance_obj-2 page_obj page_object_obj 
&Scoped-define ENABLED-FIELDS-IN-ryc_page container_smartobject_obj-3 ~
layout_obj-2 page_obj-2 
&Scoped-Define DATA-FIELDS  container_filename container_smartobject_obj layout_position~
 object_instance_obj smartobject_obj system_owned object_filename~
 object_type_code product_module_code product_code layout_obj~
 object_type_obj product_module_obj sdo_smartobject_obj~
 shutdown_message_text smartobject_obj-2 static_object system_owned-2~
 template_smartobject container_object disabled generic_object~
 object_description object_filename-2 object_path object_type_obj-2~
 physical_smartobject_obj product_module_obj-2 required_db_list~
 runnable_from_menu run_persistent run_when security_smartobject_obj~
 disabled-2 layout_supported object_type_description object_type_obj-3~
 db_connection_pf_file number_of_users product_module_description~
 product_module_installed product_module_obj-3 product_obj~
 db_connection_pf_file-2 number_of_users-2 product_description~
 product_installed product_obj-2 supplier_organisation_obj~
 container_smartobject_obj-2 object_instance_obj-2 page_obj page_object_obj~
 page_object_sequence container_smartobject_obj-3 enable_on_create~
 enable_on_modify enable_on_view layout_obj-2 page_label page_obj-2~
 page_sequence security_token
&Scoped-define DATA-FIELDS-IN-ryc_object_instance container_smartobject_obj ~
layout_position object_instance_obj smartobject_obj system_owned 
&Scoped-define DATA-FIELDS-IN-ryc_smartobject object_filename layout_obj ~
object_type_obj product_module_obj sdo_smartobject_obj ~
shutdown_message_text smartobject_obj-2 static_object system_owned-2 ~
template_smartobject container_object disabled generic_object ~
object_description object_filename-2 object_path object_type_obj-2 ~
physical_smartobject_obj product_module_obj-2 required_db_list ~
runnable_from_menu run_persistent run_when security_smartobject_obj 
&Scoped-define DATA-FIELDS-IN-gsc_object_type object_type_code disabled-2 ~
layout_supported object_type_description object_type_obj-3 
&Scoped-define DATA-FIELDS-IN-gsc_product_module product_module_code ~
db_connection_pf_file number_of_users product_module_description ~
product_module_installed product_module_obj-3 product_obj 
&Scoped-define DATA-FIELDS-IN-gsc_product product_code ~
db_connection_pf_file-2 number_of_users-2 product_description ~
product_installed product_obj-2 supplier_organisation_obj 
&Scoped-define DATA-FIELDS-IN-ryc_page_object container_smartobject_obj-2 ~
object_instance_obj-2 page_obj page_object_obj page_object_sequence 
&Scoped-define DATA-FIELDS-IN-ryc_page container_smartobject_obj-3 ~
enable_on_create enable_on_modify enable_on_view layout_obj-2 page_label ~
page_obj-2 page_sequence security_token 
&Scoped-Define MANDATORY-FIELDS 
&Scoped-Define APPLICATION-SERVICE 
&Scoped-Define ASSIGN-LIST   rowObject.smartobject_obj-2 = ryc_smartobject.smartobject_obj~
  rowObject.system_owned-2 = ryc_smartobject.system_owned~
  rowObject.object_filename-2 = ryc_smartobject.object_filename~
  rowObject.object_type_obj-2 = ryc_smartobject.object_type_obj~
  rowObject.product_module_obj-2 = ryc_smartobject.product_module_obj~
  rowObject.disabled-2 = gsc_object_type.disabled~
  rowObject.object_type_obj-3 = gsc_object_type.object_type_obj~
  rowObject.product_module_obj-3 = gsc_product_module.product_module_obj~
  rowObject.db_connection_pf_file-2 = gsc_product.db_connection_pf_file~
  rowObject.number_of_users-2 = gsc_product.number_of_users~
  rowObject.product_obj-2 = gsc_product.product_obj~
  rowObject.container_smartobject_obj-2 = ryc_page_object.container_smartobject_obj~
  rowObject.object_instance_obj-2 = ryc_page_object.object_instance_obj~
  rowObject.container_smartobject_obj-3 = ryc_page.container_smartobject_obj~
  rowObject.layout_obj-2 = ryc_page.layout_obj~
  rowObject.page_obj-2 = ryc_page.page_obj
&Scoped-Define DATA-FIELD-DEFS "ry/obj/rycoifullo.i"
&Scoped-define QUERY-STRING-Query-Main FOR EACH ryc_object_instance NO-LOCK, ~
      FIRST ryc_smartobject WHERE ryc_smartobject.smartobject_obj = ryc_object_instance.smartobject_obj NO-LOCK, ~
      FIRST gsc_object_type WHERE gsc_object_type.object_type_obj = ryc_smartobject.object_type_obj NO-LOCK, ~
      FIRST gsc_product_module WHERE gsc_product_module.product_module_obj = ryc_smartobject.product_module_obj NO-LOCK, ~
      FIRST gsc_product WHERE gsc_product.product_obj = gsc_product_module.product_obj NO-LOCK, ~
      FIRST ryc_page_object WHERE ryc_page_object.container_smartobject_obj = ryc_object_instance.container_smartobject_obj ~
  AND ryc_page_object.object_instance_obj = ryc_object_instance.object_instance_obj OUTER-JOIN NO-LOCK, ~
      FIRST ryc_page WHERE ryc_page.container_smartobject_obj = ryc_page_object.container_smartobject_obj ~
  AND ryc_page.page_obj = ryc_page_object.page_obj OUTER-JOIN NO-LOCK ~
    ~{&SORTBY-PHRASE} INDEXED-REPOSITION
{&DB-REQUIRED-START}
&Scoped-define OPEN-QUERY-Query-Main OPEN QUERY Query-Main FOR EACH ryc_object_instance NO-LOCK, ~
      FIRST ryc_smartobject WHERE ryc_smartobject.smartobject_obj = ryc_object_instance.smartobject_obj NO-LOCK, ~
      FIRST gsc_object_type WHERE gsc_object_type.object_type_obj = ryc_smartobject.object_type_obj NO-LOCK, ~
      FIRST gsc_product_module WHERE gsc_product_module.product_module_obj = ryc_smartobject.product_module_obj NO-LOCK, ~
      FIRST gsc_product WHERE gsc_product.product_obj = gsc_product_module.product_obj NO-LOCK, ~
      FIRST ryc_page_object WHERE ryc_page_object.container_smartobject_obj = ryc_object_instance.container_smartobject_obj ~
  AND ryc_page_object.object_instance_obj = ryc_object_instance.object_instance_obj OUTER-JOIN NO-LOCK, ~
      FIRST ryc_page WHERE ryc_page.container_smartobject_obj = ryc_page_object.container_smartobject_obj ~
  AND ryc_page.page_obj = ryc_page_object.page_obj OUTER-JOIN NO-LOCK ~
    ~{&SORTBY-PHRASE} INDEXED-REPOSITION.
{&DB-REQUIRED-END}
&Scoped-define TABLES-IN-QUERY-Query-Main ryc_object_instance ~
ryc_smartobject gsc_object_type gsc_product_module gsc_product ~
ryc_page_object ryc_page
&Scoped-define FIRST-TABLE-IN-QUERY-Query-Main ryc_object_instance
&Scoped-define SECOND-TABLE-IN-QUERY-Query-Main ryc_smartobject
&Scoped-define THIRD-TABLE-IN-QUERY-Query-Main gsc_object_type
&Scoped-define FOURTH-TABLE-IN-QUERY-Query-Main gsc_product_module
&Scoped-define FIFTH-TABLE-IN-QUERY-Query-Main gsc_product
&Scoped-define SIXTH-TABLE-IN-QUERY-Query-Main ryc_page_object
&Scoped-define SEVENTH-TABLE-IN-QUERY-Query-Main ryc_page


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

{&DB-REQUIRED-START}

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getContainerFileName dTables  _DB-REQUIRED
FUNCTION getContainerFileName RETURNS CHARACTER
  ( INPUT pdContainerObj AS DECIMAL )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

{&DB-REQUIRED-END}


/* ***********************  Control Definitions  ********************** */

{&DB-REQUIRED-START}

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Query-Main FOR 
      ryc_object_instance, 
      ryc_smartobject, 
      gsc_object_type, 
      gsc_product_module, 
      gsc_product, 
      ryc_page_object, 
      ryc_page SCROLLING.
&ANALYZE-RESUME
{&DB-REQUIRED-END}


/* ************************  Frame Definitions  *********************** */


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDataObject
   Allow: Query
   Frames: 0
   Add Fields to: Neither
   Other Settings: PERSISTENT-ONLY COMPILE APPSERVER DB-AWARE
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
  CREATE WINDOW dTables ASSIGN
         HEIGHT             = 1.62
         WIDTH              = 57.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB dTables 
/* ************************* Included-Libraries *********************** */

{src/adm2/data.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW dTables
  VISIBLE,,RUN-PERSISTENT                                               */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK QUERY Query-Main
/* Query rebuild information for SmartDataObject Query-Main
     _TblList          = "icfdb.ryc_object_instance,icfdb.ryc_smartobject WHERE icfdb.ryc_object_instance  ...,icfdb.gsc_object_type WHERE icfdb.ryc_smartobject  ...,icfdb.gsc_product_module WHERE icfdb.ryc_smartobject  ...,icfdb.gsc_product WHERE icfdb.gsc_product_module  ...,icfdb.ryc_page_object WHERE icfdb.ryc_object_instance   ...,icfdb.ryc_page WHERE icfdb.ryc_page_object  ..."
     _Options          = "NO-LOCK INDEXED-REPOSITION SORTBY-PHRASE"
     _TblOptList       = ", FIRST, FIRST, FIRST, FIRST, FIRST OUTER, FIRST OUTER"
     _JoinCode[2]      = "ryc_smartobject.smartobject_obj = ryc_object_instance.smartobject_obj"
     _JoinCode[3]      = "gsc_object_type.object_type_obj = ryc_smartobject.object_type_obj"
     _JoinCode[4]      = "gsc_product_module.product_module_obj = ryc_smartobject.product_module_obj"
     _JoinCode[5]      = "gsc_product.product_obj = gsc_product_module.product_obj"
     _JoinCode[6]      = "icfdb.ryc_page_object.container_smartobject_obj = icfdb.ryc_object_instance.container_smartobject_obj
  AND icfdb.ryc_page_object.object_instance_obj = icfdb.ryc_object_instance.object_instance_obj"
     _JoinCode[7]      = "icfdb.ryc_page.container_smartobject_obj = icfdb.ryc_page_object.container_smartobject_obj
  AND icfdb.ryc_page.page_obj = icfdb.ryc_page_object.page_obj"
     _FldNameList[1]   > "_<CALC>"
"getContainerFileName(RowObject.container_smartobject_obj)" "container_filename" "Container Filename" "x(20)" "character" ? ? ? ? ? ? yes ? no 20 no
     _FldNameList[2]   > icfdb.ryc_object_instance.container_smartobject_obj
"container_smartobject_obj" "container_smartobject_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 25 yes
     _FldNameList[3]   > icfdb.ryc_object_instance.layout_position
"layout_position" "layout_position" ? ? "character" ? ? ? ? ? ? yes ? no 15 yes
     _FldNameList[4]   > icfdb.ryc_object_instance.object_instance_obj
"object_instance_obj" "object_instance_obj" ? ? "decimal" ? ? ? ? ? ? no ? no 21.6 yes
     _FldNameList[5]   > icfdb.ryc_object_instance.smartobject_obj
"smartobject_obj" "smartobject_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 21.6 yes
     _FldNameList[6]   > icfdb.ryc_object_instance.system_owned
"system_owned" "system_owned" ? ? "logical" ? ? ? ? ? ? yes ? no 14.2 yes
     _FldNameList[7]   > icfdb.ryc_smartobject.object_filename
"object_filename" "object_filename" "Instance Filename" ? "character" ? ? ? ? ? ? no ? no 70 yes
     _FldNameList[8]   > icfdb.gsc_object_type.object_type_code
"object_type_code" "object_type_code" ? ? "character" ? ? ? ? ? ? no ? no 17.2 yes
     _FldNameList[9]   > icfdb.gsc_product_module.product_module_code
"product_module_code" "product_module_code" ? ? "character" ? ? ? ? ? ? no ? no 20.6 yes
     _FldNameList[10]   > icfdb.gsc_product.product_code
"product_code" "product_code" ? ? "character" ? ? ? ? ? ? no ? no 13 yes
     _FldNameList[11]   > icfdb.ryc_smartobject.layout_obj
"layout_obj" "layout_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[12]   > icfdb.ryc_smartobject.object_type_obj
"object_type_obj" "object_type_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[13]   > icfdb.ryc_smartobject.product_module_obj
"product_module_obj" "product_module_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[14]   > icfdb.ryc_smartobject.sdo_smartobject_obj
"sdo_smartobject_obj" "sdo_smartobject_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[15]   > icfdb.ryc_smartobject.shutdown_message_text
"shutdown_message_text" "shutdown_message_text" ? ? "character" ? ? ? ? ? ? no ? no 70 yes
     _FldNameList[16]   > icfdb.ryc_smartobject.smartobject_obj
"smartobject_obj" "smartobject_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[17]   > icfdb.ryc_smartobject.static_object
"static_object" "static_object" ? ? "logical" ? ? ? ? ? ? no ? no 12.2 yes
     _FldNameList[18]   > icfdb.ryc_smartobject.system_owned
"system_owned" "system_owned-2" ? ? "logical" ? ? ? ? ? ? no ? no 14.2 yes
     _FldNameList[19]   > icfdb.ryc_smartobject.template_smartobject
"template_smartobject" "template_smartobject" ? ? "logical" ? ? ? ? ? ? no ? no 21 yes
     _FldNameList[20]   > icfdb.ryc_smartobject.container_object
"container_object" "container_object" ? ? "logical" ? ? ? ? ? ? no ? no 15.8 yes
     _FldNameList[21]   > icfdb.ryc_smartobject.disabled
"disabled" "disabled" ? ? "logical" ? ? ? ? ? ? no ? no 8.2 yes
     _FldNameList[22]   > icfdb.ryc_smartobject.generic_object
"generic_object" "generic_object" ? ? "logical" ? ? ? ? ? ? no ? no 14.2 yes
     _FldNameList[23]   > icfdb.ryc_smartobject.object_description
"object_description" "object_description" ? ? "character" ? ? ? ? ? ? no ? no 35 yes
     _FldNameList[24]   > icfdb.ryc_smartobject.object_filename
"object_filename" "object_filename-2" ? ? "character" ? ? ? ? ? ? no ? no 35 yes
     _FldNameList[25]   > icfdb.ryc_smartobject.object_path
"object_path" "object_path" ? ? "character" ? ? ? ? ? ? no ? no 70 yes
     _FldNameList[26]   > icfdb.ryc_smartobject.object_type_obj
"object_type_obj" "object_type_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[27]   > icfdb.ryc_smartobject.physical_smartobject_obj
"physical_smartobject_obj" "physical_smartobject_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[28]   > icfdb.ryc_smartobject.product_module_obj
"product_module_obj" "product_module_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[29]   > icfdb.ryc_smartobject.required_db_list
"required_db_list" "required_db_list" ? ? "character" ? ? ? ? ? ? no ? no 35 yes
     _FldNameList[30]   > icfdb.ryc_smartobject.runnable_from_menu
"runnable_from_menu" "runnable_from_menu" ? ? "logical" ? ? ? ? ? ? no ? no 20.4 yes
     _FldNameList[31]   > icfdb.ryc_smartobject.run_persistent
"run_persistent" "run_persistent" ? ? "logical" ? ? ? ? ? ? no ? no 13.8 yes
     _FldNameList[32]   > icfdb.ryc_smartobject.run_when
"run_when" "run_when" ? ? "character" ? ? ? ? ? ? no ? no 10.4 yes
     _FldNameList[33]   > icfdb.ryc_smartobject.security_smartobject_obj
"security_smartobject_obj" "security_smartobject_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[34]   > icfdb.gsc_object_type.disabled
"disabled" "disabled-2" ? ? "logical" ? ? ? ? ? ? no ? no 8.2 yes
     _FldNameList[35]   > icfdb.gsc_object_type.layout_supported
"layout_supported" "layout_supported" ? ? "logical" ? ? ? ? ? ? no ? no 16.8 yes
     _FldNameList[36]   > icfdb.gsc_object_type.object_type_description
"object_type_description" "object_type_description" ? ? "character" ? ? ? ? ? ? no ? no 35 yes
     _FldNameList[37]   > icfdb.gsc_object_type.object_type_obj
"object_type_obj" "object_type_obj-3" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[38]   > icfdb.gsc_product_module.db_connection_pf_file
"db_connection_pf_file" "db_connection_pf_file" ? ? "character" ? ? ? ? ? ? no ? no 70 yes
     _FldNameList[39]   > icfdb.gsc_product_module.number_of_users
"number_of_users" "number_of_users" ? ? "integer" ? ? ? ? ? ? no ? no 15.8 yes
     _FldNameList[40]   > icfdb.gsc_product_module.product_module_description
"product_module_description" "product_module_description" ? ? "character" ? ? ? ? ? ? no ? no 35 yes
     _FldNameList[41]   > icfdb.gsc_product_module.product_module_installed
"product_module_installed" "product_module_installed" ? ? "logical" ? ? ? ? ? ? no ? no 23.4 yes
     _FldNameList[42]   > icfdb.gsc_product_module.product_module_obj
"product_module_obj" "product_module_obj-3" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[43]   > icfdb.gsc_product_module.product_obj
"product_obj" "product_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[44]   > icfdb.gsc_product.db_connection_pf_file
"db_connection_pf_file" "db_connection_pf_file-2" ? ? "character" ? ? ? ? ? ? no ? no 70 yes
     _FldNameList[45]   > icfdb.gsc_product.number_of_users
"number_of_users" "number_of_users-2" ? ? "integer" ? ? ? ? ? ? no ? no 15.8 yes
     _FldNameList[46]   > icfdb.gsc_product.product_description
"product_description" "product_description" ? ? "character" ? ? ? ? ? ? no ? no 35 yes
     _FldNameList[47]   > icfdb.gsc_product.product_installed
"product_installed" "product_installed" ? ? "logical" ? ? ? ? ? ? no ? no 15.8 yes
     _FldNameList[48]   > icfdb.gsc_product.product_obj
"product_obj" "product_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[49]   > icfdb.gsc_product.supplier_organisation_obj
"supplier_organisation_obj" "supplier_organisation_obj" ? ? "decimal" ? ? ? ? ? ? no ? no 29.4 yes
     _FldNameList[50]   > icfdb.ryc_page_object.container_smartobject_obj
"container_smartobject_obj" "container_smartobject_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[51]   > icfdb.ryc_page_object.object_instance_obj
"object_instance_obj" "object_instance_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[52]   > icfdb.ryc_page_object.page_obj
"page_obj" "page_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[53]   > icfdb.ryc_page_object.page_object_obj
"page_object_obj" "page_object_obj" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[54]   > icfdb.ryc_page_object.page_object_sequence
"page_object_sequence" "page_object_sequence" ? ? "integer" ? ? ? ? ? ? no ? no 16.8 yes
     _FldNameList[55]   > icfdb.ryc_page.container_smartobject_obj
"container_smartobject_obj" "container_smartobject_obj-3" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[56]   > icfdb.ryc_page.enable_on_create
"enable_on_create" "enable_on_create" ? ? "logical" ? ? ? ? ? ? no ? no 16.8 yes
     _FldNameList[57]   > icfdb.ryc_page.enable_on_modify
"enable_on_modify" "enable_on_modify" ? ? "logical" ? ? ? ? ? ? no ? no 16.8 yes
     _FldNameList[58]   > icfdb.ryc_page.enable_on_view
"enable_on_view" "enable_on_view" ? ? "logical" ? ? ? ? ? ? no ? no 15.2 yes
     _FldNameList[59]   > icfdb.ryc_page.layout_obj
"layout_obj" "layout_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[60]   > icfdb.ryc_page.page_label
"page_label" "page_label" ? ? "character" ? ? ? ? ? ? no ? no 28 yes
     _FldNameList[61]   > icfdb.ryc_page.page_obj
"page_obj" "page_obj-2" ? ? "decimal" ? ? ? ? ? ? yes ? no 29.4 yes
     _FldNameList[62]   > icfdb.ryc_page.page_sequence
"page_sequence" "page_sequence" ? ? "integer" ? ? ? ? ? ? no ? no 10 yes
     _FldNameList[63]   > icfdb.ryc_page.security_token
"security_token" "security_token" ? ? "character" ? ? ? ? ? ? no ? no 28 yes
     _Design-Parent    is WINDOW dTables @ ( 1.14 , 2.6 )
*/  /* QUERY Query-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK dTables 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN initializeObject.
  &ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

{&DB-REQUIRED-START}

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DATA.CALCULATE dTables  DATA.CALCULATE _DB-REQUIRED
PROCEDURE DATA.CALCULATE :
/*------------------------------------------------------------------------------
  Purpose:     Calculate all the Calculated Expressions found in the
               SmartDataObject.
  Parameters:  <none>
------------------------------------------------------------------------------*/
      ASSIGN 
         rowObject.container_filename = (getContainerFileName(RowObject.container_smartobject_obj))
      .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

{&DB-REQUIRED-END}

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI dTables  _DEFAULT-DISABLE
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
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject dTables 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE cForeignfields  AS CHARACTER    NO-UNDO.

    /* Code placed here will execute PRIOR to standard behavior. */

    {set ForeignFields 'ryc_object_instance.container_smartobject_obj,smartobject_obj'}.

    RUN SUPER.

    {set ForeignFields 'ryc_object_instance.container_smartobject_obj,smartobject_obj'}.
    /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

{&DB-REQUIRED-START}

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getContainerFileName dTables  _DB-REQUIRED
FUNCTION getContainerFileName RETURNS CHARACTER
  ( INPUT pdContainerObj AS DECIMAL ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE BUFFER b_ryc_object_instance FOR ryc_object_instance.
  DEFINE BUFFER b_ryc_smartobject     FOR ryc_smartobject.

  IF AVAIL rowObject AND pdContainerObj NE 0 THEN
      FIND FIRST b_ryc_smartobject NO-LOCK
           WHERE b_ryc_smartobject.smartobject_obj = pdContainerObj
           NO-ERROR.

  RETURN (IF AVAILABLE b_ryc_smartobject THEN b_ryc_smartobject.OBJECT_filename ELSE "").

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

{&DB-REQUIRED-END}
