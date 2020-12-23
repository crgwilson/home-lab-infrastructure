variable "aws_region" {
  type        = string
  description = "The AWS region to run in"
  default     = "us-east-1"
}

variable "pgp_key" {
  description = "The path to the public key used to encrypt sensitive data in the tf state file"
  type        = string
  default     = "files/tf.gpg"
}
