resource "aws_eip" "my_eip" {
  # Indicates if this EIP is for use in VPC
  domain = "vpc"
}