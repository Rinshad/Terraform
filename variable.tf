variable "rgname" {
    description = "resource grouop name"
    default     = "DevOps_Techies"
}
variable "location" {
    description = "location name"
    default     = "East Us"
}
variable "vnet_name" {
    description = "name for vnet"
    default     = "vm_vnet"
}
variable "address_space" {
     default     = ["10.0.0.0/16"]
}
variable "subnet_name" {
     default     = "public_subnet"
}
variable "address_prefix" {
      default     = "10.0.1.0/24"
}
variable "external_ip" {
    type        = list(string)
   default      = ["192.168.0.0"]
}
variable "numbercount" {
    type 	  = number
    default   = 3
} 
