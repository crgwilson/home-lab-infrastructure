variable "domain" {
  description = "The domain to use when creating the libvirt nat network"
  type        = string
  default     = "home.garbage-day.dev"
}

variable "network_cidr" {
  description = "The subnet to use for the libvirt nat network"
  type        = string
  default     = "10.100.0.0/24"
}

variable "bridge_interface" {
  description = "The bridge interface which already exists on the libvirt host"
  type        = string
  default     = "br0"
}

variable "libvirt_pool_name" {
  description = "The name of the libvirt pool to create"
  type        = string
  default     = "domains"
}

variable "libvirt_pool_path" {
  description = "The file path of the libvirt pool to create"
  type        = string
  default     = "/home/cwilson/domains"
}

variable "images" {
  description = "All the qcow2 images to use when creating domains"
  type        = map
  default = {
    debian9  = "/home/cwilson/projects/images/debian9-4.2.20.qcow2"
    debian10 = "/home/cwilson/projects/images/debian10-2020-04-26.qcow2"
    centos8  = "/home/cwilson/projects/images/centos8-2020-04-26.qcow2"
  }
}
