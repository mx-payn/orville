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
