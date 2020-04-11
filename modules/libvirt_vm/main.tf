resource "libvirt_volume" "vol_1" {
  count  = var.machines
  name   = "${var.name}-${count.index + 1}-volume1"
  pool   = var.libvirt_pool_name
  source = var.primary_volume_source

  depends_on = [var.module_depends_on]
}

resource "libvirt_volume" "vol_2" {
  count  = var.machines
  name   = "${var.name}-${count.index + 1}-volume2"
  pool   = var.libvirt_pool_name
  format = "qcow2"
  size   = var.secondary_volume_size

  depends_on = [var.module_depends_on]
}

resource "libvirt_domain" "domain" {
  count = var.machines

  name        = "${var.name}-${count.index + 1}"
  description = var.description
  vcpu        = var.cpu_count
  memory      = var.memory
  running     = var.running
  autostart   = var.autostart

  disk {
    volume_id = libvirt_volume.vol_1[count.index].id
    scsi      = true
  }

  disk {
    volume_id = libvirt_volume.vol_2[count.index].id
    scsi      = true
  }

  network_interface {
    network_id     = var.network_id
    bridge         = var.bridge
    wait_for_lease = false
  }

  graphics {
    type        = "vnc"
    autoport    = true
    listen_type = "address"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}
