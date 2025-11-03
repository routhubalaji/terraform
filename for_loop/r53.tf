resource "aws_route53_record" "roboshop" {
  #count = lenth(var.instances)
  for_each = aws_instance.Terraform
  zone_id = var.zone_id
  name    = "${each.key}.${var.domain_name}" # mongodb.daws86s.fun
  type    = "A"
  ttl     = 1
  records = [each.value.private_ip]
  allow_overwrite = true
}



#resource "aws_route53_record" "frontend" {
#  count = 1
#  zone_id = var.zone_id
#  name    = "${var.instances[count.index]}.${var.domain_name}" # mongodb.daws86s.fun
#  type    = "A"
#  ttl     = 1
#  records = [aws_instance.terraform[count.index].public_ip]
#  allow_overwrite = true
#}