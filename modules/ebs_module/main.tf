resource "aws_ebs_volume" "my_ebs" {
  availability_zone = var.AZ
  size = var.ebs_size
  tags = var.projet_tag
}