resource "aws_security_group" "roboshop_sg" {
  name        = "roboshop_strict_sg"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = toset(var.ingress_ports)
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
   
  }

  tags = {
    Name = "roboshop strict security group"
  }
}