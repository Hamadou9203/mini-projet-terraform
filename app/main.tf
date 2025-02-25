terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
  required_version = "1.10.5"
  backend "s3" {
    bucket = "terraform-backend-hamadou-1992"
    key    = "terraform.tfstate"
    region = "us-east-1"
    
  }
}
provider "aws" {
  alias                    = "east"
  region                   = var.region
  shared_credentials_files = ["../.secrets/creds"]
  profile                  = "terra_user"

}

module "ebs" {
    source = "../modules/ebs_module"
    AZ = local.AZ
    ebs_size = local.ebs_size
    projet_tag = local.projet_tags
  
}
module "key_pair" {
  source = "../modules/key_module"
  key_name = local.key_name
}
module "eip" {
  source = "../modules/eip_module"
  
}
module "sg" {
  source = "../modules/sg_module"
  sg_name = local.sg_name
  trust_IP = local.trust_IP
  
}
module "ec2" {
  depends_on = [ module.sg,module.key_pair ]
  source = "../modules/ec2_module"
  AZ = local.AZ
  key_name = local.key_name
  type_instance = local.type_instance
  sg_list = [ module.sg.sg_sortie_name ]
  key_private = module.key_pair.key_sortie_private
  projet_tag = local.projet_tags
  ec2_user = local.ec2_user
  
}

resource "aws_eip_association" "ec2_eip" {
  instance_id = module.ec2.ec2_sortie_id
  allocation_id = module.eip.eip_sortie_id
  
}

resource "aws_volume_attachment" "ebs_ec2" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.ebs_sortie_id
  instance_id = module.ec2.ec2_sortie_id
}

resource "null_resource" "globale_output" {
  depends_on = [ module.ec2,module.key_pair,module.eip ]
  provisioner "local-exec" {
    command = "echo 'PUBDNS: ${module.eip.eip_sortie_dns}; PUB_IP : ${module.eip.eip_sortie_ip}' > ../out/jenkins_ec2.txt"
  }
  
  provisioner "remote-exec" {
    inline = [ 
          "mkdir -p /tmp/app"
     ]
    
  }

  provisioner "file" {
    source = "../in/docker-compose.yml"
    destination = "/tmp/app/docker-compose.yml"
    
  }
  provisioner "remote-exec" {
    inline = [ 
      "cd /tmp/app/",
      " docker compose up -d "
     ]
    
  }
  connection {
    type     = "ssh"
    user     = local.ec2_user
    private_key = module.key_pair.key_sortie_private
    host     = module.eip.eip_sortie_ip

  }
}