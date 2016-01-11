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

/* _ora_cra - base argument for oracle meta-schema

   Modified:  DLM 12/29/97 Added _ianum
              DLM 01/29/98 Added _db find and change _For-name based on 
                           Oracle Version.
              DLM 07/13/98 Added _Owner to _File Find             
*/

DEFINE INPUT PARAMETER dbkey AS RECID NO-UNDO.

FIND _Db WHERE RECID(_Db) = dbkey NO-LOCK NO-ERROR.

FIND _File
  WHERE _File._Db-recid = dbkey
    AND _File._File-name = "oracle_arguments" 
    AND _File._Owner = "_FOREIGN" NO-ERROR.
IF AVAILABLE _File THEN RETURN.

CREATE _File.
ASSIGN
  _File._Db-recid    = dbkey
  _File._File-name   = "oracle_arguments"
  _File._For-Type    = "TABLE"
  _File._For-Name    = "ARGUMENT$"
  _File._For-Owner   = "sys"
  _File._ianum       = 6
  _File._Last-change = 2146431
  _File._Hidden      = TRUE.

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "OBJ#"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = yes
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 10
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 1
  _Field._For-Maxsize  = 12
  _Field._For-Name = "OBJ#"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "PROCEDURE$"
  _Field._Data-Type    = "character"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "x(32)"
  _Field._Decimal      = 32
  _Field._Order        = 20
  _Field._Fld-stdtype  = 4096
  _Field._Fld-stoff    = 2
  _Field._For-Maxsize  = 30
  _Field._For-Name = "PROCEDURE$"
  _Field._For-Type = "char".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "OVERLOAD#"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 30
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 3
  _Field._For-Maxsize  = 12
  _Field._For-Name = "OVERLOAD#"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "POSITION"
   _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 40
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 4
  _Field._For-Maxsize  = 12
  _Field._For-Name = (IF _Db._Db-misc1[3] = 7 THEN "POSITION"
                             ELSE "POSITION#")
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "SEQUENCE#"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 50
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 5
  _Field._For-Maxsize  = 12
  _Field._For-Name = "SEQUENCE#"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "LEVEL#"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 60
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 6
  _Field._For-Maxsize  = 12
  _Field._For-Name = "LEVEL#"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "ARGUMENT"
  _Field._Data-Type    = "character"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "x(32)"
  _Field._Decimal      = 32
  _Field._Order        = 70
  _Field._Fld-stdtype  = 4096
  _Field._Fld-stoff    = 7
  _Field._For-Maxsize  = 30
  _Field._For-Name = "ARGUMENT"
  _Field._For-Type = "char".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "TYPE#"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 80
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 8
  _Field._For-Maxsize  = 12
  _Field._For-Name = (IF _Db._Db-misc1[3] = 7 THEN "TYPE"
                             ELSE "TYPE#")
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "DEFAULT#"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 90
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 9
  _Field._For-Maxsize  = 12
  _Field._For-Name = "DEFAULT#"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "IN_OUT"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 100
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 10
  _Field._For-Maxsize  = 12
  _Field._For-Name = "IN_OUT"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "LENGTH_"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 110
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 11
  _Field._For-Maxsize  = 12
  _Field._For-Name = "LENGTH"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "PRECISION_"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 120
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 12
  _Field._For-Maxsize  = 12
  _Field._For-Name = (IF _Db._Db-misc1[3] = 7 THEN "PRECISION"
                             ELSE "PRECISION#")
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "SCALE"
  _Field._Data-Type    = "integer"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "->>>>>>>>>9"
  _Field._Order        = 130
  _Field._Fld-stdtype  = 8192
  _Field._Fld-stoff    = 13
  _Field._For-Maxsize  = 12
  _Field._For-Name = "SCALE"
  _Field._For-Type = "number".

CREATE _Field. /* file: argument$ */
ASSIGN
  _Field._File-recid   = RECID(_File)
  _Field._Field-Name   = "DEFAULT$"
  _Field._Data-Type    = "character"
  _Field._Initial      = ?
  _Field._Mandatory    = no
  _Field._Format       = "x(32)"
  _Field._Decimal      = 32
  _Field._Order        = 140
  _Field._Fld-stdtype  = 16384
  _Field._Fld-stoff    = 14
  _Field._For-Maxsize  = 0
  _Field._For-Name = "DEFAULT$"
  _Field._For-Type = "long".

RETURN.