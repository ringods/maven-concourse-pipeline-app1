terraform {
  backend "s3" {
    bucket = "${var.S3_BUCKET}"
    key = "test"
  }
}
