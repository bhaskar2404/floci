terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "demo-tfstate-000000000000"
    key          = "eks/dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true

    # Floci-only settings: remove these on real AWS
    access_key                  = "test"
    secret_key                  = "test"
    use_path_style              = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_region_validation      = true
    endpoints = {
      s3 = "http://localhost:4566"
    }
  }
}