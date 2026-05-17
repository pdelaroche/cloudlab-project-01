output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "ec2_private_instance_id" {
  description = "ID of the private EC2 instance"
  value       = module.ec2_private.instance_id
}

output "ec2_private_private_ip" {
  description = "Private IP of the private EC2 instance"
  value       = module.ec2_private.private_ip
}