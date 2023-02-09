locals {
  tags = {
    created_by  = "terraform"
    created_for = "threat modeling simulation"
  }

  azs = {
    zones = slice(data.aws_availability_zone.azs, 0, var.availability_zone_count)
  }
}
