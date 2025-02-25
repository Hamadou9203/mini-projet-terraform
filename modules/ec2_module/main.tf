data "aws_ami" "ubuntu_jammy" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-jammy*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "my_ec2" {
    ami = data.aws_ami.ubuntu_jammy.id
    instance_type = var.type_instance
    key_name = var.key_name
    availability_zone = var.AZ
    security_groups = var.sg_list
    tags = var.projet_tag

    provisioner "remote-exec" {
        inline = [ 
            "curl -fsSL https://get.docker.com -o install-docker.sh",
            "sh install-docker.sh --dry-run",
            "sudo sh install-docker.sh",
            "sudo usermod -aG docker ubuntu",
            "sudo sh -eux apt-get install -y uidmap",
            "dockerd-rootless-setuptool.sh install"
         ]
      
    }
    connection {
    type        = "ssh"
    user        = var.ec2_user
    private_key = var.key_private
    host        = self.public_ip

  }
}