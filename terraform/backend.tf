terraform {
  required_version = ">= 1.10.0"
  backend "s3" {
    bucket       = "team2-devops-lab-tfstate-2026-barq" 
    key          = "devops-lab/terraform.tfstate"
    region       = "us-east-1"           
    encrypt      = true
    use_lockfile = true 
  }
}
