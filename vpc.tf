module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 3.4"

    project_id = var.project
    network_name = "khr-network"
    routing_mode = "GLOBAL"

   subnets = [
  {
    subnet_name   = "khr-subnet"
    subnet_ip     = "10.100.10.0/24"
    subnet_region = var.region
          },
        {
            subnet_name           = "khr-subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = var.region
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
        {
            subnet_name               = "khr-subnet-03"
            subnet_ip                 = "10.10.30.0/24"
            subnet_region             = var.region
            subnet_flow_logs          = "true"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
            subnet_flow_logs_sampling = 0.7
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        }
    ]

    

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
        {
            name                   = "khr-app-proxy"
            description            = "route through proxy to reach app"
            destination_range      = "10.50.10.0/24"
            tags                   = "khr-app-proxy"
            next_hop_instance      = "khr-app-proxy-instance"
            next_hop_instance_zone = var.zone
        },
    ]
}