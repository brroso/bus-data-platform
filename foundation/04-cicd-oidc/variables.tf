variable "github_repo" {
  type        = string
  description = "Repositorio no formato usuario/nome"
}

variable "state_bucket_name" {
  type    = string
  default = "busdata-tfstate-126679583034"
}