# Variables
variable "server_name" {
  type    = "string"
  default = "terralab"
}

variable "network_id" {
  type = "string"
}

variable "image_id" {
  type = "string"
}

variable "region" {
  type = "string"
}

# Provider
provider "openstack" {
  region = "${var.region}"
}

# External network reference
data "openstack_networking_network_v2" "ext_net" {
  name = "ext-net"
}

# Instance
resource "openstack_compute_instance_v2" "terralab" {
  name        = "${var.server_name}"
  image_id    = "${var.image_id}"
  flavor_name = "m1.micro"

  network {
    uuid = "${var.network_id}"
  }
}

# Floating IP
resource "openstack_compute_floatingip_v2" "terralab" {
  pool = "${data.openstack_networking_network_v2.ext_net.name}"
}

# Floating IP assoctiation
resource "openstack_compute_floatingip_associate_v2" "terralab" {
  floating_ip = "${openstack_compute_floatingip_v2.terralab.address}"
  instance_id = "${openstack_compute_instance_v2.terralab.id}"
}

# Server output
output "server_ip" {
  value = "${openstack_compute_floatingip_v2.terralab.address}"
}
