variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "project_name" {
  default = "roboshop"
}

variable "env" {
  default = "dev"
}


variable "tags" {
  default = {
    Purpose = "vpc-module-test"
    DontDelete = "True"
  }
}


variable "igw_tags" {
  type = map
  default = {}
}


variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}


variable "public_subnet_tags" {
  default = {}
}

variable "private_subnet_cidrs" {
  default = ["10.0.11.0/24","10.0.12.0/24"]
}


variable "private_subnet_tags" {
  default = {}
}



variable "database_subnet_cidrs" {
  default = ["10.0.21.0/24","10.0.22.0/24"]
}


variable "database_subnet_tags" {
  default = {}
}
