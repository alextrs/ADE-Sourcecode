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
/* Progress Lex Converter 7.1A->7.1C Version 1.26 */

/* s-vms.p - Converts VMS directory format to UNIX format */

DEFINE INPUT-OUTPUT PARAMETER qbf-v AS CHARACTER NO-UNDO. /* filename */

DEFINE VARIABLE qbf-c AS INTEGER INITIAL     0 NO-UNDO. /* num slashes */
DEFINE VARIABLE qbf-o AS INTEGER INITIAL     0 NO-UNDO. /* scrap */
DEFINE VARIABLE qbf-p AS INTEGER               NO-UNDO. /* scrap */
DEFINE VARIABLE qbf-s AS LOGICAL INITIAL FALSE NO-UNDO. /* starts w/slash */

IF INDEX(qbf-v, "/":u) > 0 THEN DO:

  /* handle optional leading slash */
  IF qbf-v BEGINS "/":u THEN
    ASSIGN
      SUBSTRING(qbf-v,1,1,"CHARACTER":u) = "[":u
      qbf-s                              = TRUE
      qbf-c                              = 1.
  ELSE
    qbf-v = "[.":u + qbf-v.

  /* convert each embedded "/" to "." */
  qbf-p = INDEX(qbf-v, "/":u).
  DO WHILE qbf-p > 0:
    ASSIGN
      qbf-c                                  = qbf-c + 1
      SUBSTRING(qbf-v,qbf-p,1,"CHARACTER":u) = ".":u
      qbf-o                                  = qbf-p
      qbf-p                                  = INDEX(qbf-v, "/":u).
  END.
  IF qbf-o = 0 THEN
    SUBSTRING(qbf-v,1,1,"CHARACTER":u)     = "".
  ELSE
    SUBSTRING(qbf-v,qbf-o,1,"CHARACTER":u) = "]":u.

  /* now convert first "[directory]" into "volume:" */
  IF qbf-s AND qbf-c >= 2 THEN
    ASSIGN
      qbf-v = SUBSTRING(qbf-v,2,-1,"CHARACTER":u)
      qbf-p = INDEX(qbf-v,IF qbf-c = 2 THEN "]":u ELSE ".":u)
      SUBSTRING(qbf-v,qbf-p,1,"CHARACTER":u) = 
        (IF qbf-c = 2 THEN ":":u ELSE ":[":u).
END.

RETURN.

/* s-vms.p - end of file */
