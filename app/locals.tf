locals {
  AZ = "us-east-1a"
  projet_tags = {
    Name = "mini-projet-commun"
  }
  ebs_size = 30
  type_instance = "t2.micro"
  key_name = "Terrakey_us"
  trust_IP = [ "0.0.0.0/0" ]
  sg_name = "mini-terra_sg"
  ec2_user = "ubuntu"
}