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
* Contributors: MIP Holdings (Pty) Ltd ("MIP")                       *
*               PSC                                                  *
*                                                                    *
*********************************************************************/

TRIGGER PROCEDURE FOR WRITE OF gsm_tagged_data OLD BUFFER o_gsm_tagged_data.

/* Created automatically using ERwin ICF Trigger template db/af/erw/afercustrg.i
   Do not change manually. Customisations to triggers should be placed in separate
   include files pulled into the trigger. ICF auto generates write trigger custom
   include files. Delete or create customisation include files need to be created
   manually. Be sure to put the hook in ERwin directly so as not to have you changes
   overwritten.
   User defined Macro (UDP) Summary (case sensitive)
   gsm_tagged_data           Expands to full table name, e.g. gsm_user
   %TableFLA            Expands to table unique code, e.g. gsmus
   %TableObj            If blank or not defined expands to table_obj with no prefix (framework standard)
                        If defined, uses this field as the object field
                        If set to "none" then indicates table does not have an object field
   XYZ                  Do not define so we can compare against an empty string

   See docs for explanation of replication macros 
*/   

&SCOPED-DEFINE TRIGGER_TABLE gsm_tagged_data
&SCOPED-DEFINE TRIGGER_FLA gsmtd
&SCOPED-DEFINE TRIGGER_OBJ tagged_data_obj


DEFINE BUFFER lb_table FOR gsm_tagged_data.      /* Used for recursive relationships */
DEFINE BUFFER lb1_table FOR gsm_tagged_data.     /* Used for lock upgrades */



/* Standard top of WRITE trigger code */
{af/sup/aftrigtopw.i}

/* properform fields if enabled for table */
IF CAN-FIND(FIRST gsc_entity_mnemonic
            WHERE gsc_entity_mnemonic.entity_mnemonic = 'gsmtd':U
              AND gsc_entity_mnemonic.auto_properform_strings = YES) THEN
  RUN af/app/afpropfrmp.p (INPUT BUFFER gsm_tagged_data:HANDLE).
  



/* Generated by ICF ERwin Template */
/* gsc_entity_mnemonic has gsm_tagged_data ON CHILD UPDATE RESTRICT */
IF NEW gsm_tagged_data OR  gsm_tagged_data.owning_entity_mnemonic <> o_gsm_tagged_data.owning_entity_mnemonic  THEN
  DO:
    IF NOT(CAN-FIND(FIRST gsc_entity_mnemonic WHERE
        gsm_tagged_data.owning_entity_mnemonic = gsc_entity_mnemonic.entity_mnemonic)) THEN
              DO:
                /* Cannot update child because parent does not exist ! */
                ASSIGN lv-error = YES lv-errgrp = "AF ":U lv-errnum = 103 lv-include = "gsm_tagged_data|gsc_entity_mnemonic":U.
                RUN error-message (lv-errgrp, lv-errnum, lv-include).
              END.
    
    
  END.

/* Generated by ICF ERwin Template */
/* gsc_data_tag tags gsm_tagged_data ON CHILD UPDATE RESTRICT */
IF NEW gsm_tagged_data OR  gsm_tagged_data.data_tag_obj <> o_gsm_tagged_data.data_tag_obj  THEN
  DO:
    IF NOT(CAN-FIND(FIRST gsc_data_tag WHERE
        gsm_tagged_data.data_tag_obj = gsc_data_tag.data_tag_obj)) THEN
              DO:
                /* Cannot update child because parent does not exist ! */
                ASSIGN lv-error = YES lv-errgrp = "AF ":U lv-errnum = 103 lv-include = "gsm_tagged_data|gsc_data_tag":U.
                RUN error-message (lv-errgrp, lv-errnum, lv-include).
              END.
    
    
  END.








IF NOT NEW gsm_tagged_data AND gsm_tagged_data.{&TRIGGER_OBJ} <> o_gsm_tagged_data.{&TRIGGER_OBJ} THEN
    DO:
        ASSIGN lv-error = YES lv-errgrp = "AF":U lv-errnum = 13 lv-include = "table object number":U.
        RUN error-message (lv-errgrp,lv-errnum,lv-include).
    END.

/* Customisations to WRITE trigger */
{icf/trg/gsmtdtrigw.i}



/* Update Audit Log */
IF CAN-FIND(FIRST gsc_entity_mnemonic
            WHERE gsc_entity_mnemonic.entity_mnemonic = 'gsmtd':U
              AND gsc_entity_mnemonic.auditing_enabled = YES) THEN
  RUN af/app/afauditlgp.p (INPUT "WRITE":U, INPUT "gsmtd":U, INPUT BUFFER gsm_tagged_data:HANDLE, INPUT BUFFER o_gsm_tagged_data:HANDLE).

/* Standard bottom of WRITE trigger code */
{af/sup/aftrigendw.i}


