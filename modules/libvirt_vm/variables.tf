variable "name" {
  description = "The name of the libvirt domain which will be created"
  type        = string
}

variable "machines" {
  description = "The number of VMs to build"
  type        = number
  default     = 1
}

variable "description" {
  description = "Description of the libvirt domain which will be created"
  type        = string
}

variable "cpu_count" {
  description = "The number of virtual CPUs which will be allocated"
  type        = number
  default     = 1
}

variable "memory" {
  description = "The amount of memory (in mb) which will be allocated"
  type        = number
  default     = 1024
}

variable "running" {
  description = "Whether the VM should be on or off"
  type        = bool
  default     = true
}

variable "autostart" {
  description = "Whether or not the VM should be automatically started when the hypervisor is started"
  type        = bool
  default     = false
}

variable "network_id" {
  description = "The ID of the libvirt network to put this VM onto"
  type        = string
}

variable "ip" {
  description = "The DHCP address which should be allocated to the created VM (this will be incremented if machines is > 1)"
  type        = string
}

variable "libvirt_pool_name" {
  description = "The name of the libvirt storage pool in which the domain will be created"
  type        = string
  default     = "domains"
}

variable "primary_volume_source" {
  description = "The path leading to the primary image for the VM. This can be an HTTP URL, or a local file path"
  type        = string
}

variable "secondary_volume_size" {
  description = "The size (in bytes) of a second hard drive which will be created and attached to the VM"
  type        = number
  default     = 10737418240
}

variable "module_depends_on" {
  description = "https://www.terraform.io/docs/configuration/resources.html#depends_on-explicit-resource-dependencies"
  type        = any
  default     = ""
}
