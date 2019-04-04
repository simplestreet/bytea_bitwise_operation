# Overview
Postgresql can not do bitwise operation with `bytea` type.
You need to use `bit varying` type for bitwise operation.

However, that's very inconvinience.

So, I created some functions that can do bitwise operation with `bytea` type.

# Confirmation version
PostgreSQL 9.5.14 (on Ubuntu 16.04)

# How to use
Please import functions.sql into your postgresql environment.

# Functions
