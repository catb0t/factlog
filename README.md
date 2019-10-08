# logica

logica is a Prolog subset DSL running on Factor.


## Usage

```
USE: logica

LOGIC-PREDS: cato mouseo animalo ;
LOGIC-VARS: X Y ;
SYMBOLS: Tom Jerry Nibbles ;
```
Use ```LOGIC-PREDS:``` to declare the predicates you want to use. And, use `LOGIC-VARS: `to declare the variables you want to use. The predicates end with the character `o`, which is a custom borrowed from miniKanren and so on, and means relations. This is not necessary, but it is useful for reducing conflicts with the words of, the parent language, Factor. We really want to write them as: ```cat°```, ```mouse°``` and ```animal°```, but we use `o` because it's easy to type.


```
{ cato Tom } semper
{ mouseo Jerry } semper
{ mouseo Nibbles } semper
```
The above code means that Tom is a cat and Jerry and Nibbles are mice. Use ```semper``` to describe the facts.

```
{ cato Tom } query .
⟹ t
```
The above code asks, "Is Tom a cat?". We said,"Tom is a cat.", so the answer is ```t```. The general form of a query is: 
```
{ G1 G2 ... Gn } query
```
The parentheses are omitted because there was only one goal to be satisfied earlier, but here is an example of two goals:
```
{ { cato Tom } { cato Jerry } } query .
⟹ f
```
Tom is a cat, but Jerry is not declared a cat, so ```f``` is returned in response to this query.

If you query with variable(s), you will get the answer for the variable(s). For such queries, an array of hashtables with variables as keys is returned.
```
{ mouseo X } query .
⟹ { H{ { X Jerry } } H{ { X Nibbles } } }
```
The following code shows that if something is a cat, it's an animal. Use `si` to write rules.
```
{ animalo X } { cato X } si
```
According to the rules above, "Tom is an animal." is answered to the following questions:.
```
{ animalo Y } query .
⟹ { H{ { Y Tom } } }
```
The general form of `si` is:
```
Gh { Gb1 Gb2 ... Gbn } si
```
This means Gh when all goals of Gb1, Gb2... Gbn are met.
```
LOGIC-PREDS: youngo young-mouse ;

{ youngo Nibbles } semper

{ young-mouseo X } {
    { mouseo X }
    { youngo X }
} si

{ young-mouseo X } query .
⟹ { H{ { X Nibbles } } }

```

Let's describe that mice are also animals.

```
{ animalo X } { mouseo X } si

{ animalo X } query .
⟹ { H{ { X Tom } } H{ { X Jerry } } H{ { X Nibbles } } }
```
As a matter of fact, we were able to describe at once that cats and mice were animals by doing the following.
```
{ animalo Y } {
    { cato Y } vel { mouseo Y }
} si
```
The code below it has the same meaning as the code below it.
```
Gh { Gb1 Gb2 Gb3 vel Gb4 Gb5 vel Gb6 } si
```
```
Gh { Gb1 Gb2 Gb3 } si
Gh { Gb4 Gb5 } si
Gh { Gb6 } si
```

You can use `query-n` to limit the number of answers to a query. Specify a number greater than or equal to 1.
```
{ animalo Y } 2 query-n .
⟹ { H{ { Y Tom } } H{ { Y Jerry } } }
```

