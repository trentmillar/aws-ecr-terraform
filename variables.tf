variable "region" {
  type = string
}

variable "repository_name" {
  type        = string
  description = "Name applied to the ECR repository"
  default     = "default"
}

variable "readers" {
  type    = list(string)
  default = []
}

variable "writers" {
  type    = list(string)
  default = []
}

variable "reader_writers" {
  type    = list(string)
  default = []
}
