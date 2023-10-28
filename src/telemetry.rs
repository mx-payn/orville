use tracing::subscriber::set_global_default;
use tracing::Subscriber;
use tracing_bunyan_formatter::{BunyanFormattingLayer, JsonStorageLayer};
use tracing_log::LogTracer;
use tracing_subscriber::fmt::MakeWriter;
use tracing_subscriber::{layer::SubscriberExt, EnvFilter, Registry};

/// creates a telemetry subscriber and attaches following layers to it:
/// - `EnvFilter` for log-level filtering
/// - `JsonStorageLayer` for downstream metadata propagation of spans
///   in JSON format
/// - `BunyanFormattingLayer` for bunyan compatible JSON output, which implements
///   metadata inheritance
///
/// # Arguments
/// - `name` - the name of the subscriber, which is contained in every trace
/// - `env_filter` - the lower bound of message filtering. Every message with
///   lower value is output into void. One of ["trace", "debug", "info", "warn", "error", "off"]
/// - `sink` - a std::io output sink, e.g. std::io::stdout
///
/// # References
/// - [tracing-bunyan-formatter](https://crates.io/crates/tracing-bunyan-formatter/)
///
pub fn get_subscriber<Sink>(
    name: String,
    env_filter: String,
    sink: Sink,
) -> impl Subscriber + Send + Sync
where
    Sink: for<'a> MakeWriter<'a> + Send + Sync + 'static,
{
    let env_filter =
        EnvFilter::try_from_default_env().unwrap_or_else(|_| EnvFilter::new(env_filter));
    let formatting_layer = BunyanFormattingLayer::new(name, sink);
    Registry::default()
        .with(env_filter)
        .with(JsonStorageLayer)
        .with(formatting_layer)
}

/// Initializes the LogTracer and sets the given subscriber as global default
///
/// # Arguments
/// - `subscriber` - the subscriber to set as global default, e.g. from get_subscriber
///
pub fn init_subscriber(subscriber: impl Subscriber + Send + Sync) {
    LogTracer::init().expect("Failed to set logger");
    set_global_default(subscriber).expect("Failed to set subscriber");
}
