variable "github_repo" {
  type        = string
  description = "Repositorio no formato usuario/nome"
}

variable "state_bucket_name" {
  type    = string
  default = "busdata-tfstate-126679583034"
}

variable "github_owner_id" {
  type        = string
  description = "ID numerico do dono do repositorio no GitHub"
}

variable "github_repo_id" {
  type        = string
  description = "ID numerico do repositorio no GitHub"
}