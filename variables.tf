variable "region" {
  type    = string
}

variable "repository_name" {
  type = string
  description = "Name applied to the ECR repository"
}

variable "readers" {
  type    = list(string)
  default = []
}

variable "writers" {
  type    = list(string)
  default = []
}

variable "read_writers" {
  type    = list(string)
  default = []
}
