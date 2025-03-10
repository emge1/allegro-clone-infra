terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "0.6.0"
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_token
}

resource "vercel_project" "frontend" {
  name       = var.project_name
  git        = {
    repo    = var.gui_repository_url
    branch  = var.git_branch
    enabled = true
  }
  framework = "create-react-app"
  environment_variables = {
    REACT_APP_API_URL = var.api_url
  }

  build_command  = "npm run build"
  output_dir     = "build"
  install_command = "npm install"
}

resource "vercel_environment_variable" "custom_variable" {
  project_id = vercel_project.frontend.id
  key        = "CUSTOM_ENV_VAR"
  value      = "custom_value"
  target     = ["preview", "production"]
}
