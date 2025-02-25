variable "type_instance" {
    type = string
    description = "type d'instance"
    default = "t2.nano"
}
variable "AZ" {
  description = "availability zone"
  type = string
  default = "us-east-1c"
}
variable "key_name" {
  description = "name of private key"
  type = string
  default = "."
}
variable "projet_tag" {
    description = "tag projet"
    type = map(any)
    default = {
        Name = "mini-terra"
    }
  
}
variable "sg_list" {
  description = "list of securtity group"
  type = set(string)
  default = null

}
variable "ec2_user" {
    description = "user ec2"
    type = string
    default = "ubuntu"

  
}
variable "key_private" {
    description = "private.key"
    type = string
    default = "."
  
}
