provider "aws" {
  region = "us-east-2"
}

module "webserver-cluster" {
  source = "../../../../tuar-v2-modules/services/webserver-cluster"
}