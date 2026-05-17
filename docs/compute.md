# Compute status

## Current state
- One private EC2 instance is defined in Terraform
- A dedicated security group is attached
- An IAM role and instance profile are attached
- The EC2 role includes AmazonSSMManagedInstanceCore

## Current limitation
The instance is placed in a private subnet.

SSM permissions are already configured at IAM level, but Session Manager connectivity is not fully solved yet.

## Why
The current lab approach is 0€ / cost-conscious.
Private subnets do not yet have an outbound strategy for SSM traffic.

## Next decision
Choose one of these approaches:
- keep the instance private and add the required connectivity strategy later
- temporarily change the network approach for learning purposes
- revisit the cost constraints before enabling full private SSM connectivity