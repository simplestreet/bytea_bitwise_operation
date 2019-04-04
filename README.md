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
|  [f_bytea_to_bit](#f_bytea_to_bit)  | convert bit varying to bytea |
|  [f_bit_to_bytea](#f_bit_to_bytea)  | convert bytea to bit varying |
|  [f_bytea_and](#f_bytea_and) | bitwise AND |
|  [f_bytea_or](#f_bytea_or) | biwise OR |

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
