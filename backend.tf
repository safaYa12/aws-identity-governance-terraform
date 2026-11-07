terraform {
  backend "s3" {
    bucket       = "terraform-state-s3-safayath"
    key          = "identity-governance/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
