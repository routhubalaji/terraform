resource "aws_instance" "This" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg_ids
  tags = var.ec2_tags
}


