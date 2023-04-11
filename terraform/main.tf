terraform {
  required_version = ">= 0.13.1"

  cloud {
    organization = "precharat-chu"

    workspaces {
      name = "playground-react-s3"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
  }
}

locals {
  bucket_name = "playground-react-s3"
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_caller_identity" "current" {}





module "s3_bucket" {
  source  = "app.terraform.io/precharat-chu/s3-bucket/aws"
  version = "3.6.0"

  bucket = local.bucket_name

  attach_policy = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${local.bucket_name}/*"
        ]
      }
    ]
  })
  # attach_deny_insecure_transport_policy = true
  # attach_require_latest_tls_policy      = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  expected_bucket_owner = data.aws_caller_identity.current.account_id
  website = {
    # conflicts with "error_document"
    #        redirect_all_requests_to = {
    #          host_name = "https://modules.tf"
    #        }

    index_document = "index.html"
    error_document = "404.html"

  }

}


