#!/bin/sh
for db in test1 test2; do
    dropdb --if-exists $db
    createdb -h ${PGHOST} $db
    psql -h ${PGHOST} -d ${db} -f schema1.sql
done
dropdb --if-exists comparisondatabase
createdb comparisondatabase
psql -d test2 -f schema2.sql

export PGBINDIR=/usr/bin

BASEURI="postgresql://$PGUSER@%F2var%F2run%F2postgresql%F2"

# Dump out schema data for the two databases
PGURI=${BASEURI}test1 PGCMPOUTPUT=/tmp/test-pgcmp-file1 PGCLABEL=db1 ../pgcmp-dump
PGURI=${BASEURI}test2 PGCMPOUTPUT=/tmp/test-pgcmp-file2 PGCLABEL=db2 ../pgcmp-dump

# Perform comparison
PGURI=${BASEURI}comparisondatabase PGCMPINPUT1=/tmp/test-pgcmp-file1 PGCMPINPUT2=/tmp/test-pgcmp-file2 PGCEXPLANATIONS=./explanations.txt PGCLABEL1=db1 PGCLABEL2=db2 ../pgcmp
