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

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver-cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in_at_night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver-cluster.asg_name
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