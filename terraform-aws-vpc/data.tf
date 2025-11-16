# data "aws_availability_zones" "available" {
#   state = "available"
# }

data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_vpc" "default_vpc" {
  default = true
}

# output "default_vpc_id" {
#   value = data.aws_vpc.default_vpc.id
# }

data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}