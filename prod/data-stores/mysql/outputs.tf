output "address" {
  description = "The address of the prod database"
  value = module.mysql_instance.address
}

output "port" {
  description = "The port the prod database is listening on"
  value = module.mysql_instance.port
}
