variable "ami_id"{
    type = string
    description = "This AMI id used for cfreation of instance"
}

variable "instance_type"{
    type = string
    description = "This instance type is used for creation of instance"
    validation {
      condition = contains(["t3.micro","t3.small","t3.medium"], var.instance_type)
      error_message = "Please select either t3 micro or small or medium"
    }
}


variable "ec2_tags"{
    type = map
    default = {}
}

variable "sg_ids"{
    type = list
}

