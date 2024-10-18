variable "name_project" {
  type        = string
  description = "Project name to be used to name the resources (name tag)"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "oidc" {
  type        = string
  description = "HTTPS URL from OIDC provicer of the EKS cluster"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}