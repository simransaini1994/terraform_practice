resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}


resource "aws_instance" "myfirstinstance" {
  ami = lookup(var.AMIS,var.AWS_REGION)
  instance_type = "t2.micro"

  tags = {
    "Name" = "demo_instance"
  }


provisioner "file" {
      source = "installnginx.sh"
      destination = "/tmp/installnginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installnginx.sh",
      "sudo /tmp/installnginx.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}