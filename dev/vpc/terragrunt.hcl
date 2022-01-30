terraform {
    source = "github.com/marquesmateus93/CloudGenesis//modules/vpc"
}

include {
  path = find_in_parent_folders()
}

dependency "tags" {
  config_path = "../tags"
}

locals {
  zones = read_terragrunt_config("../region.hcl")
}

inputs = {
  subnet_az = local.zones.locals.azs
  prefix_name = dependency.tags.outputs.prefix_name 
  account_id = dependency.tags.outputs.account_id
  email = dependency.tags.outputs.email
}