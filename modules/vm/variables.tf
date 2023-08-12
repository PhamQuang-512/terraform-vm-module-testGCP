variable "project" {
  type        = string
  description = "Project id"
  default     = "prismatic-petal-395711"
}

variable "region" {
  type        = string
  description = "Region of resource"
  default     = "asia-east1"
}

variable "zone" {
  type        = string
  description = "Zone of resource"
  default     = "asia-east1-b"
}

variable "vm-name" {
  type        = string
  description = "Name of vm instance"
}

variable "network-name" {
  type        = string
  description = "Name of the network"
}

variable "boot-image" {
  type        = string
  description = "Image of vm instance"
  default     = "ubuntu-2004-focal-v20230724"
}
