#Security Group for levelupvpc
resource "aws_security_group" "allow-test-ssh" {
  vpc_id      = aws_vpc.test_vpc.id
  name        = "allow-test-ssh"
  description = "security group that allows ssh connection"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
	#add you own public address .. 0.0.0.0/0 is any public address
  }
  
  tags = {
    Name = "allow-levelup-ssh"
  }
}

resource "aws_security_group" "allow-test-rds" {
  vpc_id      = aws_vpc.test_vpc.id
  name        = "allow-test-rds"
  description = "security group that allows database connection"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups=[aws_security_group.allow-test-ssh.id]
  }
  
  tags = {
    Name = "allow-test-rds"
  }
}
