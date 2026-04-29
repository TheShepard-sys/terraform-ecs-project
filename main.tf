terraform {
  backend "s3" {
    bucket         = "secure-terraform-state-460576937528"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = "eu-west-2"
}

# -------------------------
# DATA SOURCES
# -------------------------
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# -------------------------
# MODULES
# -------------------------
module "ecr" {
  source = "./modules/ecr"
  name   = "${var.app_name}-${var.environment}"
}

# -------------------------
# IAM ROLE
# -------------------------

module "iam" {
  source = "./modules/iam"
  name   = "${var.app_name}-${var.environment}-ecs-role"
}

# -------------------------
# ECS MODULE
# -------------------------
module "ecs" {
  source = "./modules/ecs"

  app_name           = var.app_name
  environment        = var.environment
  subnets            = data.aws_subnets.default.ids
  vpc_id             = data.aws_vpc.default.id
  execution_role_arn = module.iam.role_arn
  image              = "${module.ecr.repository_url}:latest"
}
