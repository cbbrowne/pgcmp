#!/bin/bash

echo "Running tests for pgcmp"
echo "------------------------"

export PGBINDIR=${PGBINDIR:-"/usr/bin"}
#export BASEURI="postgresql://$PGUSER@${PGHOST}:${PGPORT}/"
export BASEURI="user=${PGUSER} port=${PGPORT}"
if [ "${PGHOST}" == "" ]; then
    unset PGHOST
else
    BASEURI="${BASEURI} host=${PGHOST}"
fi
export comparison=comparisondatabase
COMMONURI="${BASEURI} dbname=postgres"
T1URI="${BASEURI} dbname=test1"
T2URI="${BASEURI} dbname=test2"
CURI="${BASEURI} dbname=comparison"

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

for db in test1 test2 comparison; do
    psql -d "${COMMONURI}" -c "drop database if exists ${db};"
    psql -d "${COMMONURI}" -c "create database ${db};"
done

for db in test1 test2; do
    psql -d "${BASEURI} dbname=${db}" -f schema1.sql
done
psql -d "${T2URI}" -f schema2.sql

# Dump out schema data for the two databases
for t in test1 test2; do
    PGURI="${BASEURI} dbname=${t}" PGCMPOUTPUT=/tmp/test-pgcmp-${t} PGCLABEL=${t} ../pgcmp-dump
done

# Perform comparison
PGURI="$CURI" PGCMPINPUT1=/tmp/test-pgcmp-test1 PGCMPINPUT2=/tmp/test-pgcmp-test2 PGCEXPLANATIONS=${PWD}/explanations.txt PGCLABEL1=test1 PGCLABEL2=test2 ../pgcmp

retcode=$?
if [ $retcode -ne 0 ]; then
    echo "Comparison failed - retcode=$retcode"
    cat /tmp/perform-comparison.log
else
    echo "Comparison succeeded OK"
fi
