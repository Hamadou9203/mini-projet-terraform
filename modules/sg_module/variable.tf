variable "trust_IP" {
    type = set(string)
    description = "trusted IP"
    default = [ "0.0.0.0/0" ]
  
}
variable "sg_name" {
    type = string
    description = "name of securtity group"
    default = "sg-mini-terra"
  
}