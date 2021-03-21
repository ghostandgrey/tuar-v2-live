provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source                 = "../../../../tuar-v2-modules/services/webserver-cluster"
  cluster_name           = "stage"
  db_remote_state_bucket = "altocorp-terraform-up-and-running-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  max_size               = 2
  min_size               = 2
}