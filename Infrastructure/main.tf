privider "aws" {
    region = "eu-west-1"
    profile = "aws-api-g"
}

module "network" {
    source = "./modules/network"
}