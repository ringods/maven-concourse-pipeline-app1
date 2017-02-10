# Configure the CloudFoundry Provider

provider "cf" {
    api_url = "${var.CF_API_URL}"
    user = "${var.CF_ADMIN_USER}"
    password = "${var.CF_ADMIN_PASSWORD}"
    uaa_client_id = "${var.CF_UAA_ADMIN_CLIENT_ID}"
    uaa_client_secret = "${var.CF_UAA_ADMIN_CLIENT_SECRET}"
    skip_ssl_validation = "${var.CF_SKIP_SSL_VALIDATION}"
}
