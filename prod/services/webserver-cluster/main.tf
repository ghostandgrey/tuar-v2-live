terraform {
  backend "s3" {
    bucket = "altocorp-terraform-up-and-running-state"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

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

  enable_autoscaling = true
  enable_new_user_data = false

  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
}