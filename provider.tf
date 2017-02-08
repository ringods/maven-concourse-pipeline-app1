# Configure the CloudFoundry Provider

provider "cf" {
    api_url = "${var.api_url}"
    user = "admin"
    password = "${var.admin_password}"
    uaa_client_id = "admin"
    uaa_client_secret = "${var.uaa_admin_client_secret}"
    skip_ssl_validation = true
}
