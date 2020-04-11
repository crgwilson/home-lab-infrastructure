# Home Lab Infrastructure

Terraform resources I use to manage my home lab running on a KVM host


## Modules

### libvirt_vm

Build a libvirt domain...

* On a pre-existing network
* With a pre-existing qcow2 image
* With a secondary volume


## Backend

I'm using a remote backend in Amazon S3 because thats just easier for me than having to self-host my terraform state
