variable "AZ" {
  type = string
  description = "availability zone"
  default = "us-east-1c"
}
variable "ebs_size" {
    type = number
    description = "taille ebs"
    default = 20
}
variable "projet_tag" {
    type = map(any)
    description = "common tag"
    default = {
        Name = "projet-terra"
    }
  
}