output "backend_instance_id" {
  description = "Backend instance ID"
  value       = aws_instance.backend.id
}

output "backend_private_ip" {
  description = "Private backend IP address"
  value       = aws_instance.backend.private_ip
}
