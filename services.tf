data "cf_service" "redis" {
    name = "p-redis"
}
data "cf_service_plan" "redis" {
    name = "shared-vm"
    service = "${data.cf_service.redis.id}"
}

output "redis_id" {
  value = "${data.cf_service.redis.id}"
}
output "redis_plan_id" {
  value = "${data.cf_service_plan.redis.id}"
}

resource "cf_user_provided_service" "syslog" {
	name = "syslog"
  space = "${cf_space.dev.id}"
  syslogDrainURL = "syslog://logs3.papertrailapp.com:28020"
}
