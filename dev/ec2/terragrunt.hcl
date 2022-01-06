terraform {
    #source = "github.com/marquesmateus93/CloudGenesis//modules/ec2?ref=v0.0.3"
    #source = "github.com/marquesmateus93/CloudGenesis//modules/ec2"
    source = "../../../CloudGenesis/modules/ec2"
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
  ssh-public-key  = file("key_files/cloud_genesis_marques.pub")
  security_groups = [dependency.vpc.outputs.ec2_security_group_ssh,
                    dependency.vpc.outputs.ec2_security_group_http]
  public-subnet   = dependency.vpc.outputs.public_subnet_id
  
  prefix_name             = dependency.tags.outputs.prefix_name
  account_id              = "${get_aws_account_id()}"
  email                   = "marquesmateus1993@gmail.com"
}