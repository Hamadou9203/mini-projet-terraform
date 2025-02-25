terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
  required_version = "1.10.5"
}

provider "aws" {
  alias                    = "east"
  region                   = "us-east-1"
  shared_credentials_files = ["../.secrets/creds"]
  profile                  = "default"

}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "terraform-backend-hamadou-1992"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
