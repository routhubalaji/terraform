variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "sg_ids" {
  default = ["sg-00051677cf6f7ee25"]
}

variable "tags" {
  default = {
    name = "Modules Demo"
    Terraform = true
  }
}