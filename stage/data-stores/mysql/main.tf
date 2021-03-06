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

module "mysql_instance" {
  source                 = "../../../../tuar-v2-modules/data-stores/mysql"
  secret_id              = "TUAR_DB_Password"
  db_remote_state_bucket = "altocorp-terraform-up-and-running-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  db_identifier_prefix   = "terraform-up-and-running-stage"
}