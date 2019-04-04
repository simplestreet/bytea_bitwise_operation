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
LINE 1: select E'\\x0f'::bytea | E'\\xf0'::bytea;
                               ^
HINT:  No operator matches the given name and argument type(s). You might need to add explicit type casts.

```
  
However, that's very inconvinience.  
  
So, I created some functions that can do bitwise operation with `bytea` type.  
  
# Confirmation version
PostgreSQL 9.5.14 (on Ubuntu 16.04)  
  
# How to use
Please import functions.sql into your postgresql environment.  
  
# Functions
