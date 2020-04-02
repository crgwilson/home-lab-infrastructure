variable "domain" {
  type    = string
  default = "home.garbage-day.dev"
}

variable "network_cidr" {
  type    = string
  default = "10.100.0.0/24"
}

variable "bridge_interface" {
  type    = string
  default = "br0"
}

variable "libvirt_pool_path" {
  type    = string
  default = "/home/cwilson/domains"
}

variable "images" {
  type    = map
  default = {
    debian9 = "/Users/cwilson/projects/images/debian9-4.2.20.qcow2"
  }
}
