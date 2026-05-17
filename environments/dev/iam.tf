# IAM role assumed by the EC2 instance.
resource "aws_iam_role" "ec2_ssm" {
  name = "${local.project}-${local.environment}-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${local.project}-${local.environment}-ec2-ssm-role"
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}

# Attach the AWS-managed policy required for Session Manager.
resource "aws_iam_role_policy_attachment" "ec2_ssm_core" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance profile used by EC2 to receive the IAM role.
resource "aws_iam_instance_profile" "ec2_ssm" {
  name = "${local.project}-${local.environment}-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm.name
}