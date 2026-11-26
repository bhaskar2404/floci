provider "aws" {
  region                      = var.region
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  # Remove this block to deploy to real AWS
  endpoints {
    ec2          = var.floci_endpoint
    eks          = var.floci_endpoint
    iam          = var.floci_endpoint
    sts          = var.floci_endpoint
    s3           = var.floci_endpoint
    logs         = var.floci_endpoint
    apigateway   = var.floci_endpoint
    apigatewayv2 = var.floci_endpoint
    route53      = var.floci_endpoint
  }

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
