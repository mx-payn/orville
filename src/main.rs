use std::net::TcpListener;

use orville::startup::run;
use orville::telemetry::{get_subscriber, init_subscriber};

#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    // create and initialize telemetry subscriber
    let subscriber = get_subscriber("zero2prod".into(), "info".into(), std::io::stdout);
    init_subscriber(subscriber);

    // create and bind TcpListener to the address
    let address = format!("{}:{}", "127.0.0.1", "8000");
    let listener = TcpListener::bind(address).expect("Failed to bind address.");

    // run the application
    run(listener)?.await
}
