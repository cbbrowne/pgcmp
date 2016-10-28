#!/bin/sh
for db in test1 test2; do
    dropdb $db
    createdb $db
    psql -d ${db} -f schema1.sql
done
dropdb comparisondatabase
createdb comparisondatabase
psql -d test2 -f schema2.sql


URI1=postgresql://postgres@localhost/test1 URI2=postgresql://postgres@localhost/test2 EXPLANATIONS=./explanations.txt ../pgcmp
