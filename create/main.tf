terraform {
  backend "s3" {
    bucket                      = "tf-state-arno"
    key                         = "terraform.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }

  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.2.0"
    }
  }
  required_version = ">= 0.13"
}

resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_server" "web" {
  type = "DEV1-S"
  image = "ubuntu_focal"
  ip_id = scaleway_instance_ip.public_ip.id
}

output "address" {
  value = scaleway_instance_ip.public_ip.address
}
