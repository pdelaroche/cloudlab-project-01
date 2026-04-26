# CloudLab Roadmap

## Phase 1 - Bootstrap
- Initial repository structure
- Terraform base files in `environments/dev`
- README and `.gitignore`

## Phase 2 - Remote State
- S3 bucket for Terraform state
- DynamoDB table for state locking
- Backend configuration

## Phase 3 - Networking
- VPC
- Public and private subnets
- Route tables
- Internet gateway

## Phase 4 - Compute
- EC2
- IAM role
- Security groups

## Phase 5 - Access
- SSM Session Manager

## Phase 6 - Database
- RDS
- DB subnet group
- Connectivity tests

## Phase 7 - Observability
- Prometheus
- Grafana
- Basic dashboards

## Phase 8 - CI/CD
- CircleCI
- Terraform fmt, validate, plan

## Phase 9 - Improvements
- Refactoring
- More modules
- Better pipelines
- Extra experiments
