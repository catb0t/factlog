! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test logica logica.examples.factorial ;
IN: logica.examples.factorial.tests

{ { H{ { F 1 } } } } [ { factorial 0 F } query ] unit-test

{ { H{ { F 1 } } } } [ { factorial 1 F } query ] unit-test

{ { H{ { F 2 } } } } [ { factorial 2 F } query ] unit-test

{ { H{ { F 3628800 } } } } [ { factorial 10 F } query ] unit-test
