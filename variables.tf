variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# optional variable to point to your public key path on disk
variable "ssh_public_key_path" {
  description = "Path to local SSH public key to upload"
  type        = string
  default = "/c/Users/91820/.ssh/exam_key.pub"
}
