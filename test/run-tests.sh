#!/bin/sh

echo "Running tests for pgcmp"
echo "------------------------"

export PGBINDIR=${PGBINDIR:-"/usr/bin"}
export BASEURI="postgresql://$PGUSER@${PGHOST}:${PGPORT}/"
export POST="?host=/var/run/postgresql"
export comparison=comparisondatabase
#export POST="?host=/tmp"
T1URI=${BASEURI}test1${POST}
T2URI=${BASEURI}test2${POST}
CURI=${BASEURI}${comparison}${POST}

echo "Configuration...

PGHOST=${PGHOST}
PGUSER=${PGUSER}
BASEURI=${BASEURI}
POST=${POST}
PGBINDIR=${PGBINDIR}
T1URI=${T1URI}
T2URI=${T2URI}
CURI=${CURI}
"


for db in test1 test2; do
    dropdb --if-exists $db
    createdb -h ${PGHOST} $db
    psql -h ${PGHOST} -d ${db} -f schema1.sql
done
dropdb --if-exists ${comparison}
createdb ${comparison}
psql -d test2 -f schema2.sql

# Dump out schema data for the two databases
PGURI=$TEST1URI PGCMPOUTPUT=/tmp/test-pgcmp-file1 PGCLABEL=db1 ../pgcmp-dump
PGURI=$TEST2URI PGCMPOUTPUT=/tmp/test-pgcmp-file2 PGCLABEL=db2 ../pgcmp-dump

# Perform comparison
PGURI=$CURI PGCMPINPUT1=/tmp/test-pgcmp-file1 PGCMPINPUT2=/tmp/test-pgcmp-file2 PGCEXPLANATIONS=./explanations.txt PGCLABEL1=db1 PGCLABEL2=db2 ../pgcmp
