
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
