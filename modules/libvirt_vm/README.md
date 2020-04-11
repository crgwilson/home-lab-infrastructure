# Terraform module: libvirt_vm

Build libvirt domains

## Requirements

* [terraform-libvirt provider plugin](https://github.com/dmacvicar/terraform-provider-libvirt)

## Providers

| Name | Version |
|------|---------|
| libvirt | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autostart | Whether or not the VM should be automatically started when the hypervisor is started | `bool` | `false` | no |
| bridge | The name of the bridge interface to use (Either this or network\_id must be set) | `string` | `null` | no |
| cpu\_count | The number of virtual CPUs which will be allocated | `number` | `1` | no |
| description | Description of the libvirt domain which will be created | `string` | n/a | yes |
| libvirt\_pool\_name | The name of the libvirt storage pool in which the domain will be created | `string` | n/a | yes |
| machines | The number of VMs to build | `number` | `1` | no |
| memory | The amount of memory (in mb) which will be allocated | `number` | `1024` | no |
| module\_depends\_on | https://www.terraform.io/docs/configuration/resources.html#depends_on-explicit-resource-dependencies | `any` | `""` | no |
| name | The name of the libvirt domain which will be created | `string` | n/a | yes |
| network\_id | The ID of the libvirt network to put this VM onto (Either this or bridge must be set) | `string` | `null` | no |
| primary\_volume\_source | The path leading to the primary image for the VM. This can be an HTTP URL, or a local file path | `string` | n/a | yes |
| running | Whether the VM should be on or off | `bool` | `true` | no |
| secondary\_volume\_size | The size (in bytes) of a second hard drive which will be created and attached to the VM | `number` | `10737418240` | no |

## Outputs

| Name | Description |
|------|-------------|
| domain\_ids | The ID of the created libvirt domain(s) |
| primary\_volume\_ids | The ID of the created root volume(s) |
| secondary\_volume\_ids | The ID of the created secondary volume(s) |

## Usage

Create a domain on a pre-existing nat network

```hcl
module "mynatexample" {
  source = "modules/libvirt_vm"

  machines = 1

  name = "mynatexample"

  description = "This is an example using a nat network"
  network_id  = libvirt_network.my_nat_network.id

  libvirt_pool_name     = "my_pool"
  primary_volume_source = var.my_qcow_image

  module_depends_on = [libvirt_pool.my_pool]
}
```

Create a domain using a pre-existing bridge interface

```hcl
module "mybridgeexample" {
  source = "modules/libvirt_vm"

  machines = 1

  name = "mybridgeexample"

  description = "This is an example using a bridge interface"
  bridge      = "br0"

  libvirt_pool_name     = "my_pool"
  primary_volume_source = var.my_qcow_image

  module_depends_on = [libvirt_pool.my_pool]
}
```
