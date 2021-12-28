terraform {
    #source = "github.com/marquesmateus93/CloudGenesis//modules/ec2?ref=v0.0.3"
    #source = "github.com/marquesmateus93/CloudGenesis//modules/ec2"
    source = "../../../CloudGenesis/modules/ec2"
}

include {
  path = find_in_parent_folders()
}

locals {
  zones = read_terragrunt_config("../region.hcl")
}

inputs = {
  ssh-key = file("key_files/cloud_genesis_marques")

  azs = local.zones.locals.azs
  account_id = "${get_aws_account_id()}"
  email = "marquesmateus1993@gmail.com"
}