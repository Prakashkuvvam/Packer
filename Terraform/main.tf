provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "<=2.3"
  required_providers {
    aws = {
      version = "<=6.0.0"
      source = "hashicorp/aws"
    }
  }
}