terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }

  backend "s3" {


    bucket         = "hr-ld-academy-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "hr-ld-academy-terraform-lock"
    encrypt        = true

  }
}

provider "aws" {
  region = "eu-west-3"
}


locals {
  name   = "hr-ld-academy-cluster"
  region = "eu-west-3"

  vpc_cidr = "10.123.0.0/16"
  azs      = ["eu-west-3a", "eu-west-3b"]

  public_subnets  = ["10.123.1.0/24", "10.123.2.0/24"]
  private_subnets = ["10.123.3.0/24", "10.123.4.0/24"]
  intra_subnets   = ["10.123.5.0/24", "10.123.6.0/24"]


  account_id = data.aws_caller_identity.current.account_id

  tags = {
    name = local.name
  }
}


data "aws_caller_identity" "current" {}
