locals{
  region_var  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region_name = local.region_var.locals.region
}

generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
        provider "aws" {
          region     = "${local.region_name}"
        }
    EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "marques-terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region_name}"
    encrypt        = true
    dynamodb_table = "marques-lock-table"
  }
}