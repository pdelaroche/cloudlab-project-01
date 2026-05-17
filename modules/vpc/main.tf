# Base VPC for the CloudLab networking layer.
# DNS support and hostnames are enabled to simplify future EC2 and service resolution.
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Public subnets are intended for resources that may need public IP addressing
# or direct internet-facing routing in later phases of the lab.
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-${count.index + 1}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "public"
  }
}

# Private subnets are reserved for internal workloads such as app or database tiers.
# They are intentionally left without direct internet routing for now.
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-${count.index + 1}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "private"
  }
}

# Internet Gateway provides internet connectivity at the VPC level.
# It has no direct cost, so it fits the current 0€ lab approach.
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Public route table sends default outbound traffic to the Internet Gateway.
# Only public subnets will be associated with this table.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "public"
  }
}

# Associate the public route table only with the public subnets.
# Private subnets remain isolated until a specific outbound strategy is defined.
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}