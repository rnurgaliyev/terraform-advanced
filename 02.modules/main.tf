# Image
resource "openstack_images_image_v2" "cirros" {
  name             = "cirros"
  image_source_url = "https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
}

module "mynet1" {
  source       = "./mynetwork"
  network_name = "my_net_A"
}

module "myserver1" {
  source      = "./myserver"
  server_name = "my_server_A"
  network_id  = "${module.mynet1.network_id}"
  image_id    = "${openstack_images_image_v2.cirros.id}"
}
