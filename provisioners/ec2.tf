resource "aws_instance" "Terraform" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_all.id] 

  tags = {
    Name = "Terraform"
    Terraform = "true"
  }

  provisioner "local-exec" {
    # command = "Instance is created"
    command = "echo The private ip address is ${self.private_ip} > inventory"
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo Instance is destroyed"
    when = destroy

  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }
   provisioner "remote-exec" {
    inline = [ 
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
     ]
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo systemctl stop nginx",
      "echo successfully nginx destroyed"
     ]
     when = destroy
  }



}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}