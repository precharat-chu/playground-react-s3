terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "s3-bucket" {
  source  = "app.terraform.io/precharat-chu/s3-bucket/aws"
  version = "3.6.0"

  bucket_prefix = "playground-react-s3"

}
