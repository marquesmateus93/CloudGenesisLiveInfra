terraform {
  source = "github.com/marquesmateus93/CloudGenesis//modules/rds"
}

include {
  path = find_in_parent_folders()
}

dependency "tags" {
  config_path = "../tags"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  identifier_name   = "portal-noticias"
  database_name     = "portal_noticias"
  database_username = "admin"
  database_password = "1q2w3e4r5t"
  subnet_id         = dependency.vpc.outputs.private_subnet_id
  security_groups   = dependency.vpc.outputs.rds_security_group_mysql_id

  prefix_name       = dependency.tags.outputs.prefix_name 
  account_id        = dependency.tags.outputs.account_id
  email             = dependency.tags.outputs.email
}