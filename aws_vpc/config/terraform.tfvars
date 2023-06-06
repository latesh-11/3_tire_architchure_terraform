vpc_config = {

    "VPC01" = {

        cidr_block = "192.168.0.0/16"

        tags = {
            Name = "my-vpc"
        }

    }

}

subnet_config = {

    "public-subnet-web-ap-northeast-1a" = {

        vpc_name = "VPC01"

        cidr_block = "192.168.0.0/19"

        availability_zone = "ap-northeast-1a"

        tags = {
            Name = "public-subnet-web-ap-northeast-1a"
        }
    }

    
    "public-subnet-web-ap-northeast-1d" = {

        vpc_name = "VPC01"

        cidr_block = "192.168.32.0/19"

        availability_zone = "ap-northeast-1d"

        tags = {
            Name = "public-subnet-web-ap-northeast-1d"
        }
    }

    "private-subnet-app-ap-northeast-1a" = {

        vpc_name = "VPC01"

        cidr_block = "192.168.64.0/19"

        availability_zone = "ap-northeast-1a"

        tags = {
            Name = "private-subnet-app-ap-northeast-1a"
        }
    }

    "private-subnet-app-ap-northeast-1d" = {

        vpc_name = "VPC01"

        cidr_block = "192.168.96.0/19"

        availability_zone = "ap-northeast-1d"

        tags = {
            Name = "private-subnet-app-ap-northeast-1d"
        }
    }

    "private-subnet-db-ap-northeast-1c" = {

        vpc_name = "VPC01"

        cidr_block = "192.168.128.0/19"

        availability_zone = "ap-northeast-1c"

        tags = {
            Name = "private-subnet-db-ap-northeast-1c"
        }
    }

    "private-subnet-db-ap-northeast-1d" = {

        vpc_name = "VPC01"

        cidr_block = "192.168.160.0/19"

        availability_zone = "ap-northeast-1d"

        tags = {
            Name = "private-subnet-db-ap-northeast-1d"
        }
    }
}

internetGW_config = {

    "IGW01" = {

        vpc_name = "VPC01"

        tags = {
            Name = "myinternetGW"
        }

    }

}

eip_config = {

    "eip01" = {
        tags = {
            Name = "eip01"
        }
    }

    "eip02" = {
        tags = {
            Name = "eip02"
        }
    }

    "eip03" = {
        tags = {
            Name = "eip03"
        }
    }
    "eip04" = {
        tags = {
            Name = "eip04"
        }
    }

}

natGW_config = {

    "NGW01" = {

        eip_name = "eip01"

        subnet_name = "public-subnet-web-ap-northeast-1a"

        tags = {
            Name = "NGW01"
        }

    }

    "NGW02" = {

        eip_name = "eip02"

        subnet_name = "public-subnet-web-ap-northeast-1d"

        tags = {
            Name = "NGW02"
        }

    }

    "NGW03" = {

        eip_name = "eip03"

        subnet_name = "public-subnet-web-ap-northeast-1a"

        tags = {
            Name = "NGW03"
        }

    }
    "NGW04" = {

        eip_name = "eip04"

        subnet_name = "public-subnet-web-ap-northeast-1d"

        tags = {
            Name = "NGW04"
        }

    }

}

route_table_config = {

    "RT01" = {

        private = 0 

        vpc_name = "VPC01"

        gateway_name = "IGW01"

        tags = {
            Name = "public_route_table"
        }
    }

    "RT02" = {

        private = 1

        vpc_name = "VPC01"

        gateway_name = "NGW01" 

        tags = {
            Name = "private_route_table"
        }

    }

    "RT03" = {
        private = 1

        vpc_name = "VPC01"

        gateway_name = "NGW02" 

        tags = {
            Name = "private_route_table"
        }

    }

    "RT04" = {
        private = 1

        vpc_name = "VPC01"

        gateway_name = "NGW03" 

        tags = {
            Name = "private_route_table"
        }

    }
    "RT05" = {
        private = 1

        vpc_name = "VPC01"

        gateway_name = "NGW04" 

        tags = {
            Name = "private_route_table"
        }

    }
}


route_table_association_config = {
    "RTAss01" = {
        subnet_name = "public-subnet-web-ap-northeast-1a"
        route_table_name = "RT01"
    }
    "RTAss02" = {
        subnet_name = "public-subnet-web-ap-northeast-1d"
        route_table_name = "RT01"
    }
    "RTAss03" = {
        subnet_name = "private-subnet-app-ap-northeast-1a"
        route_table_name = "RT02"
    }
    "RTAss04" = {
        subnet_name = "private-subnet-app-ap-northeast-1d"
        route_table_name = "RT03"
    }
    "RTAss05" = {
        subnet_name = "private-subnet-db-ap-northeast-1c"
        route_table_name = "RT04"
    }
    "RTAss06" = {
        subnet_name = "private-subnet-db-ap-northeast-1d"
        route_table_name = "RT05"
    }
}
ami_config = {

    "ami_ubuntu" = {
        ami_name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"

        ami_owner = "099720109477"
    }

    "ami_amazon_linux" = {
        ami_name = "amzn2-ami-hvm-*-x86_64-gp2"

        ami_owner = "amazon"
    }

}

key_name = "key-tf"


security_group_config = {

    "public_security_group" = {

        sg_name = "public_security_group"

        sg_description = "public_security_group"

        vpc_name = "VPC01"

        from_port = 0

        to_port = 0

        protocol = -1

        cidr_blocks = "0.0.0.0/0"

        tags = {
            Name = "public_security_group"
        }
    }

     "lb_security_group" = {

        sg_name = "lb_security_group"

        sg_description = "lb_security_group"

        vpc_name = "VPC01"

        from_port = 80

        to_port = 80

        protocol = "TCP"

        cidr_blocks = "0.0.0.0/0"

        tags = {
            Name = "lb_security_group"
    
        }
     }

     "rds_security_group" = {

        sg_name = "rds_security_group"

        sg_description = "rds_security_group"

        vpc_name = "VPC01"

        from_port = 3306

        to_port = 3306

        protocol = "TCP"

        cidr_blocks = "0.0.0.0/0"

        tags = {
            Name = "rds_security_group"
    
        }
     }



}

instance_config = {

    "jump_server" = {

        ami_name = "ami_amazon_linux"

        key_name = "key-tf"

        instance_type = "t2.micro"

        subnet_name = "public-subnet-web-ap-northeast-1a"

        security_group_name = "public_security_group"

        tags = {
            Name = "jump_server"
        }
    }

    "instance01" = {

        ami_name = "ami_amazon_linux"

        key_name = "key-tf"

        instance_type = "t2.micro"

        subnet_name = "private-subnet-app-ap-northeast-1a"

        security_group_name = "public_security_group"

        tags = {
            Name = "instance01"
        }
    }

    "instance02" = {

        ami_name = "ami_amazon_linux"

        key_name = "key-tf"

        instance_type = "t2.micro"

        subnet_name = "private-subnet-app-ap-northeast-1d"

        security_group_name = "public_security_group"

        tags = {
            Name = "instance02"
        }
    }

}



target_group_config = {

    "TG01" = {

        tg_name = "TG01"

        port = 80

        protocol = "HTTP"

        vpc_name = "VPC01"

    }

}

target_group_attach_config = {

   "TGAttach01" = {
        target_group_name = "TG01"

        instance_name = "instance01"

        port = 80
   }

    "TGAttach02" = {
        target_group_name = "TG01"

        instance_name = "instance02"

        port = 80
    }
}

loadbalancer_config = {

    "LB" = {

        lb_name = "LB"

        load_balancer_type = "application"

        security_group_name = "lb_security_group"

        subnet_name = ["public-subnet-web-ap-northeast-1a", "public-subnet-web-ap-northeast-1d"]


        tags  = {
            Environment = "production"
        }

    }

}

loadbalancer_listner_config = {

   "loadbalancer_listner" = {

        load_balancer_name = "LB"

        port = "80"

        protocol = "HTTP"

        action_type = "forward"

        target_group_name = "TG01"

   }
}

db_subnet_group_config = {

    "subnet_group01" = {
        subnet_group_name = "database_subnet"

        description = "subnet_group01"

        subnet_name = ["private-subnet-db-ap-northeast-1c" , "private-subnet-db-ap-northeast-1d"]

        tags = {
            Name = "subnet_group01"
        }

    }
}

db_config = {

    "db01" = {
        engine = "mysql"

        identifier = "rds01"

        storage_size = 20

        engine_version = "5.7"

        instance_class = "db.t2.micro"

        username = "latesh"

        password = "MTIzNDU2Nzg="

        parameter_group_name = "default.mysql5.7"

        security_group_name = "rds_security_group"

        subnet_group_name =   "subnet_group01"

        availability_zone = "ap-northeast-1d" 
    }

}