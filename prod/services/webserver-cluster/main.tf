provider "aws" {
  region = "us-east-2"
}

module "webserver-cluster" {
  source                 = "../../../../tuar-v2-modules/services/webserver-cluster"
  cluster_name           = "prod"
  db_remote_state_bucket = "altocorp-terraform-up-and-running-state"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
  instance_type          = "m4.large"
  max_size               = 2
  min_size               = 10
}