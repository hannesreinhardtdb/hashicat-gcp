module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 3.4"

    project_id = var.project
    network_name = "gaurav-network"

   subnets = [
  {
    subnet_name   = "gaurav-subnet"
    subnet_ip     = "10.100.10.0/24"
    subnet_region = var.region
  }
] 
}