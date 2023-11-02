# About
Not yet a web app to manage paragliding tandem flights.

## Telemetry
Tracing and subscribers are used for telemetry. The bunyan format is chosen
as output format, as it inherits metadata from parent span.

The filter is set via environment variable `RUST_LOG`. Possible values are one of 
`trace`, `debug`, `info`, `warn`, `error`, `off`. The default is `info`.

```sh
# when running from source
RUST_LOG=debug cargo run

# when running from bin (bin location inside PATH)
RUST_LOG=warn orville
```

To get a more readable output, make sure `bunyan` is installed, e.g. 
`cargo install bunyan` and pipe your run command into it.

```sh
RUST_LOG=trace cargo run | bunyan
```

## Database
The `postgresql` database is run in a docker container for development. A script is provided
for initialization `scripts/init_db.sh`. When the container is running (`docker ps`)
use environment variable `SKIP_DOCKER=true` to skip starting the container, else
the script will fail.

The script will check whether dependencies `psql` and `sqlx` are installed,
start the container, create the database and migrate.
