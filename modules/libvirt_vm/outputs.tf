output "primary_volume_ids" {
  description = "The ID of the created root volume(s)"
  value       = libvirt_volume.vol_1.*.id
}

output "secondary_volume_ids" {
  description = "The ID of the created secondary volume(s)"
  value       = libvirt_volume.vol_2.*.id
}

output "domain_ids" {
  description = "The ID of the created libvirt domain(s)"
  value       = libvirt_domain.domain.*.id
}
