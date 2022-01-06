terraform {
    #source = "github.com/marquesmateus93/CloudGenesis//modules/ec2?ref=v0.0.3"
    #source = "github.com/marquesmateus93/CloudGenesis//modules/ec2"
    source = "../../../CloudGenesis/modules/tags"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  account_id = "${get_aws_account_id()}"
  email = "marquesmateus1993@gmail.com"
}