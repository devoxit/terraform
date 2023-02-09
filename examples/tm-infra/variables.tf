variable "tags" {
  type        = map(any)
  description = "Tag ressources"
  default     = { project = "tm-sim-1" }

}
