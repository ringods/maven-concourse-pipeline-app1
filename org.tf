
data "cf_org" "org" {
    name = "pcfdev-org"
}

data "cf_space" "dev" {
    name = "pcfdev-space"
    org = "${data.cf_org.org.id}"
}

output "domain_id" {
  value = "${data.cf_org.org.id}"

}
output "dev_space_id" {
  value = "${data.cf_space.dev.id}"
}
