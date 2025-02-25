resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
  
}

resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

resource "local_sensitive_file" "stockage_key" {
  filename = "../.secrets/${var.key_name}.pem"
  content = tls_private_key.rsa-4096.private_key_pem
  
}