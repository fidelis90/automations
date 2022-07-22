terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "ndx-dev-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    profile        = "ndx"
    dynamodb_table = "ndx-dev-terraform-state-locks"
    encrypt        = true
  }
}

  /* terraform {
  required_providers {
    aws = {
      version = "4.5.0"
    }
  }
  } */

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "aws" {
  region  = var.aws_region
  profile = var.profile
}


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

