module "network" {
    source = "./module/network"
    vpc_cidr = "10.0.0.0/24"
    subnet_cidr = "10.0.0.0/24"
  
}

module "compute" {
    source = "./module/compute"
    ami = "ami-0fef201115eefe936"
    instance_type = "t2.micro"
    subnet_id = module.network.subnet_id
}