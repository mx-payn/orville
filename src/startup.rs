use actix_web::{dev::Server, App, HttpServer};
use std::net::TcpListener;

/// Starts and returns the http server as Result.
///
/// # Arguments
///
/// * `listener` - A successfully bound TcpListener
///
pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(|| App::new()).listen(listener)?.run();

    Ok(server)
}
