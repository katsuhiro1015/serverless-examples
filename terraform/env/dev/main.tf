provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.19.0"
    }
  }
}

module "example_aws_platform" {
  source               = "../../"
  pjname               = var.pjname
  region               = var.region
  github_repository    = var.github_repository
  branch               = var.branch
}