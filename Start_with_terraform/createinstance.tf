resource "aws_instance" "myfirstinstance" {
  ami = lookup(var.AMIS,var.AWS_REGION)
  instance_type = "t2.micro"

  tags = {
    "Name" = "demo_instance"
  }
}