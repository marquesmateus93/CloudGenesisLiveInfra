terraform {
    source = "github.com/marquesmateus93/CloudGenesis//modules/tags"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  account_id = "${get_aws_account_id()}"
  email = "marquesmateus1993@gmail.com"
}