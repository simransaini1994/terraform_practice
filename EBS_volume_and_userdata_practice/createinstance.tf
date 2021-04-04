resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}


resource "aws_instance" "myfirstinstance" {
  ami = lookup(var.AMIS,var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = "levelup_key"
  availability_zone = "us-east-2a"

  tags = {
    "Name" = "demo_instance"
  }

}

resource "aws_ebs_volume" "test_ebs" {
  availability_zone = "us-east-2a"
  size              = 10
  type              = "gp2"

  tags = {
    Name = "test_ebs"
  }
}


#Atatch EBS volume with AWS Instance
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.test_ebs.id
  instance_id = aws_instance.myfirstinstance.id
}