variable "alert_email" {
  type        = string
  description = "E-mail que recebe os alertas de custo"
}

variable "monthly_limit_usd" {
  type        = number
  description = "Orcamento mensal total em dolares"
  default     = 20
}