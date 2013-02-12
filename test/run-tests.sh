#!/bin/sh
for db in test1 test2; do
    dropdb $db
    createdb $db
    psql -d ${db} -f schema1.sql
done
dropdb comparisondatabase

psql -d test2 -f schema2.sql

DB1=test1 DB2=test2 EXPLANATIONS=./explanations.txt ../pgcmp
