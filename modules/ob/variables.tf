
variable "ssh_keypair" {
  type = string
}

variable "vpc" {
  type = any
}

variable "sg" {
  type = any
}

variable "namespace" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.xlarge"
}
