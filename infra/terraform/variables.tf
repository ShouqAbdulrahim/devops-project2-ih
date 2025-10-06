variable "project_name" {
  type        = string
  description = "Project2 -SDA "
  default     = "devops-proj2-shouqds"
}

variable "location" {
  type        = string
  description = "Project2 -SDA-loc"
  default     = "southcentralus"
}

variable "address_space" {
  type        = list(string)
  description = "Vnet-project2"
  default     = ["10.20.0.0/16"]
}

  variable "appgw_id"        { type = string }
  variable "vm_frontend_id"  { type = string }
  variable "vm_backend_id"   { type = string }
  variable "sql_db_id"       { type = string }

variable "subnets" {
  description = "project2 - SDA "
  type = map(object({
    cidr = string
  }))
  default = {
    appgw    = { cidr = "10.20.0.0/24" }
    frontend = { cidr = "10.20.1.0/24" }
    backend  = { cidr = "10.20.2.0/24" }
    data     = { cidr = "10.20.3.0/24" }
    mgmt     = { cidr = "10.20.10.0/24" }
    bastion  = { cidr = "10.20.100.0/27" }
  }



}
