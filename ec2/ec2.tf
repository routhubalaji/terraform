resource "aws_instance" "Terraform" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_all.id] 

  tags = {
    Name = "Terraform"
    Terraform = "true"
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