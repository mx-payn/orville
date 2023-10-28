use actix_web::HttpResponse;

/// Simple health check function that just returns a 200 OK Response.
pub async fn health_check() -> HttpResponse {
    HttpResponse::Ok().finish()
}
