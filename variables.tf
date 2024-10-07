variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}
variable "name_project" {
  type        = string
  description = "Project name to be used to name the resources (name tag)"
}