terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.53"
    }
  }
}

provider "aws" {
  profile = "terraform"
  region  = "eu-central-1"
}

