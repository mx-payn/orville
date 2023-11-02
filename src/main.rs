use secrecy::ExposeSecret;
use sqlx::PgPool;
use std::net::TcpListener;

use orville::configuration::get_configuration;
use orville::startup::run;
use orville::telemetry::{get_subscriber, init_subscriber};

#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    // create and initialize telemetry subscriber
    let subscriber = get_subscriber("orville".into(), "info".into(), std::io::stdout);
    init_subscriber(subscriber);

    // read configuration file
    let configuration = get_configuration().expect("Failed to read configuration.");
    // init db connection
    let connection_pool =
        PgPool::connect(configuration.database.connection_string().expose_secret())
            .await
            .expect("Failed to connect to postgres.");

    // create and bind TcpListener to the address
    let address = format!("{}:{}", "127.0.0.1", "8000");
    let listener = TcpListener::bind(address).expect("Failed to bind address.");

    // run the application
    run(listener, connection_pool)?.await
}
