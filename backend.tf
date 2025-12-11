terraform {
  backend "s3" {
    bucket         = "komalpreet-terraform-state-bucket"
    key            = "prod/webserver/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "komalpreet-terraform-lock-table"
    encrypt        = true
  }
}
