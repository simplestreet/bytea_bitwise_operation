# Overview
Postgresql can not do bitwise operation with `bytea` type.  
You need to use `bit varying` type for it.  
  
e.g.)  
```
# select b'00001111' | b'11110000' as bitwise;

 bitwise
----------
 11111111
(1 row)

# select E'\\x0f'::bytea | E'\\xf0'::bytea;

ERROR:  operator does not exist: bytea | bytea

```
  
However, that's very inconvinience.  
  
So, I created some functions that can do bitwise operation with `bytea` type.  
  
# Confirmation version
PostgreSQL 9.5.14 (on Ubuntu 16.04)  
  
# How to use
Please import functions.sql into your postgresql environment.  
  
# Functions
|  name |  description  |
| ---- | ---- |
|  [f_bytea_to_bit(bytea)](#f_bytea_to_bit)  | convert bit varying to bytea |
|  [f_bit_to_bytea(bit varying)](#f_bit_to_bytea)  | convert bytea to bit varying |
|  [f_bytea_and(bytea, bytea)](#f_bytea_and) | bitwise AND |
|  [f_bytea_or(bytea, bytea)](#f_bytea_or) | biwise OR |
|  [f_bytea_xor(bytea, bytea)](#f_bytea_xor) | biwise XOR |
|  [f_bytea_not(bytea)](#f_bytea_not) | biwise NOT |
|  [f_bytea_lshift(bytea, integer)](#f_bytea_lshift) | bitwise shift left |
|  [f_bytea_rshift(bytea, integer)](#f_bytea_rshift) | bitwise shift right |

# Example
## f_bytea_to_bit
```
# select f_bytea_to_bit(E'\\xff10');

  f_bytea_to_bit
------------------
 1111111100010000
(1 row)
```
## f_bit_to_bytea
```
# select f_bit_to_bytea(b'0000111110101110');

 f_bit_to_bytea
----------------
 \x0fae
(1 row)

```
## f_bytea_and
```
# select f_bytea_and(E'\\x0f',E'\\x1d');

 f_bytea_and
-------------
 \x0d
(1 row)
```
## f_bytea_or
```
# select f_bytea_or(E'\\x0f',E'\\x80');

 f_bytea_or
------------
 \x8f
(1 row)
```
## f_bytea_xor
```
# select f_bytea_xor(E'\\x0f',E'\\xfa');

 f_bytea_xor
-------------
 \xf5
(1 row)
```
## f_bytea_not
```
# select f_bytea_not(E'\\xaa');

 f_bytea_not
-------------
 \x55
(1 row)
```
## f_bytea_lshift
```
# select f_bytea_lshift(E'\\x0f',1);

 f_bytea_lshift
----------------
 \x1e
(1 row)
```
## f_bytea_rshift
```
# select f_bytea_rshift(E'\\xf0',1);

 f_bytea_rshift
----------------
 \x78
(1 row)
```
