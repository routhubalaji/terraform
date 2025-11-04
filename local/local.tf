locals{
    ec2_ami = data.aws_ami.joindevops.id
    ec2_instance = "t3.micro"
   
    common_name = "${var.project}-${var.environment}" # roboshop-dev
    ec2_tags = merge(
      var.common_tags,
      {
        Name = "${local.common_name}-local-demo"
      }
    )
}