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
/*----------------------------------------------------------------------------

File: _proprty.p

Description:
    Procedure to manage all of the property sheets.  This does not display
    any property sheet itself.  Instead it just looks at the type and 
    goes to the correct property sheet.

Input Parameters:
   h_self : The handle of the object we are editing

Output Parameters:
   <None>

Author: Wm.T.Wood

Date Created: 1995 
Modified: 1/98 SLK Added SmartData

----------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER h_self   AS WIDGET                            NO-UNDO.

{adeuib/uniwidg.i}              /* Universal widget definition              */
{adeuib/triggers.i}             /* Trigger Temp-table definition            */
{adeuib/brwscols.i}             /* Brwose column temp-table definitions     */

/* Rather than include all of sharvars.i, I'll just define the share for
   _h_uib, which is used to call its internal procedure setstatus. */
DEFINE SHARED VAR _h_uib        AS WIDGET-HANDLE                     NO-UNDO.

DEFINE VAR ldummy AS LOGICAL NO-UNDO.

DEFINE BUFFER      x_U FOR _U.

/* Now fork depending on the type of the widget, h_self. */
FIND _U WHERE _U._HANDLE = h_self.
IF _U._TYPE = "QUERY":U THEN FIND _P WHERE _P._WINDOW-HANDLE = _U._WINDOW-HANDLE.

/* This include performs browse column size adjustment */ 
{adeuib/_adjcols.i}             

/* In a DESIGN-WINDOW, bypass the Window property sheet 
   and go to the first child of the "window", if available. */
IF _U._TYPE eq "WINDOW" AND _U._SUBTYPE eq "Design-Window":U THEN DO:
  /* First look for a frame in the window. */
  FIND FIRST x_U WHERE x_U._parent-recid eq RECID(_U) 
                   AND x_U._TYPE eq "FRAME"
                   AND x_U._STATUS eq "NORMAL"
                   NO-ERROR.
  /* Is there anything in the window? */
  FIND FIRST x_U WHERE x_U._parent-recid eq RECID(_U) 
                   AND RECID(x_U) ne RECID(_U)  /* Don't choose it again. */
                   AND x_U._STATUS eq "NORMAL"
                   NO-ERROR.
             
  IF NOT AVAILABLE x_U   
  THEN MESSAGE "Property sheet cannot be displayed.  There are no" {&SKP}
            "objects in this design window."
             VIEW-AS ALERT-BOX INFORMATION.
  ELSE 
    /* Show this object instead. */
    RUN adeuib/_proprty.p (x_U._HANDLE).
END.

/* MENUS - Go to the menu editor. */
ELSE IF CAN-DO("MENU,MENU-ITEM,SUB-MENU",_U._TYPE) THEN DO:
  RUN adeuib/_prpmenu.p (_U._HANDLE).
END.

/* QUERY's use  'adeuib/_callqry.p' as their property sheet. */
ELSE IF (_U._TYPE eq "QUERY":U AND _U._SUBTYPE <> "SmartDataObject")
THEN DO:
  IF CAN-FIND (_TRG WHERE _TRG._wRecid = RECID(_U) AND _TRG._tEvent = "OPEN_QUERY") THEN
  DO:
    MESSAGE "A freeform query can only be modified via the Section Editor."
      VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    RETURN.
  END.
  ELSE IF NUM-DBS = 0 THEN DO:
    RUN adecomm/_dbcnnct.p (
      INPUT "You must have at least one connected database to create or modify a query.",
      OUTPUT ldummy).
    IF ldummy EQ NO THEN DO ON STOP UNDO, RETURN:
      RUN setstatus IN _h_uib ("":U, "":U).
      RETURN.
    END.
  END.
  RUN adeuib/_callqry.p ("_U", RECID(_U), "QUERY-ONLY").
END.
/* SmartObjects have their own property sheet 
 * This is the property sheet with the link and info buttons
 */
ELSE IF (_U._TYPE eq "SmartObject":U) THEN RUN adeuib/_prpsmar.p (_U._HANDLE).
/* SmartData This is the property sheet with query/field buttons */
ELSE IF (_U._TYPE eq "QUERY":U AND _U._SUBTYPE = "SmartDataObject":U)
THEN RUN adeuib/_prpsdo.p (_U._HANDLE).


ELSE
DO:
  
  /* If this is a tree-view we just run the list-items/radio-set 
     property dialog */
  FIND _P WHERE _P._WINDOW-HANDLE = _U._WINDOW-HANDLE.
  IF VALID-HANDLE(_P._tv-proc) THEN
    RUN adeuib/_prplist.p (INPUT _U._HANDLE).
  
  /* Everything else uses the standard object property sheet. */
  ELSE  
    RUN adeuib/_prpobj.p (INPUT _U._HANDLE).
END.