# Security group for the private EC2 instance.
# No inbound rules are defined for now because access will be managed through SSM.
resource "aws_security_group" "ec2_private" {
  name        = "${local.project}-${local.environment}-ec2-private-sg"
  description = "Security group for the private EC2 instance"
  vpc_id      = module.vpc.vpc_id

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${local.project}-${local.environment}-ec2-private-sg"
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}