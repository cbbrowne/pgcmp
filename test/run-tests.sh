#!/bin/sh
for db in test1 test2; do
    dropdb $db
    createdb $db
    psql -d ${db} -f schema1.sql
done
dropdb comparisondatabase
createdb comparisondatabase
psql -d test2 -f schema2.sql

# Dump out schema data for the two databases
PGURI=postgresql://postgres@localhost/test1 PGCMPOUTPUT=/tmp/test-pgcmp-file1 PGCLABEL=db1 ../pgcmp-dump
PGURI=postgresql://postgres@localhost/test2 PGCMPOUTPUT=/tmp/test-pgcmp-file2 PGCLABEL=db2 ../pgcmp-dump

# Perform comparison
PGURI=postgresql://postgres@localhost/comparisondatabase PGCMPINPUT1=/tmp/test-pgcmp-file1 PGCMPINPUT2=/tmp/test-pgcmp-file2 PGCEXPLANATIONS=./explanations.txt PGCLABEL1=db1 PGCLABEL2=db2 ../pgcmp
