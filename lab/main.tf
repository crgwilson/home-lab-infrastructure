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
  mtu = 1500

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
  name   = "bridge_net_1"
  mode   = "bridge"
  bridge = var.bridge_interface
}

resource "libvirt_pool" "pool" {
  name = "domains"
  type = "dir"
  path = var.libvirt_pool_path
}

module "test_domain" {
  source = "../modules/libvirt_vm"

  name                  = "worker"
  description           = "For doing very important work, obviously"
  network_id            = libvirt_network.nat_net_1.id
  ip                    = "10.100.0.5"
  primary_volume_source = var.images.debian9
  secondary_volume_size = 21474836480

  module_depends_on     = [libvirt_pool.pool]
}
