output "address" {
  description = "The address of the stage database"
  value = module.mysql_instance.address
}

output "port" {
  description = "The port the stage database is listening on"
  value = module.mysql_instance.port
}