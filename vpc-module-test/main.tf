module "vpc" {
  source = "../terraform-aws-vpc"
  # cidr = "10.0.0.0/16"
  # project = "roboshop"
  # environment = "dev"


  cidr = var.cidr_block
  project = var.project_name
  environment = var.env
  vpc_tags = var.tags

  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

}

# To print available zones
# data "aws_availability_zones" "available" {
#   state = "available"
# }



