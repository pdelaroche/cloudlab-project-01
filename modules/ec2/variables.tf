variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where the instance will be deployed"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}

variable "environment" {
  description = "Environment name used for tagging"
  type        = string
}

variable "instance_name" {
  description = "Logical name for the EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs attached to the instance"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for the EC2 instance"
  type        = string
}