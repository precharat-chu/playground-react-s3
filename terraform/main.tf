terraform {
  required_version = ">= 0.13.1"

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

# resource "aws_iam_role" "this" {
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# data "aws_iam_policy_document" "bucket_policy" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = [aws_iam_role.this.arn]
#     }

#     actions = [
#       "s3:ListBucket",
#     ]

#     resources = [
#       "arn:aws:s3:::${local.bucket_name}",
#     ]
#   }
# }


module "s3_bucket" {
  source  = "app.terraform.io/precharat-chu/s3-bucket/aws"
  version = "3.6.0"

  bucket_prefix = local.bucket_name

  # attach_policy                         = true
  # policy                                = data.aws_iam_policy_document.bucket_policy.json
  # attach_deny_insecure_transport_policy = true
  # attach_require_latest_tls_policy      = true

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  website = {
    # conflicts with "error_document"
    #        redirect_all_requests_to = {
    #          host_name = "https://modules.tf"
    #        }

    index_document = "index.html"
    error_document = "error.html"

  }

}


