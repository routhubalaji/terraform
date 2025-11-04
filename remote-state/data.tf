data "aws_ami" "joindevops" {
    owners           = ["973714476881"]
    most_recent      = true
  
    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
}


# data "aws_instance" "Terraform"{
#     instance_id="i-07c4f1480e3e58f20"
# }

output "ami_id"{
    value = data.aws_ami.joindevops.id
}


# output "Terraform_Pub_Info"{
#     value = data.aws_instance.Terraform.public_ip
#     #value = data.aws_instance.Terraform.private_ip
# }

# output "Terraform_Prv_Info"{
#     value = data.aws_instance.Terraform.private_ip
# }