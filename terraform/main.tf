module "aws_infrastructure" {
  source = "./aws"

  project_name = var.project_name
  aws_region   = var.aws_region
}

module "vercel_infrastructure" {
  source = "./vercel"

  project_name       = var.project_name
  gui_repository_url = var.gui_repository_url
}
