terraform {
  backend "s3" {
    bucket = "altocorp-terraform-up-and-running-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}


provider "aws" {
  region = "us-east-2"
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "TUAR_DB_Password"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "example_database"
  username = "admin"
  skip_final_snapshot = true

  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string).dbpassword
}

output "address" {
  value = aws_db_instance.example.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value = aws_db_instance.example.port
  description = "The port the database is listening on"
}