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
/* 
 * This file controls what exactly is timed in the UIB.
 * There are several different timers in place.  To drop
 * a timer mpdrop.i the timer.  To include a timer
 * mpdo.i the timer.  (Only drop actually does anything
 * mpdo is just a place-holder and MESSAGE.
 *
 * The first line, mpdotime.i, controls whether _any_
 * timing is done at all.
 *
 */
 
 /* {adeshar/mpdotime.i} */
 
 {adeshar/mpdrop.i &TIMER="UIB_startup"}
 {adeshar/mpdrop.i &TIMER="UIB_close"}  
 {adeshar/mpdrop.i &TIMER="UIB_prop"}  
 {adeshar/mpdrop.i &TIMER="UIB_qssuck"}  

 
 