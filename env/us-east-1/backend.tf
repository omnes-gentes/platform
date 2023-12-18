terraform {
  required_version = "> 1"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend s3 {
    acl    = "bucket-owner-full-control"
    bucket = "tf-state-omnes-gentes-us-east-1"
    key    = "us-east-1/prd/platform/terraform.tfstate"
    region = "us-east-1"
    profile = "omnes-gentes"
  }
}