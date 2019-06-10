FROM postgres:11.3

# ARG POSTGRES_VER=11.3
# HIVE_VER=2.3.0

# HIVE_DB="metastore"
# HIVE_USER="metastore"
# HIVE_PASSWORD='metastore_password'

ARG POSTGRES_VER
ARG HIVE_VER

ARG HIVE_DB
ARG HIVE_USER
ARG HIVE_PASSWORD

# COPY hive-schema-2.3.0.postgres.sql /docker-entrypoint-initdb.d/
COPY hive-schema-${HIVE_VER}.postgres.sql /hive-schema-2.3.0.postgres.sql

COPY hive-txn-schema-${HIVE_VER}.postgres.sql /hive-txn-schema-2.3.0.postgres.sql

ADD init-metastore-db.sh /docker-entrypoint-initdb.d/init-user-db.sh




