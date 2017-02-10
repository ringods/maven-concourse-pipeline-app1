terraform {
  backend "s3" {
    bucket = "maven-concourse-pipeline"
    key = "test"
  }
}
