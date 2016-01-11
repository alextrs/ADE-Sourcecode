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
/* t-q-eng.p - English language definitions for Query module */

{ prores/t-define.i }

DEFINE INPUT PARAMETER qbf-s AS INTEGER NO-UNDO.

IF qbf-s < 0 THEN RETURN.
qbf-lang = "".

IF qbf-s = 1 THEN
  ASSIGN
    qbf-lang[ 1] = '��� ��⟞�� ������� �''���� �� ����㨠� ����㫞���.'
    qbf-lang[ 2] = '�礦�� �������,��ਫ਼,����礦�� �������'
    qbf-lang[ 3] = '�����坦���� 梘,���� ����,��� �⢦�'
    qbf-lang[ 4] = '��� ⮜�� ��婜� ������ ��''���� �� �����.'
    qbf-lang[ 5] = '��������ਫ਼ �������� ��� �������'
    qbf-lang[ 6] = '' /* special total message: created from #7 or #8 */
    qbf-lang[ 7] = '������� �⫨����.'
    qbf-lang[ 8] = '� ������ ����⩠�� ⚚���� �夘� '
    qbf-lang[ 9] = '�⫨��� �������...   ���㩫� [' + KBLABEL("END-ERROR")
                 + '] ��� �������.'
    qbf-lang[10] = '���竘� ��,�夘� ����櫜�� ���,�夘� ����櫜�� ��� � 婦 ��,'
                 + '�夘� �����竜�� ���,�夘� �����竜�� ��� � 婦 ��,'
                 + '��� ���竘� ��,����������� ��,���坜� ���'
    qbf-lang[11] = '��� ��ᨮ��� ����⩠��� �������.'
    qbf-lang[13] = '����� ��ᩜ� 㛞 ���� ��髞 ������� ��� ����妬.'
    qbf-lang[14] = '����� ��ᩜ� 㛞 ���� �������� ������� ��� ����妬.'
    qbf-lang[15] = '��� ⮜�� ��婜� �樣� �������.'
    qbf-lang[16] = '�������'
    qbf-lang[17] = '����⥫� ��� ������� ��� �樣�� �������.'
    qbf-lang[18] = '���㩫� [' + KBLABEL("GO")
                 + '] � [' + KBLABEL("RETURN")
                 + '] ��� ������� �樣��, � [' + KBLABEL("END-ERROR")
                 + '] ��� �⢦�.'
    qbf-lang[19] = '�樫ਫ਼ ��� �樣�� �������...'
    qbf-lang[20] = '� �樣� ������� (����� "compiled") ��姜� ��''���� �� ��暨����. '
                 + '������ �� ���墜��� ��� ��� :^1) �៦� PROPATH,^2) ��姜� '
                 + '�� ����� ������� .r , �^3) �� �����  �夘� "uncompiled" ������ .p.^(��嫜 �� '
                 + '����� <dbname>.ql ��� ���磘�� �៦�� ��� "compiler").^^�����嫜 '
                 + '�� �����婜��, ���� ������ �� ������⩜� �㤬�� �៦�� ��� ���⧜��. '
                 + '�⢜�� �� �����婜��; '
    qbf-lang[21] = '��ᨮ�� ⤘ �墫�� "WHERE" ���� ��⮦��� �樣� ������� '
                 + '��� ���� ���� ���� 騘 ���⢜��� (RUN-TIME). ���� ��� '
                 + '���������⤞ ������ ��, ��� �������坜���. �⢜�� �� '
                 + '�����婜�� ����餫�� �� �墫�� WHERE; '
    qbf-lang[22] = '���㩫� [' + KBLABEL("GET")
                 + '] ��� �� ��婜�� ����������� ���� ���稜���.'.

ELSE

IF qbf-s = 2 THEN
  ASSIGN
    qbf-lang[ 1] = '���.,�����坜� ��� ��棜�� �������.'
    qbf-lang[ 2] = '�����.,�����坜� ��� ������磜�� �������.'
    qbf-lang[ 3] = '��髞,�����坜� ��� ��髞 �������.'
    qbf-lang[ 4] = '������.,�����坜� ��� �������� �������.'
    qbf-lang[ 5] = '��,�����㡞 �☪ �������.'
    qbf-lang[ 6] = '�����.,�������� ��� ��⮦���� �������.'
    qbf-lang[ 7] = '������.,��������� ��� ��⮦���� ������� �� �� �������.'
    qbf-lang[ 8] = '��������,�������� ��� ��⮦���� �������.'
    qbf-lang[ 9] = '�������,������� ᢢ�� �樣�� �������.'
    qbf-lang[10] = '����.,���椘 �� ������� �� �� ����㨠� ��� ��婜��'
    qbf-lang[11] = '��ਫ਼,��驞 �� ������� ��� ᢢ� ����� ��� ⮦�� ��⩞.'
    qbf-lang[12] = '�����.,����㫞�� �� ����㨠� �������.'
    qbf-lang[13] = '����,������� ������� ��� ������ ������� �� �� �墫�� WHERE.'
    qbf-lang[14] = '�⫨���,������ ������� ��� ��⮦� �礦�� � ����礦��.'
    qbf-lang[15] = '������.,��墦�� ������������ ��������.'
    qbf-lang[16] = '�����.,������� ᢢ�� �����嘪.'
    qbf-lang[17] = '������.,��������圪 ��� �� ��⮦��� ����㨠� �������.'
    qbf-lang[18] = '��㩫.,��㩞 �����ᣣ���� ��� ��㩫�.'
    qbf-lang[19] = '�⢦�,�⢦�.'
    qbf-lang[20] = ''. /* terminator */

RETURN.