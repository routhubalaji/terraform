output "public_ip" {
  value = aws_instance.This.public_ip
  description = "Public ip address"
}

output "private_ip" {
  value = aws_instance.This.private_ip
  description = "Private ip address"
}