resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}


resource "aws_instance" "myfirstinstance" {
  ami = lookup(var.AMIS,var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = "levelup_key"
  availability_zone = "us-east-2a"
  vpc_security_group_ids = [aws_security_group.allow-test-ssh.id]
  subnet_id = aws_subnet.test-public-1.id

  tags = {
    "Name" = "demo_instance"
  }

}

output "public_ip" {
  
  value=aws_instance.myfirstinstance.public_ip
}