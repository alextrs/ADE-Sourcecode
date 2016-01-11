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

TRIGGER PROCEDURE FOR DELETE OF gsc_delivery_method .

/* Created automatically using ERwin ICF Trigger template db/af/erw/afercustrg.i
   Do not change manually. Customisations to triggers should be placed in separate
   include files pulled into the trigger. ICF auto generates write trigger custom
   include files. Delete or create customisation include files need to be created
   manually. Be sure to put the hook in ERwin directly so as not to have you changes
   overwritten.
   User defined Macro (UDP) Summary (case sensitive)
   gsc_delivery_method           Expands to full table name, e.g. gsm_user
   %TableFLA            Expands to table unique code, e.g. gsmus
   %TableObj            If blank or not defined expands to table_obj with no prefix (framework standard)
                        If defined, uses this field as the object field
                        If set to "none" then indicates table does not have an object field
   XYZ                  Do not define so we can compare against an empty string

   See docs for explanation of replication macros 
*/   

&SCOPED-DEFINE TRIGGER_TABLE gsc_delivery_method
&SCOPED-DEFINE TRIGGER_FLA gscdm
&SCOPED-DEFINE TRIGGER_OBJ delivery_method_obj


DEFINE BUFFER lb_table FOR gsc_delivery_method.      /* Used for recursive relationships */
DEFINE BUFFER lb1_table FOR gsc_delivery_method.     /* Used for lock upgrades */

DEFINE BUFFER o_gsc_delivery_method FOR gsc_delivery_method.

/* Standard top of DELETE trigger code */
{af/sup/aftrigtopd.i}

  




/* Generated by ICF ERwin Template */
/* gsc_delivery_method is the default for gsc_document_type ON PARENT DELETE RESTRICT */
IF CAN-FIND(FIRST gsc_document_type WHERE
    gsc_document_type.default_delivery_method = gsc_delivery_method.delivery_method_obj) THEN
    DO:
      /* Cannot delete parent because child exists! */
      ASSIGN lv-error = YES lv-errgrp = "AF ":U lv-errnum = 101 lv-include = "gsc_delivery_method|gsc_document_type":U.
      RUN error-message (lv-errgrp, lv-errnum, lv-include).
    END.





/* Generic comments deletion */
DEFINE BUFFER lbx_gsm_comment FOR gsm_comment.
DEFINE BUFFER lby_gsm_comment FOR gsm_comment.
IF CAN-FIND(FIRST lbx_gsm_comment 
            WHERE lbx_gsm_comment.owning_obj = gsc_delivery_method.{&TRIGGER_OBJ}) THEN
    FOR EACH lbx_gsm_comment NO-LOCK
       WHERE lbx_gsm_comment.owning_obj = gsc_delivery_method.{&TRIGGER_OBJ}
       ON STOP UNDO, RETURN ERROR "AF^104^gscdmtrigd.p^delete gsm_comment":U:
        FIND FIRST lby_gsm_comment EXCLUSIVE-LOCK
             WHERE ROWID(lby_gsm_comment) = ROWID(lbx_gsm_comment)
             NO-ERROR.
        IF AVAILABLE lby_gsm_comment THEN
          DO:
            {af/sup/afvalidtrg.i &action = "DELETE" &table = "lby_gsm_comment"}
          END.
    END.
/* Generic security allocation deletion */
DEFINE BUFFER lbx_gsm_user_allocation FOR gsm_user_allocation.
DEFINE BUFFER lby_gsm_user_allocation FOR gsm_user_allocation.
IF CAN-FIND(FIRST lbx_gsm_user_allocation 
            WHERE lbx_gsm_user_allocation.owning_obj = gsc_delivery_method.{&TRIGGER_OBJ}) THEN
    FOR EACH lbx_gsm_user_allocation NO-LOCK
       WHERE lbx_gsm_user_allocation.owning_obj = gsc_delivery_method.{&TRIGGER_OBJ}
       ON STOP UNDO, RETURN ERROR "AF^104^gscdmtrigd.p^delete gsm_user_allocation":U:
        FIND FIRST lby_gsm_user_allocation EXCLUSIVE-LOCK
             WHERE ROWID(lby_gsm_user_allocation) = ROWID(lbx_gsm_user_allocation)
             NO-ERROR.
        IF AVAILABLE lby_gsm_user_allocation THEN
          DO:
            {af/sup/afvalidtrg.i &action = "DELETE" &table = "lby_gsm_user_allocation"}
          END.
    END.
/* Generic multi-media deletion */
DEFINE BUFFER lbx_gsm_multi_media FOR gsm_multi_media.
DEFINE BUFFER lby_gsm_multi_media FOR gsm_multi_media.
IF CAN-FIND(FIRST lbx_gsm_multi_media 
            WHERE lbx_gsm_multi_media.owning_obj = gsc_delivery_method.{&TRIGGER_OBJ}) THEN
    FOR EACH lbx_gsm_multi_media NO-LOCK
       WHERE lbx_gsm_multi_media.owning_obj = gsc_delivery_method.{&TRIGGER_OBJ}
       ON STOP UNDO, RETURN ERROR "AF^104^gscdmtrigd.p^delete gsm_multi_media":U:
        FIND FIRST lby_gsm_multi_media EXCLUSIVE-LOCK
             WHERE ROWID(lby_gsm_multi_media) = ROWID(lbx_gsm_multi_media)
             NO-ERROR.
        IF AVAILABLE lby_gsm_multi_media THEN
          DO:
            {af/sup/afvalidtrg.i &action = "DELETE" &table = "lby_gsm_multi_media"}
          END.
    END.










/* Update Audit Log */
IF CAN-FIND(FIRST gsc_entity_mnemonic
            WHERE gsc_entity_mnemonic.entity_mnemonic = 'gscdm':U
              AND gsc_entity_mnemonic.auditing_enabled = YES) THEN
  RUN af/app/afauditlgp.p (INPUT "DELETE":U, INPUT "gscdm":U, INPUT BUFFER gsc_delivery_method:HANDLE, INPUT BUFFER o_gsc_delivery_method:HANDLE).

/* Standard bottom of DELETE trigger code */
{af/sup/aftrigendd.i}


/* Place any specific DELETE trigger customisations here */