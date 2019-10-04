! Copyright (C) 2019 KUSUMOTO Norio.
! See http://factorcode.org/license.txt for BSD license.
USING: logica kernel assocs math ;
IN: logica.test.factorial

LOGIC-PREDS: factorial ;
LOGIC-VARS: N F N2 F2 ;

{ factorial N F } {
    { (>) N 0 }
    [ [ N of 1 - ] N2 is ]
    { factorial N2 F2 }
    [ [ [ F2 of ] [ N of ] bi * ] F is ] meti
} si
{ factorial 0 1 } semper
