module "vpc_module" {

  source = "./modules/aws_vpc"

  for_each = var.vpc_config

  cidr_block = each.value.cidr_block

  tags = each.value.tags

}
module "subnet_module" {

  source = "./modules/aws_subnet"

  for_each = var.subnet_config

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

  cidr_block = each.value.cidr_block

  tags = each.value.tags

  availability_zone = each.value.availability_zone
}

module "internetGW_modle" {

  source = "./modules/aws_internetGW"

  for_each = var.internetGW_config

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

  tags = each.value.tags

}

module "eip_module" {

  source = "./modules/aws_elastic_ip"

  for_each = var.eip_config

  tags = each.value.tags

}

module "natGW_module" {

  source = "./modules/aws_natGW"

  for_each = var.natGW_config

  eip_id = module.eip_module[each.value.eip_name].eip_id

  subnet_id = module.subnet_module[each.value.subnet_name].subnet_id

  tags = each.value.tags

}


module "route_table_module" {

  source = "./modules/aws_route_table"

  for_each = var.route_table_config

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

  gateway_id = each.value.private == 0 ? module.internetGW_modle[each.value.gateway_name].internetGW_id : module.natGW_module[each.value.gateway_name].natGW_id

  tags = each.value.tags


}

module "route_table_association_module" {

  source = "./modules/aws_route_table_association"

  for_each = var.route_table_association_config

  subnet_id = module.subnet_module[each.value.subnet_name].subnet_id

  route_table_id = module.route_table_module[each.value.route_table_name].route_table_id
}

module "ami_module" {

  source = "./modules/aws_ami"

  for_each = var.ami_config

  ami_name = each.value.ami_name

  ami_owner = each.value.ami_owner

}

module "key_pair_module" {

  source = "./modules/aws_key_pair"

  key_name = var.key_name

}

module "security_group_module" {

  source = "./modules/aws_security_group"

  for_each = var.security_group_config

  sg_name = each.value.sg_name

  sg_description = each.value.sg_description

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

  from_port = each.value.from_port

  to_port = each.value.to_port

  protocol = each.value.protocol

  cidr_blocks = each.value.cidr_blocks

  tags = each.value.tags

}

module "instance_module" {

  source = "./modules/aws_instance"

  for_each = var.instance_config

  ami_id = module.ami_module[each.value.ami_name].ami_id

  key_name = each.value.key_name

  instance_type = each.value.instance_type

  subnet_id = module.subnet_module[each.value.subnet_name].subnet_id

  security_group_id = module.security_group_module[each.value.security_group_name].security_group_id

  tags = each.value.tags
}

#==============LOAD BALANCER============#

module "target_group_module" {
  
  source = "./modules/aws_target_group"

  for_each = var.target_group_config

  tg_name = each.value.tg_name

  port = each.value.port 

  protocol = each.value.protocol

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

}
module "target_group_attach_module" {

  source = "./modules/aws_target_group_attach"

  for_each = var.target_group_attach_config
  
  target_group_arn = module.target_group_module[each.value.target_group_name].target_group_arn

  instance_id = module.instance_module[each.value.instance_name].instance_id

  port = each.value.port

}
module loadbalancer_module {
  
  source = "./modules/aws_loadbalancer"

  for_each = var.loadbalancer_config

  lb_name = each.value.lb_name

  load_balancer_type = each.value.load_balancer_type

  security_groups = module.security_group_module[each.value.security_group_name].security_group_id

  subnets = [
    for subnet_name in each.value.subnet_name : module.subnet_module[subnet_name].subnet_id
  ]


  tags = each.value.tags

}
module "loadbalancer_listner_module" {

  source = "./modules/aws_loadbalancer_listner"

  for_each = var.loadbalancer_listner_config

  load_balancer_arn = module.loadbalancer_module[each.value.load_balancer_name].load_balancer_arn

  port = each.value.port

  protocol = each.value.protocol

  action_type = each.value.action_type

  target_group_arn = module.target_group_module[each.value.target_group_name].target_group_arn
  
}

module "db_subnet_group_module" {

    source = "./modules/aws_subnet_groups"

    for_each = var.db_subnet_group_config


    subnet_group_name = each.value.subnet_group_name

    subnet_ids =  [
    for subnet_name in each.value.subnet_name : module.subnet_module[subnet_name].subnet_id
  ]
    description = each.value.description

    tags = each.value.tags
}

module "db_module" {
  
  source = "./modules/aws_rds"

  for_each = var.db_config

  engine = each.value.engine

  identifier = each.value.identifier

  storage_size  = each.value.storage_size

  engine_version = each.value.engine_version

  instance_class = each.value.instance_class

  username = each.value.username

  password = each.value.password

  parameter_group_name = each.value.parameter_group_name

  db_subnet_group_name = module.db_subnet_group_module[each.value.subnet_group_name].subnet_group_name

  vpc_security_group_ids = module.security_group_module[each.value.security_group_name].security_group_id

  availability_zone = each.value.availability_zone
}

