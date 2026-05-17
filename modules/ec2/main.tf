# Base EC2 instance for the CloudLab compute layer.
# It is placed in a private subnet and will later be managed through SSM.
resource "aws_instance" "this" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile = var.iam_instance_profile

  tags = {
    Name        = "${var.project_name}-${var.environment}-${var.instance_name}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

