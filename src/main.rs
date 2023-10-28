use std::net::TcpListener;

use orville::startup::run;

#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    let address = format!("{}:{}", "127.0.0.1", "8000");
    let listener = TcpListener::bind(address).expect("Failed to bind address.");

    run(listener)?.await
}
