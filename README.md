# CloudGenesisLiveInfra

## Description

This is a demo project to take a quick demonstration of my Terragrunt modules knowledge. This project consumes modules from [CloudGenesis](https://github.com/marquesmateus93/CloudGenesis) repository.

## Environment Folder

- **dev:** Weak resources machine configuration and more insecure level.

## Resources

- **Tags:** Gets the AWS Account ID to concat with each resource tag.

- **VPC:** Creates one VPC with two subnets(public and private). The public network provides external access, mainly to application. Private network provides communication between application server and database.

- **RDS:** Simple MySQL database without external access.

- **EC2:** Auto configurable application envarioment and database connection.

## Requirements

<img align="left" height="20px" width="20px" alt="Warpnet" src="https://symbols.getvecta.com/stencil_97/45_terraform-icon.0fedccc574.png"/> **Terraform Version:** 0.14.6

<img align="left" height="20px" width="20px" alt="Warpnet" src="https://files.helpdocs.io/kw8ldg1itf/other/1618866969753/terragrunt.png"/> **Terragrunt Version:** 0.27.4

<img align="left" height="20px" width="20px" alt="Warpnet" src="https://cdn-icons-png.flaticon.com/512/2089/2089795.png"/> **Git-Crypt Version:** 0.6.0
## How To Run

Apply the modules in followed order:
```
Tags > VPC > RDS > EC2
```
1. The SSH file inside EC2/keys folder is encrypted. You can contact admin repository  to request your GCP Key inclusion and perform the decryption  or just generate new key pair to replace.