locals {
  project     = "cloudlab"
  environment = "dev"
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  availability_zones   = ["eu-west-1a", "eu-west-1b"]

  project_name = local.project
  environment  = local.environment
}

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

module "ec2_private" {
  source = "../../modules/ec2"

  ami_id               = data.aws_ssm_parameter.al2023_ami.value
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.private_subnet_ids[0]
  security_group_ids   = [aws_security_group.ec2_private.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm.name

  project_name  = local.project
  environment   = local.environment
  instance_name = "app-1"
}