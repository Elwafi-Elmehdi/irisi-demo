
variable "aws_region" {
  default = "eu-west-3"
  type    = string
}

variable "ssh_public_key_path" {
  default     = "~/.ssh/irisi.pub"
  description = "The SSH public key path"
}