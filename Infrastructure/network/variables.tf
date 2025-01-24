variable "vpc_cidr" {
    type = "string"
    default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
    type = map(string)
    default = {
        "one" = "10.0.0.0/24"
        "two" = "10.0.1.0/24"
    }
}
