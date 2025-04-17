variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
}

variable "environment" {
  type        = string
  description = "Environment name: dev, prod"
}

# --- VPC ---
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones"
}

# --- EKS ---
variable "enable_eks" {
  type        = bool
  description = "Whether to deploy EKS"
  default     = false
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = ""
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.28"
}

# --- RDS ---
variable "db_name" {
  type        = string
  description = "Database name"
  default     = ""
}

variable "db_user" {
  type        = string
  description = "Database username"
  default     = ""
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
  default     = ""
}

# --- DNS / domains ---
variable "domain_name" {
  type        = string
  description = "Root domain (Route53)"
  default     = ""
}

variable "frontend_domain" {
  type        = string
  description = "Frontend subdomain (CloudFront)"
  default     = ""
}

# --- API (Helm) ---
variable "api_chart_version" {
  type        = string
  description = "Version of the API Helm chart"
  default     = "1.0.0"
}

# --- Secrets ---
variable "secrets" {
  type        = map(string)
  description = "Map of secrets to store in Secrets Manager"
  default     = {}
}
