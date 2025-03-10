variable "vercel_api_token" {
  description = "Token API dla Vercel"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Nazwa projektu na Vercel"
  type        = string
}

variable "gui_repository_url" {
  description = "URL repozytorium Git"
  type        = string
}

variable "git_branch" {
  description = "Branch Git używany w Vercel"
  type        = string
  default     = "main"
}

variable "api_url" {
  description = "URL backendu, przekazywany do frontendu"
  type        = string
}
