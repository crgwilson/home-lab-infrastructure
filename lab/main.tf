##########################################################
# Lab Network
#   - Nat network so most VMs are behind a double NAT
#   - Bridge network for remote access (VPN gateway, etc)
#   - Libvirt pool for volume storage
#   - Misc VMs
##########################################################
provider "libvirt" {
  uri = "qemu+ssh://lab-local/system?socket=/var/run/libvirt/libvirt-sock"
}

resource "libvirt_network" "nat_net_1" {
  name      = "nat_net_1"
  mode      = "nat"
  domain    = var.domain
  autostart = true
  mtu       = 1500

  addresses = [
    var.network_cidr
  ]

  dns {
    enabled    = true
    local_only = false
    # hosts  {
    #     hostname = "my_hostname"
    #     ip = "my.ip.address.1"
    # }
    # routes {
    #     cidr = "10.17.0.0/16"
    #     gateway = "10.18.0.2"
    #   }
  }
}

resource "libvirt_network" "bridge_net_1" {
  name      = "bridge_net_1"
  mode      = "bridge"
  bridge    = var.bridge_interface
  autostart = true
}

resource "libvirt_pool" "pool" {
  name = var.libvirt_pool_name
  type = "dir"
  path = var.libvirt_pool_path
}

module "mytestdomain" {
  source = "../modules/libvirt_vm"

  machines = 0

  name        = "mytestdomain"
  description = "rip"
  autostart   = true
  network_id  = libvirt_network.nat_net_1.id
  # bridge = "br0"
  libvirt_pool_name     = var.libvirt_pool_name
  primary_volume_source = var.images.debian9

  module_depends_on = [libvirt_pool.pool]
}
