module "catalogue"{
  source = "../terraform-aws-instance"

  
  # ami_id ="ami-09c813fb71547fc4f"
  # instance_type = "t3.micro"
  # sg_ids = ["sg-00051677cf6f7ee25"]
  # ec2_tags = {
  #   name = "Modules Demo"
  #   Terraform = true

  ami_id = var.ami_id
  instance_type = var.instance_type
  sg_ids = var.sg_ids
  ec2_tags = var.tags
  }



output "pub_ip" {
  value = module.catalogue.public_ip
}

output "prv_ip" {
  value = module.catalogue.private_ip
}

output "instance_id" {
 value = module.catalogue.instance 
}