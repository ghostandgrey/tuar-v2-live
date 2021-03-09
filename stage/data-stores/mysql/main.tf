provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "example_database"
  username = "admin"

  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string).dbpassword
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "TUAR_DB_Password"
}