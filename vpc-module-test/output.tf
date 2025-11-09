output "vpc_id" {
  value = module.vpc.vpc_id
}

# To print available zones
# output "azs" {
#     value = data.aws_availability_zones.available
# }