#! /usr/bin/env bash

set -x
set -eo pipefail

if ! [ -x "$(command -v psql)" ]; then
    >&2 echo "Error: psql is not installed."
    >&2 echo "Installation guide:"
    >&2 echo "https://www.postgresguide.com/setup/install/"
    exit 1
fi

if ! [ -x "$(command -v sqlx)" ]; then
    >&2 echo "Error: sqlx is not installed."
    >&2 echo "Use:"
    >&2 echo "    cargo install --version='~0.7' sqlx-cli --no-default-features --features rustls,postgres"
    >&2 echo "to install it."
    exit 1
fi

DB_USER="${POSTGRES_USER:=postgres}"
DB_PASSWORD="${POSTGRES_PASSWORD:=password}"
DB_NAME="${POSTGRES_DB:=orville}"
DB_PORT="${POSTGRES_PORT:=5432}"
DB_HOST="${POSTGRES_HOST:=localhost}"

# allow to skip Docker if a dockerized Postgres database is already running
if [[ -z "${SKIP_DOCKER}" ]]; then
    # Launch postgres using Docker
    docker run \
        --name orville-db \
        -e POSTGRES_USER=${DB_USER} \
        -e POSTGRES_PASSWORD=${DB_PASSWORD} \
        -e POSTGRES_DB=§{DB_NAME} \
        -p "${DB_PORT}:5432" \
        -d postgres \
        postgres -N 1000
        # ^ increased maximum number of connections
        #   for testing purposes
fi

# keep pingin postgres till its ready to accept commands
export PGPASSWORD="${DB_PASSWORD}"
until psql -h "${DB_HOST}" -U "${DB_USER}" -p "${DB_PORT}" -d "postgres" -c '\q'; do
    >&2 echo "Postgres is still unavailable - sleeping"
    sleep 1
done

>&2 echo "Postgres is set up and running on port ${DB_PORT}!"

# postgres initialization and database migrations
DATABASE_URL=postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}
export DATABASE_URL
sqlx database create
sqlx migrate run

>&2 echo "Postgres has been migrated, ready to go!"
