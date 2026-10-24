variable "aws_region" {
  description = "AWS Region for the main infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name tag value"
  type        = string
  default     = "terraform-and-ansible-project"
}

variable "vpc_cidr" {
  description = "CIDR block of the  VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block of the public subnett)"
  type        = string
  default     = "10.0.1.0/24"
}


variable "public_key_path" {
  description = "Path to your SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "allowed_ssh_cidrs" {
  description = "CIDRs allowed to SSH, e.g. [\"41.33.10.5/32\"]"
  type        = list(string)
}
