output "k6_public_ip" {
  value       = aws_instance.k6terraform.public_ip
}