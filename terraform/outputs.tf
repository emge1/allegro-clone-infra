output "frontend_url" {
  description = "Publiczny URL frontendu na Vercel"
  value       = vercel_project.frontend.production_url
}

output "project_id" {
  description = "ID projektu Vercel"
  value       = vercel_project.frontend.id
}
