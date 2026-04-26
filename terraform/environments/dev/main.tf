provider "aws" {
  region = "eu-west-1"
}

module "network" {
  source = "../../modules/network"

  azs = ["eu-west-1a", "eu-west-1b"]

  tags = local.common_tags
}