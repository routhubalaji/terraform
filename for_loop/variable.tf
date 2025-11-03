variable instances {
    #default = ["mongodb", "redis","mysql","rabbitmq","apache"]
    #type    = map(string)
    default = {
        mongodb = "t3.micro"
        redis = "t3.micro"
        mysql = "t3.small"
    }
}

variable zone_id {
    default = "Z00096053IAN08VBICYDC"
}

variable domain_name {
    default = "daws86s.lat"
}

