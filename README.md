# maven-concourse-pipeline-app1


```
$ git clone https://github.com/MarcialRosales/maven-concourse-pipeline
$ git clone https://github.com/MarcialRosales/maven-concourse-pipeline-app1
```



## Step 04_install_built_artifact

**Set up infrastucture**

Assuming Docker is running in your machine run the following commands:

```
cd maven-concourse-pipeline
nohup docker-compose up &
```

**Set pipeline**

Login to *Concourse* and set the pipeline
```
fly -t plan1 login -c http://192.168.99.100:8080 -u concourse -p changeme
fly -t plan1 sp -p 04_install_built_artifact -c ../maven-concourse-pipeline/pipeline.yml -l credentials.yml
```

**Trigger pipeline**

We manually trigger it or via a commit, lets try to make a small change to our application and push that change.

## Step 20_deploy_and_verify

We create an orphan branch where we are going to keep the acceptance tests, we could have dedicated a separate repository.
```
git checkout --orphan acceptance-test
git rm --cached -r .
rm -rf *
rm .gitignore .gitmodules
touch README.md
git add .
git commit -m "new branch"
git push origin acceptance-test
```

And we clone it onto a separate folder because we want to create in the source code and in the acceptance tests at the same time.

```
git clone -b acceptance-test https://github.com/MarcialRosales/maven-concourse-pipeline-app1 maven-concourse-pipeline-app1-test
```

## Step 40_provision_infra_with_terraform

We create an orphan branch where we are going to keep the terraform definitions for one environments. We start with the dev environment.

```
git checkout --orphan terraform-dev
git rm --cached -r .
rm -rf *
rm .gitignore .gitmodules
touch README.md
git add .
git commit -m "new branch"
git push origin terraform-dev
```

We add the following terraform files:

**Terraform settings** We configure the backend for the remote state in the `terraform.tf` file
```
terraform {
  backend "s3" {
    bucket = "maven-concourse-pipeline"
    key = "test"
  }
}
```

**CF Provider** We configure the `cf provider` to interact with Cloud Foundry in the `provider.tf` file
```
provider "cf" {
    api_url = "${var.CF_API_URL}"
    user = "${var.CF_ADMIN_USER}"
    password = "${var.CF_ADMIN_PASSWORD}"
    uaa_client_id = "${var.CF_UAA_ADMIN_CLIENT_ID}"
    uaa_client_secret = "${var.CF_UAA_ADMIN_CLIENT_SECRET}"
    skip_ssl_validation = "${var.CF_SKIP_SSL_VALIDATION}"
}
```

**vars** The `cf provider` expects a number of variables that we need to set up in the `vars.tf` file
```
variable "CF_API_URL" {}
variable "CF_ADMIN_USER" {}
variable "CF_ADMIN_PASSWORD" {}
variable "CF_UAA_ADMIN_CLIENT_ID" {}
variable "CF_UAA_ADMIN_CLIENT_SECRET" {}
variable "CF_SKIP_SSL_VALIDATION" {}

# S3 remote state
variable "S3_BUCKET" {}
variable "S3_KEY" {}
```
**CF organizations/spaces** We locate some Cloud Foundry resources (thru `terraform datasources`) that we will need to use later on. We declare these datasources in `org.tf` file.
```

data "cf_org" "pcfdev-org" {
    name = "pcfdev-org"
}

data "cf_space" "pcfdev-space" {
    name = "pcfdev-space"
    org = "${data.cf_org.pcfdev-org.id}"
}

output "domain_id" {
  value = "${data.cf_org.pcfdev-org.id}"

}
output "space_id" {
  value = "${data.cf_space.pcfdev-space.id}"
}

```

## Provision a User Provided Service to redirect the logs to a syslog drainer

We will use an externally provisioned syslog drainer. See the instructions below:

1. Sign up for a free Papertrail account: https://papertrailapp.com/
2. Follow the instructions to set up Papertrail: http://docs.run.pivotal.io/devguide/services/log-management-thirdparty-svc.html#papertrail
3. Record the URL with port that is displayed after creating the system.
4. Edit `services.tf` file and add the following terraform resource:
