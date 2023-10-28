use actix_web::{dev::Server, App, HttpServer};
use std::net::TcpListener;
use tracing_actix_web::TracingLogger;

/// Starts and returns the HTTP server as Result.
///
/// # Arguments
///
/// * `listener` - A successfully bound TcpListener
///
pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(|| App::new().wrap(TracingLogger::default()))
        .listen(listener)?
        .run();

    Ok(server)
}
