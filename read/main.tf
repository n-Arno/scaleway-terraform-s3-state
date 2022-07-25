terraform {
  required_version = ">= 0.13"
}

data "terraform_remote_state" "scw" {
  backend = "s3"

  config = {
    bucket                      = "tf-state-arno"
    key                         = "terraform.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }

}

output "address" {
  value = data.terraform_remote_state.scw.outputs.address
}
