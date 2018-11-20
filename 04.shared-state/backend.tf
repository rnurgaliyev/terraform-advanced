terraform {
  backend "s3" {
    bucket                      = "rnu-tfstate"
    key                         = "infra.tfstate"
    endpoint                    = "s3.dbl.cloud.syseleven.net"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
