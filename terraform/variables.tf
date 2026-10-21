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
