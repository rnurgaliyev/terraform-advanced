provider "openstack" {
  region = "dbl"
  alias  = "dbl"
}

provider "openstack" {
  region = "cbk"
  alias  = "cbk"
}

# Image CBK
resource "openstack_images_image_v2" "cirros_cbk" {
  provider         = "openstack.cbk"
  name             = "cirros"
  image_source_url = "https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
}

# Image DBL
resource "openstack_images_image_v2" "cirros_dbl" {
  provider         = "openstack.dbl"
  name             = "cirros"
  image_source_url = "https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
}

module "mynet_cbk" {
  source       = "./mynetwork"
  network_name = "my_net_cbk"
  region       = "cbk"
}

module "myserver_cbk" {
  source      = "./myserver"
  server_name = "my_server_cbk"
  network_id  = "${module.mynet_cbk.network_id}"
  image_id    = "${openstack_images_image_v2.cirros_cbk.id}"
  region      = "cbk"
}

module "mynet_dbl" {
  source       = "./mynetwork"
  network_name = "my_net_dbl"
  region       = "dbl"
}

module "myserver_dbl" {
  source      = "./myserver"
  server_name = "my_server_dbl"
  network_id  = "${module.mynet_dbl.network_id}"
  image_id    = "${openstack_images_image_v2.cirros_dbl.id}"
  region      = "dbl"
}
