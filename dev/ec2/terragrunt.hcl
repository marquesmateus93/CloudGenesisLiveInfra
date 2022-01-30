terraform {
    source = "github.com/marquesmateus93/CloudGenesis//modules/ec2"
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

dependency "rds" {
  config_path = "../rds"
}

inputs = {
  ssh-public-key  = file("key_files/cloud_genesis_marques.pub")
  security_groups = [dependency.vpc.outputs.ec2_security_group_ssh,
                    dependency.vpc.outputs.ec2_security_group_http]
  public-subnet   = dependency.vpc.outputs.public_subnet_id
  
  prefix_name             = dependency.tags.outputs.prefix_name
  account_id              = "${get_aws_account_id()}"
  email                   = "marquesmateus1993@gmail.com"

  init_script = <<EOF
    #! /bin/bash

    sudo yum update -y
    sudo yum install httpd git -y
    sudo amazon-linux-extras install lamp-mariadb10.2-php7.2 php7.2 -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo usermod -a -G apache ec2-user
    sudo chown -R ec2-user:apache /var/www
    sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;

    git clone https://github.com/marquesmateus93/curso-kubernetes.git /var/www/html/;
    
    mysql \
    -u ${dependency.rds.outputs.rds_instance_username} \
    -p${dependency.rds.outputs.rds_instance_password} \
    -h ${dependency.rds.outputs.rds_instance_address} \
    -D${dependency.rds.outputs.rds_instance_db_name} \
    < /var/www/html/mysql/empresa_usuario.sql;
    
    mysql \
    -u ${dependency.rds.outputs.rds_instance_username} \
    -p${dependency.rds.outputs.rds_instance_password} \
    -h ${dependency.rds.outputs.rds_instance_address} \
    -D${dependency.rds.outputs.rds_instance_db_name} \
     < /var/www/html/mysql/empresa_noticias.sql;
    
    cat <<<'
      <?php

        $host     = "${dependency.rds.outputs.rds_instance_address}";
        $usuario  = "${dependency.rds.outputs.rds_instance_username}";
        $senha    = "${dependency.rds.outputs.rds_instance_password}";
        $banco    = "${dependency.rds.outputs.rds_instance_db_name}";

      ?>
    ' > /var/www/html/sistema/bancodedados.php;

  EOF
}