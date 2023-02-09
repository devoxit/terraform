variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for VPC"
}

variable "ressource_identifer" {
  type        = string
  description = "Ressource Identifier"
  default     = "tm-tr-yf"
}

variable "public_subnets" {
  type        = list(any)
  description = "Public subnets CIDR"
}


variable "availability_zone_count" {
  type        = number
  description = "Availability zones needed"
  default     = 1
}
