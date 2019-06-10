#!/bin/bash
set -e

# HIVE_DB="metastore"
# HIVE_USER="metastore"
# HIVE_PASSWORD='metastore_password'
# HIVE_VER=2.3.0

HIVE_VER="${HIVE_VER:-2.3.0}"

HIVE_DB="${HIVE_DB:-metastore}"
HIVE_USER="${HIVE_USER:-metastore}"
HIVE_PASSWORD="${HIVE_PASSWORD:-metastore_password}"

# ls -ll
# pwd
# ls -ll hive/

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER ${HIVE_USER} WITH PASSWORD '${HIVE_PASSWORD}';
  CREATE DATABASE ${HIVE_DB};
  GRANT ALL PRIVILEGES ON DATABASE ${HIVE_DB} TO ${HIVE_USER};

  \c ${HIVE_DB}

  \i /hive-schema-${HIVE_VER}.postgres.sql

  \pset tuples_only
  \o /tmp/grant-privs
SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON "' || schemaname || '"."' || tablename || '" TO ${HIVE_USER} ;'
FROM pg_tables
WHERE tableowner = CURRENT_USER and schemaname = 'public';
  \o
  \i /tmp/grant-privs
EOSQL


echo "Yey!!!! metastore is initialized."


