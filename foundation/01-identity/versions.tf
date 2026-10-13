terraform {
  required_version = ">= 1.10"

  backend "s3" {
    bucket       = "busdata-tfstate-126679583034"
    key          = "foundation/01-identity.tfstate"
    region       = "us-east-1"
    profile      = "busdata-shared"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.80, < 7.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
  default_tags {
    tags = {
      project    = "bus-data-platform"
      managed_by = "terraform"
      layer      = "foundation"
    }
  }
}