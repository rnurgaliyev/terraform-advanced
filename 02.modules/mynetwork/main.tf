# Variables
variable "network_name" {
  type    = "string"
  default = "terralab"
}

# Network
resource "openstack_networking_network_v2" "terralab" {
  name = "${var.network_name}"
}

# Subnet
resource "openstack_networking_subnet_v2" "terralab" {
  name       = "${var.network_name}"
  network_id = "${openstack_networking_network_v2.terralab.id}"
  cidr       = "10.10.0.0/24"
}

# External network reference
data "openstack_networking_network_v2" "ext_net" {
  name = "ext-net"
}

# Router
resource "openstack_networking_router_v2" "terralab" {
  name                = "${var.network_name}_router"
  external_network_id = "${data.openstack_networking_network_v2.ext_net.id}"
}

# Router port
resource "openstack_networking_router_interface_v2" "terralab" {
  router_id = "${openstack_networking_router_v2.terralab.id}"
  subnet_id = "${openstack_networking_subnet_v2.terralab.id}"
}

# Network output
output "network_id" {
  value = "${openstack_networking_network_v2.terralab.id}"
}
