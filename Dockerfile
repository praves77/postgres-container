FROM postgres:9.6.9

COPY hive-schema-3.1.0.postgres.sql /docker-entrypoint-initdb.d/