variable "project" {
  default = "roboshop"
}


variable "environment" {
  default = "Dev"
}



# variable "common_name" {
#   default = "${project}-${environemnt}"
# }


# variable "common_tags" {
#     type = map
#     default = {
#         Terraform = "true"
#         Project = "roboshop"
#         Environment = "dev"
#     }
# }


variable "instance_type"{
    type = string
    default = "t3.micro"
}

variable "common_tags"{
    type = map
    default = {
    Name = "Terraform"
    Terraform = "true"
    Project = "roboshop"
    Environment = "Dev"
    }
}

variable "sg_name"{
    type = string
    default = "allow_all"
}

variable "cidr"{
    type = list
    default = ["0.0.0.0/0"]
}

variable "egress_from_port"{
    type = number
    default = 0
}

variable "egress_to_port"{
    type = number
    default = 0
}

variable "ingress_from_port"{
    type = number
    default = 0
}

variable "ingress_to_port"{
    type = number
    default = 0
}

variable "protocol"{
    type = string
    default = "-1"
}