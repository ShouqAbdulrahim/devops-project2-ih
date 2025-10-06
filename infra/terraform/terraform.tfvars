project_name  = "devops-proj2-shouq"
location      = "South Central US"

address_space = ["10.30.0.0/16"]

appgw_id       = "/subscriptions/.../resourceGroups/devops-proj2-shouq-rg/providers/Microsoft.Network/applicationGateways/devops-proj2-shouq-appgw"
vm_frontend_id = "/subscriptions/.../resourceGroups/devops-proj2-shouq-rg/providers/Microsoft.Compute/virtualMachines/devops-proj2-shouq-vm-frontend"
vm_backend_id  = "/subscriptions/.../resourceGroups/devops-proj2-shouq-rg/providers/Microsoft.Compute/virtualMachines/devops-proj2-shouq-vm-backend"
sql_db_id      = "/subscriptions/.../resourceGroups/devops-proj2-shouq-rg/providers/Microsoft.Sql/servers/devops-proj2-shouq-sqlsrv/databases/devops-proj2-shouq-db"


subnets = {
  appgw    = { cidr = "10.30.0.0/24" }
  frontend = { cidr = "10.30.1.0/24" }
  backend  = { cidr = "10.30.2.0/24" }
  data     = { cidr = "10.30.3.0/24" }
  mgmt     = { cidr = "10.30.10.0/24" }
  bastion  = { cidr = "10.30.100.0/27" }
}
