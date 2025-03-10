output "reverse_proxy_public_ip" {
  description = "Public IP address for reverse proxy"
  value = aws_instance.reverse_proxy.public_ip
}

output "reverse_proxy_instance_id" {
  description = "Reverse proxy instance ID"
  value = aws_instance.reverse_proxy.id
}