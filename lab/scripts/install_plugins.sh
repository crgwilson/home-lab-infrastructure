#!/usr/bin/env bash

go get -u github.com/dmacvicar/terraform-provider-libvirt
mkdir -p .terraform/plugins/darwin_amd64/
cp "$GOPATH/bin/terraform-provider-libvirt" .terraform/plugins/darwin_amd64/
